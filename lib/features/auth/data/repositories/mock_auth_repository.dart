import 'dart:async';
import '../student_database.dart';
import '../../domain/models/user_model.dart';
import '../../domain/repositories/auth_repository.dart';

class MockAuthRepository implements AuthRepository {
  final _controller = StreamController<UserModel?>.broadcast();
  UserModel? _currentUser;

  MockAuthRepository();

  @override
  Stream<UserModel?> get authStateChanges => _controller.stream;

  @override
  Future<UserModel?> getCurrentUser() async => _currentUser;

  @override
  Future<UserModel> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final cleanInput = email.trim().toLowerCase();
    final cleanPass = password.trim();

    // 1. Check Demo1 Account
    if (cleanInput == 'demo1' || cleanInput == 'demo1@knowup.edu.tr') {
      _currentUser = const UserModel(
        uid: 'demo1',
        email: 'demo1@knowup.edu.tr',
        displayName: 'Demo1',
        role: UserRole.student,
        groupId: 'BGT1',
        studentNo: 'demo1',
        grade: 1,
        isDemo: true,
      );
      _controller.add(_currentUser);
      return _currentUser!;
    }

    // 2. Check Demo2 Account
    if (cleanInput == 'demo2' || cleanInput == 'demo2@knowup.edu.tr') {
      _currentUser = const UserModel(
        uid: 'demo2',
        email: 'demo2@knowup.edu.tr',
        displayName: 'Demo2',
        role: UserRole.student,
        groupId: 'BGT2',
        studentNo: 'demo2',
        grade: 2,
        isDemo: true,
      );
      _controller.add(_currentUser);
      return _currentUser!;
    }

    // 3. Check Teacher / Admin Account
    if (cleanInput == 'hoca' || cleanInput == 'admin' || cleanInput.contains('hoca@')) {
      _currentUser = const UserModel(
        uid: 'teacher_admin',
        email: 'hoca@knowup.edu.tr',
        displayName: 'Dr. Süleyman Hoca',
        role: UserRole.teacher,
        groupId: 'ALL',
        studentNo: 'hoca',
        grade: 1,
        isDemo: true,
      );
      _controller.add(_currentUser);
      return _currentUser!;
    }

    // 4. Search CSV Student Records
    final matchedRecord = allStudentRecords.firstWhere(
      (s) =>
          s.studentNo.toLowerCase() == cleanInput ||
          s.email.toLowerCase() == cleanInput ||
          (cleanInput.length >= 8 && s.studentNo.contains(cleanInput)),
      orElse: () => const StudentRecord(
        studentNo: '',
        tcFirst5: '',
        fullName: '',
        email: '',
        grade: 0,
        groupId: '',
        program: '',
      ),
    );

    if (matchedRecord.studentNo.isNotEmpty) {
      // Password check: TC First 5 digits (or default dev pass 123456)
      if (cleanPass == matchedRecord.tcFirst5 || cleanPass == '123456' || cleanPass.isEmpty) {
        _currentUser = matchedRecord.toUserModel();
        _controller.add(_currentUser);
        return _currentUser!;
      } else {
        throw Exception('Şifre hatalı! T.C. Kimlik numaranızın İLK 5 HANESİNİ giriniz.');
      }
    }

    // 5. Fallback for dynamic student numbers starting with 26 (1st grade) or 25/24/23 (2nd grade)
    if (cleanInput.startsWith('26')) {
      _currentUser = UserModel(
        uid: 'student_$cleanInput',
        email: '$cleanInput@knowup.edu.tr',
        displayName: 'Öğrenci ($cleanInput)',
        role: UserRole.student,
        groupId: 'BGT1',
        studentNo: cleanInput,
        grade: 1,
        isDemo: false,
      );
      _controller.add(_currentUser);
      return _currentUser!;
    } else if (cleanInput.startsWith('25') || cleanInput.startsWith('24') || cleanInput.startsWith('23')) {
      _currentUser = UserModel(
        uid: 'student_$cleanInput',
        email: '$cleanInput@knowup.edu.tr',
        displayName: 'Öğrenci ($cleanInput)',
        role: UserRole.student,
        groupId: 'BGT2',
        studentNo: cleanInput,
        grade: 2,
        isDemo: false,
      );
      _controller.add(_currentUser);
      return _currentUser!;
    }

    throw Exception('Giriş başarısız. Öğrenci numaranızı veya kayıtlı e-postanızı kontrol ediniz.');
  }

  @override
  Future<UserModel> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String displayName,
    UserRole role = UserRole.student,
  }) async {
    _currentUser = UserModel(
      uid: 'user_${DateTime.now().millisecondsSinceEpoch}',
      email: email,
      displayName: displayName,
      role: role,
      groupId: 'BGT1',
      studentNo: email.split('@').first,
      grade: 1,
      isDemo: false,
    );
    _controller.add(_currentUser);
    return _currentUser!;
  }

  @override
  Future<void> signOut() async {
    _currentUser = null;
    _controller.add(null);
  }
}
