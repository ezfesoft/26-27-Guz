enum UserRole {
  student,
  teacher;

  static UserRole fromString(String value) {
    return value.toLowerCase() == 'teacher' ? UserRole.teacher : UserRole.student;
  }

  String toJson() => name;
}

class UserModel {
  final String uid;
  final String email;
  final String displayName;
  final UserRole role;
  final String groupId; // 'BGT1', 'BGT2', 'TVT2', 'ALL'
  final DateTime? createdAt;
  final String? studentNo;
  final int grade; // 1 (1. Sınıf / 26 girişliler) or 2 (2. Sınıf / 25,24,23)
  final bool isDemo; // Demo accounts (Demo1, Demo2) excluded from leaderboards

  const UserModel({
    required this.uid,
    required this.email,
    required this.displayName,
    this.role = UserRole.student,
    this.groupId = 'BGT1',
    this.createdAt,
    this.studentNo,
    this.grade = 1,
    this.isDemo = false,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] as String? ?? '',
      email: json['email'] as String? ?? '',
      displayName: json['displayName'] as String? ?? '',
      role: UserRole.fromString(json['role'] as String? ?? 'student'),
      groupId: json['groupId'] as String? ?? 'BGT1',
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'].toString())
          : null,
      studentNo: json['studentNo'] as String?,
      grade: json['grade'] as int? ?? 1,
      isDemo: json['isDemo'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'role': role.toJson(),
      'groupId': groupId,
      'createdAt': createdAt?.toIso8601String(),
      'studentNo': studentNo,
      'grade': grade,
      'isDemo': isDemo,
    };
  }

  UserModel copyWith({
    String? uid,
    String? email,
    String? displayName,
    UserRole? role,
    String? groupId,
    DateTime? createdAt,
    String? studentNo,
    int? grade,
    bool? isDemo,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      role: role ?? this.role,
      groupId: groupId ?? this.groupId,
      createdAt: createdAt ?? this.createdAt,
      studentNo: studentNo ?? this.studentNo,
      grade: grade ?? this.grade,
      isDemo: isDemo ?? this.isDemo,
    );
  }
}
