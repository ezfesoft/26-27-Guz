import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../app/theme/app_theme.dart';
import '../../domain/models/activity_models.dart';

class ProjectSubmissionActivityRenderer extends StatefulWidget {
  final ActivityModel activity;
  final Function({
    required bool isCorrect,
    required int attempts,
    required String selectedOptionId,
    required int xpEarned,
  }) onCompleted;

  const ProjectSubmissionActivityRenderer({
    super.key,
    required this.activity,
    required this.onCompleted,
  });

  @override
  State<ProjectSubmissionActivityRenderer> createState() =>
      _ProjectSubmissionActivityRendererState();
}

class _ProjectSubmissionActivityRendererState
    extends State<ProjectSubmissionActivityRenderer> {
  final TextEditingController _urlController = TextEditingController();
  bool _isSubmitted = false;
  String? _errorMessage;

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  bool _isValidGitHubUrl(String url) {
    final cleanUrl = url.trim();
    final githubRegex = RegExp(
      r'^https:\/\/(www\.)?github\.com\/[a-zA-Z0-9_-]+\/[a-zA-Z0-9_.-]+\/?$',
    );
    return githubRegex.hasMatch(cleanUrl);
  }

  void _handleSubmit() {
    final url = _urlController.text.trim();

    if (url.isEmpty) {
      setState(() {
        _errorMessage = 'Lütfen GitHub repository bağlantısını girin.';
      });
      return;
    }

    if (!_isValidGitHubUrl(url)) {
      setState(() {
        _errorMessage =
            'Geçersiz GitHub bağlantısı! Örnek: https://github.com/kullanici/proje-repo';
      });
      return;
    }

    setState(() {
      _errorMessage = null;
      _isSubmitted = true;
    });
  }

  void _handleContinue() {
    widget.onCompleted(
      isCorrect: true,
      attempts: 1,
      selectedOptionId: _urlController.text.trim(),
      xpEarned: widget.activity.xp,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 680),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppTheme.duoPurple.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            color: AppTheme.duoPurple.withValues(alpha: 0.4)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.code_rounded,
                              color: AppTheme.duoPurple, size: 18),
                          const SizedBox(width: 6),
                          Text(
                            'UYGULAMA & PROJE TESLİMİ',
                            style: GoogleFonts.outfit(
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              color: AppTheme.duoPurple,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Title
                    Text(
                      widget.activity.title,
                      style: GoogleFonts.outfit(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF2B2B2B),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Instructions Card
                    Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: const BorderSide(
                            color: Color(0xFFE5E5E5), width: 2),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: AppTheme.duoBlue
                                        .withValues(alpha: 0.1),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(Icons.tips_and_updates_rounded,
                                      color: AppTheme.duoBlue, size: 24),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    'Kendi Cihazında Geliştir ve Teslim Et',
                                    style: GoogleFonts.outfit(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF3C3C3C),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Bu hafta anlatılan konuyu kendi bilgisayarınızda bir proje olarak kodlayın. Projenizi GitHub hesabınıza yükledikten sonra repository bağlantısını aşağıdaki alana yapıştırın.',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                height: 1.5,
                                color: const Color(0xFF4B4B4B),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // GitHub URL Input Field
                    Text(
                      'GitHub Repository Bağlantısı',
                      style: GoogleFonts.outfit(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF3C3C3C),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _urlController,
                      enabled: !_isSubmitted,
                      decoration: InputDecoration(
                        hintText: 'https://github.com/kullanici/proje-repo',
                        prefixIcon: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 14),
                          child: Icon(Icons.link_rounded, color: Color(0xFF777777)),
                        ),
                        errorText: _errorMessage,
                        filled: true,
                        fillColor: _isSubmitted
                            ? const Color(0xFFF1F5F9)
                            : Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        // Bottom Action Bar
        _buildBottomBar(context),
      ],
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    if (!_isSubmitted) {
      return Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Color(0xFFE5E5E5), width: 2)),
        ),
        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 680),
              child: SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: _handleSubmit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.duoPurple,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    'PROJEYİ TESLİM ET 🚀',
                    style: GoogleFonts.outfit(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: AppTheme.duoGreenLight,
        border: Border(
          top: BorderSide(color: AppTheme.duoGreen, width: 3),
        ),
      ),
      child: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 680),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.check_circle_rounded,
                        color: AppTheme.duoGreen, size: 32),
                    const SizedBox(width: 12),
                    Text(
                      'PROJE BAŞARIYLA TESLİM EDİLDİ! 🎉',
                      style: GoogleFonts.outfit(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF1E5600),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'GitHub projeniz sisteme kaydedildi. +${widget.activity.xp} XP kazandınız!',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: const Color(0xFF1E5600),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    onPressed: _handleContinue,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.duoGreen,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      'DEVAM ET',
                      style: GoogleFonts.outfit(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
