import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../app/theme/app_theme.dart';
import '../../../auth/domain/models/user_model.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../gamification/presentation/widgets/gamification_header.dart';
import '../../data/mock_course_data.dart';
import '../../domain/models/course_model.dart';
import '../../domain/services/week_unlock_service.dart';

import '../../../../app/widgets/knowup_logo.dart';

class CourseListScreen extends ConsumerWidget {
  const CourseListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final userGroup = user?.groupId ?? 'BGT1';
    final userGrade = user?.grade ?? 1;
    final isGrade2 = userGrade == 2 || userGroup == 'BGT2' || userGroup == 'TVT2';
    final isTeacher = user?.role == UserRole.teacher;
    final currentTime = DateTime.now();
    final isMobile = MediaQuery.of(context).size.width < 600;

    // Grade 2 students see BOTH 1st and 2nd grade courses!
    // Grade 1 students see ONLY 1st grade courses (BGT1 and ALL).
    // Teachers see all courses.
    final filteredCourses = (isTeacher || userGroup == 'ALL' || isGrade2)
        ? mockCourses
        : mockCourses
            .where((c) => c.groupId == 'BGT1' || c.groupId == 'ALL')
            .toList();

    String gradeLabel = '1. Sınıf (26 Girişli)';
    if (isTeacher) {
      gradeLabel = 'Yönetici / Akademisyen';
    } else if (isGrade2) {
      gradeLabel = '2. Sınıf (25/24/23 Girişli)';
    }

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        titleSpacing: isMobile ? 8 : 16,
        title: KnowUpLogo(
          logoSize: isMobile ? 32 : 38,
          showSlogan: !isMobile,
        ),
        actions: [
          // Leaderboard Button
          Padding(
            padding: const EdgeInsets.only(right: 2.0),
            child: IconButton(
              onPressed: () => context.go('/leaderboard'),
              icon: const Icon(Icons.emoji_events_rounded, color: AppTheme.duoYellowDark),
              tooltip: 'Sınıf Liderlik Tablosu',
              style: IconButton.styleFrom(
                backgroundColor: AppTheme.duoYellow.withValues(alpha: 0.2),
                padding: EdgeInsets.all(isMobile ? 4 : 8),
                visualDensity: isMobile ? VisualDensity.compact : VisualDensity.standard,
              ),
            ),
          ),
          // Presentations Link Button (Opens in new tab/window)
          Padding(
            padding: const EdgeInsets.only(right: 4.0),
            child: IconButton(
              onPressed: () {
                launchUrl(
                  Uri.parse('https://ezfesoft.github.io/26-27-Guz/sunumlar/index.html'),
                  mode: LaunchMode.externalApplication,
                  webOnlyWindowName: '_blank',
                );
              },
              icon: const Icon(Icons.slideshow_rounded, color: AppTheme.duoBlue),
              tooltip: 'Tüm Ders Sunumları Arşivi ↗',
              style: IconButton.styleFrom(
                backgroundColor: AppTheme.duoBlue.withValues(alpha: 0.15),
                padding: EdgeInsets.all(isMobile ? 4 : 8),
                visualDensity: isMobile ? VisualDensity.compact : VisualDensity.standard,
              ),
            ),
          ),
          if (isTeacher && !isMobile)
            Padding(
              padding: const EdgeInsets.only(right: 6.0),
              child: ElevatedButton.icon(
                onPressed: () => context.go('/teacher/editor'),
                icon: const Icon(Icons.edit_document, size: 16),
                label: const Text('Editör'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.duoBlue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                ),
              ),
            ),
          // User Profile Menu
          Padding(
            padding: EdgeInsets.only(right: isMobile ? 8.0 : 16.0),
            child: PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'editor') {
                  context.go('/teacher/editor');
                } else if (value == 'logout') {
                  ref.read(authRepositoryProvider).signOut();
                  ref.read(currentUserProvider.notifier).state = null;
                  context.go('/login');
                }
              },
              child: isMobile
                  ? CircleAvatar(
                      radius: 16,
                      backgroundColor: AppTheme.duoGreen,
                      child: Text(
                        user?.displayName.isNotEmpty == true
                            ? user!.displayName[0].toUpperCase()
                            : 'Ö',
                        style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    )
                  : Chip(
                      avatar: CircleAvatar(
                        backgroundColor: AppTheme.duoGreen,
                        child: Text(
                          user?.displayName.isNotEmpty == true
                              ? user!.displayName[0].toUpperCase()
                              : 'Ö',
                          style: const TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                      label: Text(
                        user?.displayName ?? 'Öğrenci',
                        style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600),
                      ),
                    ),
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 'user_info',
                  enabled: false,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user?.displayName ?? '',
                        style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 14, color: AppTheme.deepNavy),
                      ),
                      Text(
                        gradeLabel,
                        style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: AppTheme.duoPurple),
                      ),
                    ],
                  ),
                ),
                if (isTeacher) ...[
                  const PopupMenuDivider(),
                  const PopupMenuItem(
                    value: 'editor',
                    child: Row(
                      children: [
                        Icon(Icons.edit_document, size: 18, color: AppTheme.duoBlue),
                        SizedBox(width: 8),
                        Text('İçerik Editörü'),
                      ],
                    ),
                  ),
                ],
                const PopupMenuDivider(),
                const PopupMenuItem(
                  value: 'logout',
                  child: Row(
                    children: [
                      Icon(Icons.logout, size: 18, color: Colors.red),
                      SizedBox(width: 8),
                      Text('Çıkış Yap'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Gamification Top Bar
            const GamificationHeader(),

            // Section Header Banner
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 12 : 20,
                vertical: isMobile ? 10 : 14,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(bottom: BorderSide(color: Color(0xFFE5E5E5), width: 2)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.class_rounded, color: AppTheme.duoPurple, size: 22),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isTeacher ? 'TÜM MÜFREDAT DERSLERİ' : '$userGroup SINIFI DERSLERİNİZ',
                          style: GoogleFonts.outfit(
                            fontSize: isMobile ? 13 : 14,
                            fontWeight: FontWeight.w800,
                            color: AppTheme.duoPurple,
                            letterSpacing: 1.0,
                          ),
                        ),
                        Text(
                          isTeacher
                              ? 'Yönetici yetkisiyle tüm sınıfların derslerini görüyorsunuz.'
                              : 'Sınıfınıza tanımlanan müfredat dersleri aşağıda listelenmiştir.',
                          style: GoogleFonts.inter(
                            fontSize: isMobile ? 11 : 12,
                            color: const Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  OutlinedButton.icon(
                    onPressed: () {
                      launchUrl(
                        Uri.parse('https://ezfesoft.github.io/26-27-Guz/sunumlar/index.html'),
                        mode: LaunchMode.externalApplication,
                        webOnlyWindowName: '_blank',
                      );
                    },
                    icon: const Icon(Icons.open_in_new_rounded, size: 13),
                    label: Text(
                      isMobile ? 'Sunumlar' : 'Tüm Sunumlar',
                      style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: isMobile ? 11 : 12),
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppTheme.duoBlue,
                      side: const BorderSide(color: AppTheme.duoBlue, width: 1.5),
                      padding: EdgeInsets.symmetric(
                        horizontal: isMobile ? 8 : 10,
                        vertical: isMobile ? 4 : 6,
                      ),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ],
              ),
            ),

            // Course List
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(isMobile ? 12 : 16),
                itemCount: filteredCourses.length,
                itemBuilder: (context, index) {
                  final course = filteredCourses[index];
                  final weeks = mockWeeksPerCourse[course.id] ?? [];
                  final unlockedCount = weeks
                      .where((w) => WeekUnlockService.isWeekUnlocked(w, currentTime: currentTime))
                      .length;

                  return _CourseCard(
                    course: course,
                    totalWeeks: weeks.length,
                    unlockedWeeks: unlockedCount,
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

class _CourseCard extends StatelessWidget {
  final CourseModel course;
  final int totalWeeks;
  final int unlockedWeeks;

  const _CourseCard({
    required this.course,
    required this.totalWeeks,
    required this.unlockedWeeks,
  });

  IconData _getIconData(String? name) {
    switch (name) {
      case 'desktop_windows':
        return Icons.desktop_windows_rounded;
      case 'code':
        return Icons.code_rounded;
      case 'security':
        return Icons.security_rounded;
      case 'analytics':
        return Icons.analytics_rounded;
      case 'calculate':
        return Icons.calculate_rounded;
      case 'favorite':
        return Icons.favorite_rounded;
      case 'bug_report':
        return Icons.bug_report_rounded;
      default:
        return Icons.book_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final progressFraction = totalWeeks > 0 ? unlockedWeeks / totalWeeks : 0.0;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE5E5E5), width: 2),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            offset: Offset(0, 4),
            blurRadius: 8,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () => context.go('/courses/${course.id}'),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppTheme.duoBlue.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(
                        _getIconData(course.iconName),
                        color: AppTheme.duoBlue,
                        size: 30,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: AppTheme.duoPurple.withValues(alpha: 0.12),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  course.groupId == 'ALL' ? 'TÜM SINIFLAR' : '${course.groupId} SINIFI',
                                  style: GoogleFonts.outfit(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w800,
                                    color: AppTheme.duoPurple,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                course.semester,
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  color: const Color(0xFF777777),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            course.title,
                            style: GoogleFonts.outfit(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF2B2B2B),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios_rounded,
                        color: Color(0xFFAFAFAF), size: 18),
                  ],
                ),
                if (course.description != null) ...[
                  const SizedBox(height: 12),
                  Text(
                    course.description!,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: const Color(0xFF64748B),
                      height: 1.4,
                    ),
                  ),
                ],
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: LinearProgressIndicator(
                          value: progressFraction,
                          minHeight: 10,
                          backgroundColor: const Color(0xFFE5E5E5),
                          valueColor:
                              const AlwaysStoppedAnimation<Color>(AppTheme.duoGreen),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      '$unlockedWeeks / $totalWeeks Hafta Açık',
                      style: GoogleFonts.outfit(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF4B4B4B),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
