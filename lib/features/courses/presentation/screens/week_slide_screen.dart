import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app/theme/app_theme.dart';
import '../../../gamification/presentation/widgets/gamification_header.dart';
import '../../data/mock_course_data.dart';

class WeekSlideScreen extends StatefulWidget {
  final String courseId;
  final String weekId;

  const WeekSlideScreen({
    super.key,
    required this.courseId,
    required this.weekId,
  });

  @override
  State<WeekSlideScreen> createState() => _WeekSlideScreenState();
}

class _WeekSlideScreenState extends State<WeekSlideScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final weeks = mockWeeksPerCourse[widget.courseId] ?? [];
    final weekIndex = weeks.indexWhere((w) => w.id == widget.weekId);
    final week = weekIndex != -1 ? weeks[weekIndex] : null;

    final title = week?.title ?? 'Haftalık Konu Özeti';
    final description = week?.description ?? '';
    final objectives = week?.learningObjectives ?? [];
    final firstActivityId = week?.activityOrder.isNotEmpty == true
        ? week!.activityOrder.first
        : 'gp-w01-a01';

    final slides = [
      _SlideData(
        badge: '💡 1. TANIM & KAVRAMLAR',
        title: title,
        content: description,
        icon: Icons.lightbulb_rounded,
        color: AppTheme.duoBlue,
        highlights: objectives,
      ),
      _SlideData(
        badge: '⚡ 2. KİLİT BİLGİLER & PÜF NOKTALAR',
        title: 'Öğrenme Hedefleri',
        content:
            'Bu haftaki etkinlikleri tamamlayarak aşağıdaki temel becerileri pekiştirecek ve uygulamalı sorularla kendinizi test edeceksiniz.',
        icon: Icons.auto_awesome_rounded,
        color: AppTheme.duoYellow,
        highlights: objectives.isNotEmpty
            ? objectives
            : [
                'Temel kavramları ve teorik altyapıyı anlama',
                'Kod örneklerini analiz etme ve hata ayıklama',
                'Uygulamalı çoktan seçmeli ve eşleştirme sorularını çözme',
              ],
      ),
      _SlideData(
        badge: '🚀 3. UYGULAMA & ETKİNLİK SÜRECİ',
        title: 'Soru Maratonu Hazır!',
        content:
            'Her soru için 10 XP kazanacaksınız. Yanlış cevaplarda 1 Can hakkınız azalır. 5 Canınızı koruyarak haftanın tüm sorularını tamamlamaya çalışın!',
        icon: Icons.emoji_events_rounded,
        color: AppTheme.duoGreen,
        highlights: [
          'Toplam 5 etkileşimli soru',
          'Doğru yanıtlarda +10 XP ve Elmas ödülleri',
          'Yanlış yanıtta detaylı ipucu ve açıklama kartı',
        ],
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FA),
      body: SafeArea(
        child: Column(
          children: [
            // Top Gamification Header
            const GamificationHeader(),

            // Top Slide App Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.close_rounded, color: Color(0xFF777777)),
                    onPressed: () => context.go('/courses/${widget.courseId}'),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Row(
                      children: List.generate(slides.length, (idx) {
                        return Expanded(
                          child: Container(
                            height: 6,
                            margin: const EdgeInsets.symmetric(horizontal: 3),
                            decoration: BoxDecoration(
                              color: idx <= _currentPage
                                  ? AppTheme.duoGreen
                                  : const Color(0xFFE5E5E5),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    '${_currentPage + 1}/${slides.length}',
                    style: GoogleFonts.outfit(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF777777),
                    ),
                  ),
                ],
              ),
            ),

            // Slide Page View
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: slides.length,
                onPageChanged: (page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                itemBuilder: (context, index) {
                  final slide = slides[index];
                  return SingleChildScrollView(
                    padding: const EdgeInsets.all(24.0),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 640),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            // Slide Badge
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 6),
                              decoration: BoxDecoration(
                                color: slide.color.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    color: slide.color.withValues(alpha: 0.4),
                                    width: 1.5),
                              ),
                              child: Text(
                                slide.badge,
                                style: GoogleFonts.outfit(
                                  fontSize: 12,
                          fontWeight: FontWeight.w800,
                                  color: slide.color,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),

                            // Slide Icon & Title
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: slide.color.withValues(alpha: 0.1),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(slide.icon,
                                      color: slide.color, size: 36),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Text(
                                    slide.title,
                                    style: GoogleFonts.outfit(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF2B2B2B),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),

                            // Slide Main Content Card
                            Card(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: const BorderSide(
                                    color: Color(0xFFE5E5E5), width: 2),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(24.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      slide.content,
                                      style: GoogleFonts.inter(
                                        fontSize: 16,
                                        height: 1.5,
                                        color: const Color(0xFF4B4B4B),
                                      ),
                                    ),
                                    if (slide.highlights.isNotEmpty) ...[
                                      const Divider(
                                          height: 28, color: Color(0xFFE5E5E5)),
                                      ...slide.highlights.map(
                                        (h) => Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 8.0),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Icon(
                                                  Icons.check_circle_rounded,
                                                  color: AppTheme.duoGreen,
                                                  size: 20),
                                              const SizedBox(width: 10),
                                              Expanded(
                                                child: Text(
                                                  h,
                                                  style: GoogleFonts.inter(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                    color:
                                                        const Color(0xFF3C3C3C),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Bottom Navigation Controls
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                border:
                    Border(top: BorderSide(color: Color(0xFFE5E5E5), width: 2)),
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 640),
                  child: SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_currentPage < slides.length - 1) {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        } else {
                          // Start Activities
                          context.go(
                            '/courses/${widget.courseId}/weeks/${widget.weekId}/activities/$firstActivityId',
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.duoGreen,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text(
                        _currentPage < slides.length - 1
                            ? 'SONRAKİ SLAYT ➔'
                            : 'HAZIRIM, SORULARA BAŞLA 🚀',
                        style: GoogleFonts.outfit(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.1,
                        ),
                      ),
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

class _SlideData {
  final String badge;
  final String title;
  final String content;
  final IconData icon;
  final Color color;
  final List<String> highlights;

  const _SlideData({
    required this.badge,
    required this.title,
    required this.content,
    required this.icon,
    required this.color,
    required this.highlights,
  });
}
