import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app/theme/app_theme.dart';
import '../../../gamification/presentation/providers/gamification_provider.dart';
import '../../../gamification/presentation/widgets/gamification_header.dart';
import '../../data/mock_course_data.dart';
import '../../domain/services/week_unlock_service.dart';

class WeekMapScreen extends ConsumerWidget {
  final String courseId;

  const WeekMapScreen({super.key, required this.courseId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final course = mockCourses.firstWhere(
      (c) => c.id == courseId,
      orElse: () => mockCourses.first,
    );
    final weeks = mockWeeksPerCourse[courseId] ?? [];
    final currentTime = DateTime.now();

    final gamificationState = ref.watch(gamificationProvider);
    final completedWeekIds = gamificationState.completedWeekIds;
    final perfectWeekIds = gamificationState.perfectWeekIds;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FA),
      body: SafeArea(
        child: Column(
          children: [
            // Top Gamification Header
            const GamificationHeader(),

            // Course Title Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(bottom: BorderSide(color: Color(0xFFE5E5E5), width: 2)),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_rounded, color: Color(0xFF4B4B4B)),
                    onPressed: () => context.go('/'),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          course.title,
                          style: GoogleFonts.outfit(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF3C3C3C),
                          ),
                        ),
                        Text(
                          '14 Haftalık Akademik Müfredat Akışı',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: const Color(0xFF777777),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppTheme.duoBlue.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppTheme.duoBlue.withValues(alpha: 0.3)),
                    ),
                    child: Text(
                      'CANLI MOD',
                      style: GoogleFonts.outfit(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        color: AppTheme.duoBlue,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Winding Path Scroll View
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 20),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 500),
                    child: Column(
                      children: List.generate(weeks.length, (index) {
                        final week = weeks[index];
                        final isUnlocked = WeekUnlockService.isWeekUnlocked(week, currentTime: currentTime);
                        final isCompleted = completedWeekIds.contains(week.id);
                        final isPerfect = perfectWeekIds.contains(week.id);

                        // Calculate serpentine / winding offsets (-60, 0, 60, 0, -60...)
                        final offsets = [0.0, 50.0, 80.0, 50.0, 0.0, -50.0, -80.0, -50.0];
                        final xOffset = offsets[index % offsets.length];

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 28.0),
                          child: Transform.translate(
                            offset: Offset(xOffset, 0),
                            child: Column(
                              children: [
                                // Circular Node Button
                                InkWell(
                                  onTap: isUnlocked
                                      ? () {
                                          context.go('/courses/$courseId/weeks/${week.id}/slides');
                                        }
                                      : null,
                                  borderRadius: BorderRadius.circular(40),
                                  child: _NodeButton(
                                    weekNumber: week.weekNumber,
                                    isUnlocked: isUnlocked,
                                    isCompleted: isCompleted,
                                    isPerfect: isPerfect,
                                  ),
                                ),
                                const SizedBox(height: 8),

                                // Week Title Chip
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(color: const Color(0xFFE5E5E5), width: 2),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color(0x0F000000),
                                        offset: Offset(0, 2),
                                        blurRadius: 4,
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Hafta ${week.weekNumber}: ${week.title.replaceAll(RegExp(r'^Hafta \d+:?\s*'), '')}',
                                        style: GoogleFonts.outfit(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          color: isUnlocked ? const Color(0xFF3C3C3C) : const Color(0xFFAFAFAF),
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      if (!isUnlocked) ...[
                                        const SizedBox(height: 2),
                                        Text(
                                          'Açılış: ${week.unlockAt.day.toString().padLeft(2, '0')}.${week.unlockAt.month.toString().padLeft(2, '0')}.${week.unlockAt.year}',
                                          style: GoogleFonts.inter(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xFF94A3B8),
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NodeButton extends StatelessWidget {
  final int weekNumber;
  final bool isUnlocked;
  final bool isCompleted;
  final bool isPerfect;

  const _NodeButton({
    required this.weekNumber,
    required this.isUnlocked,
    required this.isCompleted,
    required this.isPerfect,
  });

  @override
  Widget build(BuildContext context) {
    Color btnColor = AppTheme.duoGreen;
    Color shadowColor = AppTheme.duoGreenDark;
    IconData icon = Icons.play_arrow_rounded;

    if (isPerfect) {
      // Perfect Run -> Gold Star
      btnColor = AppTheme.duoYellow;
      shadowColor = AppTheme.duoYellowDark;
      icon = Icons.star_rounded;
    } else if (isCompleted) {
      // Completed with mistakes -> Green Check
      btnColor = AppTheme.duoGreen;
      shadowColor = AppTheme.duoGreenDark;
      icon = Icons.check_rounded;
    } else if (!isUnlocked) {
      // Locked -> Gray Lock
      btnColor = const Color(0xFFE5E5E5);
      shadowColor = const Color(0xFFCDCDCD);
      icon = Icons.lock_rounded;
    }

    return Container(
      width: 76,
      height: 76,
      decoration: BoxDecoration(
        color: btnColor,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            offset: const Offset(0, 6),
            blurRadius: 0,
          ),
        ],
      ),
      child: Center(
        child: isCompleted || !isUnlocked
            ? Icon(icon, color: isUnlocked ? Colors.white : const Color(0xFFAFAFAF), size: 36)
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '$weekNumber',
                    style: GoogleFonts.outfit(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'BAŞLA',
                    style: GoogleFonts.outfit(
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      color: Colors.white.withValues(alpha: 0.9),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
