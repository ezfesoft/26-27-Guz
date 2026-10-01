import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app/theme/app_theme.dart';
import '../../../auth/data/student_database.dart';
import '../../../auth/domain/models/user_model.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../courses/data/mock_course_data.dart';
import '../providers/gamification_provider.dart';

class LeaderboardUser {
  final String id;
  final String studentNo;
  final String publicName;
  final String group;
  final int grade; // 1 or 2
  final Map<String, int> courseXp; // Map<courseId, xpAmount>

  const LeaderboardUser({
    required this.id,
    required this.studentNo,
    required this.publicName,
    required this.group,
    required this.grade,
    required this.courseXp,
  });

  int get totalXp => courseXp.values.fold(0, (sum, val) => sum + val);

  int getXpForCourse(String courseId) {
    if (courseId == 'ALL') return totalXp;
    return courseXp[courseId] ?? 0;
  }
}

class LeaderboardScreen extends ConsumerStatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  ConsumerState<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends ConsumerState<LeaderboardScreen> {
  String _selectedCourseId = 'ALL';
  int _selectedGradeTab = 1; // 1: 1. Sınıf (26 Girişliler), 2: 2. Sınıf (25/24/23)

  late List<LeaderboardUser> _baseLeaderboardUsers;

  static String formatPublicName(String fullName) {
    final parts = fullName.trim().split(RegExp(r'\s+'));
    if (parts.length <= 1) return fullName;
    final lastName = parts.last;
    final firstNames = parts.sublist(0, parts.length - 1).join(' ');
    final lastInitial = lastName.isNotEmpty ? '${lastName[0].toUpperCase()}.' : '';
    return '$firstNames $lastInitial';
  }

  @override
  void initState() {
    super.initState();
    // Everyone starts with 0 XP initially as requested!
    _baseLeaderboardUsers = allStudentRecords.map((s) {
      return LeaderboardUser(
        id: s.studentNo,
        studentNo: s.studentNo,
        publicName: formatPublicName(s.fullName),
        group: s.grade == 1 ? '1. Sınıf' : '2. Sınıf',
        grade: s.grade,
        courseXp: {
          'gorsel_programlama': 0,
          'mesleki_matematik': 0,
          'ntp2': 0,
          'siber_guvenlik': 0,
          'veri_madenciligi': 0,
          'saglikta_yapay_zeka': 0,
        },
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(currentUserProvider);
    final isTeacher = currentUser?.role == UserRole.teacher;
    final currentXp = ref.watch(gamificationProvider).xp;
    final isMobile = MediaQuery.of(context).size.width < 600;

    // Filter out demo users (Demo1, Demo2, Teacher) from appearing in the leaderboard ranking!
    final isCurrentUserDemo = currentUser?.isDemo ?? true;

    // Courses list for filter chips (excluding any test course)
    final availableCourses = mockCourses.where((c) => c.id != 'test_course').toList();

    // Map list and inject current user's live XP if logged in as a real student
    final processedList = _baseLeaderboardUsers.map((u) {
      if (currentUser != null &&
          !isCurrentUserDemo &&
          currentUser.studentNo != null &&
          u.studentNo == currentUser.studentNo) {
        final updatedMap = Map<String, int>.from(u.courseXp);
        if (_selectedCourseId != 'ALL' && updatedMap.containsKey(_selectedCourseId)) {
          updatedMap[_selectedCourseId] = currentXp;
        } else {
          updatedMap['gorsel_programlama'] = currentXp;
        }
        return LeaderboardUser(
          id: u.id,
          studentNo: u.studentNo,
          publicName: '${formatPublicName(currentUser.displayName)} (Siz)',
          group: u.group,
          grade: u.grade,
          courseXp: updatedMap,
        );
      }
      return u;
    }).toList();

    // Filtering by grade & course:
    // Rule: 1st grade courses (gorsel_programlama, mesleki_matematik)
    // MUST ONLY show 26-entry students (grade == 1)!
    final selectedCourse = availableCourses.firstWhere(
      (c) => c.id == _selectedCourseId,
      orElse: () => availableCourses.first,
    );

    final is1stGradeCourseSelected = _selectedCourseId == 'gorsel_programlama' || _selectedCourseId == 'mesleki_matematik';
    final is2ndGradeCourseSelected = _selectedCourseId == 'ntp2' || _selectedCourseId == 'siber_guvenlik' || _selectedCourseId == 'veri_madenciligi' || _selectedCourseId == 'saglikta_yapay_zeka';

    List<LeaderboardUser> filteredList;

    if (is1stGradeCourseSelected) {
      // 1. Sınıf dersleri için SADECE 26 girişliler (1. Sınıf)
      filteredList = processedList.where((u) => u.grade == 1).toList();
    } else if (is2ndGradeCourseSelected) {
      // 2. Sınıf özel dersleri için 2. sınıflar
      filteredList = processedList.where((u) => u.grade == 2).toList();
    } else {
      // Genel "ALL" tab -> Tab seçimine göre filtrelenir (1. Sınıf vs 2. Sınıf)
      filteredList = processedList.where((u) => u.grade == _selectedGradeTab).toList();
    }

    // Sort descending by selected course XP
    filteredList.sort((a, b) =>
        b.getXpForCourse(_selectedCourseId).compareTo(a.getXpForCourse(_selectedCourseId)));

    final activeCourseTitle = _selectedCourseId == 'ALL'
        ? (_selectedGradeTab == 1 ? '1. Sınıf Genel XP Sıralaması' : '2. Sınıf Genel XP Sıralaması')
        : selectedCourse.title;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Column(
          children: [
            // Top Navigation Bar
            Container(
              padding: EdgeInsets.symmetric(horizontal: isMobile ? 12 : 20, vertical: 12),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0), width: 1.5)),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_rounded, color: AppTheme.deepNavy),
                    onPressed: () => context.go('/'),
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sınıf Liderlik Tablosu 🏆',
                          style: GoogleFonts.outfit(
                            fontSize: isMobile ? 17 : 20,
                            fontWeight: FontWeight.w800,
                            color: AppTheme.deepNavy,
                          ),
                        ),
                        Text(
                          activeCourseTitle,
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: const Color(0xFF64748B),
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppTheme.turquoise.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppTheme.turquoise.withValues(alpha: 0.3)),
                    ),
                    child: Text(
                      isTeacher ? 'YÖNETİCİ' : (currentUser?.grade == 2 ? '2. SINIF' : '1. SINIF'),
                      style: GoogleFonts.outfit(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        color: AppTheme.deepNavy,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Grade Level Tabs Header (1. Sınıf 26 Girişliler vs 2. Sınıf)
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          _selectedGradeTab = 1;
                        });
                      },
                      icon: const Icon(Icons.stars_rounded, size: 18),
                      label: Text(
                        '1. Sınıf Tablosu (26 Girişli)',
                        style: GoogleFonts.outfit(
                          fontSize: isMobile ? 12 : 13.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _selectedGradeTab == 1 ? AppTheme.deepNavy : const Color(0xFFF1F5F9),
                        foregroundColor: _selectedGradeTab == 1 ? Colors.white : const Color(0xFF475569),
                        elevation: _selectedGradeTab == 1 ? 2 : 0,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          _selectedGradeTab = 2;
                        });
                      },
                      icon: const Icon(Icons.military_tech_rounded, size: 18),
                      label: Text(
                        '2. Sınıf Tablosu (25/24/23)',
                        style: GoogleFonts.outfit(
                          fontSize: isMobile ? 12 : 13.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _selectedGradeTab == 2 ? AppTheme.duoPurple : const Color(0xFFF1F5F9),
                        foregroundColor: _selectedGradeTab == 2 ? Colors.white : const Color(0xFF475569),
                        elevation: _selectedGradeTab == 2 ? 2 : 0,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Course Selector Filter Chips
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              color: Colors.white,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ChoiceChip(
                        label: Text(
                          '🌐 Tüm Dersler',
                          style: GoogleFonts.outfit(
                            fontWeight: FontWeight.bold,
                            fontSize: 12.5,
                            color: _selectedCourseId == 'ALL' ? Colors.white : const Color(0xFF334155),
                          ),
                        ),
                        selected: _selectedCourseId == 'ALL',
                        selectedColor: AppTheme.deepNavy,
                        backgroundColor: const Color(0xFFF1F5F9),
                        onSelected: (val) {
                          if (val) {
                            setState(() {
                              _selectedCourseId = 'ALL';
                            });
                          }
                        },
                      ),
                    ),
                    ...availableCourses.map((course) {
                      final isSelected = _selectedCourseId == course.id;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ChoiceChip(
                          label: Text(
                            course.shortTitle,
                            style: GoogleFonts.outfit(
                              fontWeight: FontWeight.bold,
                              fontSize: 12.5,
                              color: isSelected ? Colors.white : const Color(0xFF334155),
                            ),
                          ),
                          selected: isSelected,
                          selectedColor: AppTheme.deepNavy,
                          backgroundColor: const Color(0xFFF1F5F9),
                          onSelected: (val) {
                            if (val) {
                              setState(() {
                                _selectedCourseId = course.id;
                              });
                            }
                          },
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),

            // Leaderboard Ranked List
            Expanded(
              child: filteredList.isEmpty
                  ? Center(
                      child: Text(
                        'Bu kategoride kayıtlı sıralama bulunmuyor.',
                        style: GoogleFonts.inter(color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: filteredList.length,
                      itemBuilder: (context, index) {
                        final student = filteredList[index];
                        final rank = index + 1;
                        final xp = student.getXpForCourse(_selectedCourseId);

                        Color rankColor = const Color(0xFF64748B);
                        Widget? badge;

                        if (rank == 1) {
                          rankColor = const Color(0xFFD97706); // Gold
                          badge = const Text('🥇', style: TextStyle(fontSize: 24));
                        } else if (rank == 2) {
                          rankColor = const Color(0xFF475569); // Silver
                          badge = const Text('🥈', style: TextStyle(fontSize: 24));
                        } else if (rank == 3) {
                          rankColor = const Color(0xFFB45309); // Bronze
                          badge = const Text('🥉', style: TextStyle(fontSize: 24));
                        }

                        final isMe = student.publicName.contains('(Siz)');

                        return Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: isMe ? const Color(0xFFF0FDF4) : Colors.white,
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(
                              color: isMe
                                  ? AppTheme.duoGreen
                                  : (rank <= 3 ? rankColor.withValues(alpha: 0.4) : const Color(0xFFE2E8F0)),
                              width: isMe || rank <= 3 ? 2.0 : 1.0,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.03),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              // Rank Badge / Number
                              SizedBox(
                                width: 38,
                                child: badge ??
                                    Text(
                                      '#$rank',
                                      style: GoogleFonts.outfit(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: rankColor,
                                      ),
                                    ),
                              ),
                              const SizedBox(width: 8),

                              // Avatar Circle
                              CircleAvatar(
                                radius: 18,
                                backgroundColor: isMe
                                    ? AppTheme.duoGreen.withValues(alpha: 0.2)
                                    : AppTheme.turquoise.withValues(alpha: 0.15),
                                child: Text(
                                  student.publicName[0],
                                  style: GoogleFonts.outfit(
                                    fontWeight: FontWeight.bold,
                                    color: isMe ? AppTheme.duoGreenDark : AppTheme.deepNavy,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),

                              // Name & Group (ONLY Public Name e.g. "Pervin Y." and Group e.g. "1. Sınıf", NO Student No/TC!)
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      student.publicName,
                                      style: GoogleFonts.outfit(
                                        fontSize: 15,
                                        fontWeight: isMe ? FontWeight.w800 : FontWeight.w700,
                                        color: isMe ? AppTheme.duoGreenDark : const Color(0xFF1E293B),
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      student.group,
                                      style: GoogleFonts.inter(
                                        fontSize: 11,
                                        color: const Color(0xFF64748B),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // XP Badge
                              Row(
                                children: [
                                  const Icon(Icons.bolt_rounded, color: AppTheme.duoYellow, size: 20),
                                  const SizedBox(width: 2),
                                  Text(
                                    '$xp XP',
                                    style: GoogleFonts.outfit(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w800,
                                      color: AppTheme.duoYellowDark,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
