import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app/theme/app_theme.dart';
import '../../../courses/data/mock_course_data.dart';
import '../../../gamification/presentation/providers/gamification_provider.dart';
import '../../../gamification/presentation/widgets/gamification_header.dart';
import '../../data/mock_activities_data.dart';
import '../../domain/models/activity_models.dart';
import '../registries/activity_renderer_registry.dart';

class ActivityScreen extends ConsumerStatefulWidget {
  final String courseId;
  final String weekId;
  final String activityId;

  const ActivityScreen({
    super.key,
    required this.courseId,
    required this.weekId,
    required this.activityId,
  });

  @override
  ConsumerState<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends ConsumerState<ActivityScreen> {
  late ActivityModel _currentActivity;
  static int _correctAnswersCount = 0;

  @override
  void initState() {
    super.initState();
    _loadActivity();
  }

  @override
  void didUpdateWidget(covariant ActivityScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.weekId != widget.weekId) {
      _correctAnswersCount = 0;
    }
    if (oldWidget.activityId != widget.activityId || oldWidget.weekId != widget.weekId) {
      _loadActivity();
    }
  }

  void _loadActivity() {
    if (mockActivities.containsKey(widget.activityId)) {
      _currentActivity = mockActivities[widget.activityId]!;
    } else {
      _currentActivity = const ActivityModel(
        id: 'gp-w03-a01',
        type: ActivityType.choice,
        title: 'Event Handler ve Olay Yönetimi',
        skill: 'event_handler',
        cognitiveLevel: 'understand',
        difficulty: 1,
        xp: 10,
        content: ChoiceActivityContent(
          prompt:
              'C# Windows Forms uygulamasında bir Button kontrolüne tıklandığında (Click) tetiklenen kod bloğuna ne ad verilir?',
          options: [
            ActivityOption(id: 'a', text: 'Event Handler (Olay Yöneticisi)'),
            ActivityOption(id: 'b', text: 'Property (Özellik)'),
            ActivityOption(id: 'c', text: 'Class Attribute (Sınıf Niteliği)'),
            ActivityOption(id: 'd', text: 'Namespace (İsim Alanı)'),
          ],
          correctOptionIds: ['a'],
          explanation:
              'Event Handler, belirli bir kullanıcı veya sistem olayı gerçekleştiğinde otomatik olarak çalışan metottur.',
        ),
        settings: ActivitySettings(),
      );
    }
  }

  void _handleActivityCompleted({
    required bool isCorrect,
    required int attempts,
    required String selectedOptionId,
    required int xpEarned,
  }) {
    if (isCorrect) {
      _correctAnswersCount++;
      ref.read(gamificationProvider.notifier).addXp(xpEarned);
    } else {
      ref.read(gamificationProvider.notifier).decrementHeart();

      final currentHearts = ref.read(gamificationProvider).hearts;
      if (currentHearts <= 0) {
        _showNoHeartsDialog();
        return;
      }
    }

    final weeks = mockWeeksPerCourse[widget.courseId] ?? [];
    final weekIndex = weeks.indexWhere((w) => w.id == widget.weekId);
    final week = weekIndex != -1 ? weeks[weekIndex] : null;

    final activityOrder = week?.activityOrder ?? [];
    final currentIndex = activityOrder.indexOf(widget.activityId);

    if (currentIndex != -1 && currentIndex + 1 < activityOrder.length) {
      final nextActivityId = activityOrder[currentIndex + 1];
      context.go(
        '/courses/${widget.courseId}/weeks/${widget.weekId}/activities/$nextActivityId',
      );
    } else {
      // Last question in week
      final totalQuestions = activityOrder.isNotEmpty ? activityOrder.length : 1;
      final isPerfect = (_correctAnswersCount >= totalQuestions);

      ref.read(gamificationProvider.notifier).completeWeek(widget.weekId, isPerfect: isPerfect);

      if (isPerfect) {
        ref.read(gamificationProvider.notifier).addGems(10);
        ref.read(gamificationProvider.notifier).addXp(50);
      }

      _showCompletionDialog(
        isPerfect: isPerfect,
        correctCount: _correctAnswersCount,
        totalQuestions: totalQuestions,
      );

      // Reset count for next run
      _correctAnswersCount = 0;
    }
  }

  void _showNoHeartsDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Row(
          children: [
            const Icon(Icons.favorite_border_rounded, color: AppTheme.duoRed, size: 36),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'CANIN BİTTİ! ❤️',
                style: GoogleFonts.outfit(fontWeight: FontWeight.w800, fontSize: 22, color: AppTheme.duoRed),
              ),
            ),
          ],
        ),
        content: Text(
          'Tüm can haklarınız tükendi. 10 Elmas kullanarak canlarınızı hemen yenileyebilir veya haftalara dönebilirsiniz.',
          style: GoogleFonts.inter(fontSize: 15, color: const Color(0xFF4B4B4B)),
        ),
        actions: [
          OutlinedButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.go('/courses/${widget.courseId}');
            },
            child: const Text('HAFTALARA DÖN'),
          ),
          ElevatedButton(
            onPressed: () {
              ref.read(gamificationProvider.notifier).refillHearts();
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.duoGreen),
            child: const Text('CANLARI DOLDUR (10 💎)'),
          ),
        ],
      ),
    );
  }

  void _showCompletionDialog({
    required bool isPerfect,
    required int correctCount,
    required int totalQuestions,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Row(
          children: [
            Icon(
              isPerfect ? Icons.star_rounded : Icons.check_circle_rounded,
              color: isPerfect ? AppTheme.duoYellow : AppTheme.duoGreen,
              size: 36,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                isPerfect ? 'KUSURSUZ HAFTA! 🌟' : 'HAFTA TAMAMLANDI 👍',
                style: GoogleFonts.outfit(fontWeight: FontWeight.w800, fontSize: 20),
              ),
            ),
          ],
        ),
        content: Text(
          isPerfect
              ? 'Tüm soruları hatasız yanıtladınız! Altın Yıldız ⭐, +50 Ekstra XP ve 10 Elmas kazandınız.'
              : 'Haftadaki sorular tamamlandı ($correctCount / $totalQuestions Doğru). Altın Yıldız ⭐ ve bonus XP kazanmak için soruları hatasız tamamlamayı deneyebilirsiniz.',
          style: GoogleFonts.inter(fontSize: 15, color: const Color(0xFF4B4B4B)),
        ),
        actions: [
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                context.go('/courses/${widget.courseId}');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: isPerfect ? AppTheme.duoYellow : AppTheme.duoGreen,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: Text(
                'HAFTALARA DÖN',
                style: GoogleFonts.outfit(fontWeight: FontWeight.w800, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final weeks = mockWeeksPerCourse[widget.courseId] ?? [];
    final weekIndex = weeks.indexWhere((w) => w.id == widget.weekId);
    final week = weekIndex != -1 ? weeks[weekIndex] : null;
    final activityOrder = week?.activityOrder ?? [];
    final currentIndex = activityOrder.indexOf(widget.activityId);

    final totalQuestions = activityOrder.isNotEmpty ? activityOrder.length : 1;
    final currentStep = currentIndex != -1 ? currentIndex + 1 : 1;
    final progressFraction = currentStep / totalQuestions;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Gamification Top Bar
            const GamificationHeader(),

            // Duolingo Progress Bar Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.close_rounded, color: Color(0xFFAFAFAF), size: 28),
                    onPressed: () => context.go('/courses/${widget.courseId}'),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: progressFraction,
                        minHeight: 14,
                        backgroundColor: const Color(0xFFE5E5E5),
                        valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.duoGreen),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    '$currentStep/$totalQuestions',
                    style: GoogleFonts.outfit(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF777777),
                    ),
                  ),
                ],
              ),
            ),

            // Active Renderer
            Expanded(
              child: ActivityRendererRegistry.getRenderer(
                activity: _currentActivity,
                onCompleted: _handleActivityCompleted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
