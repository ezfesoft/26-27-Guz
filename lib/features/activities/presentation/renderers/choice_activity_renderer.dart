import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../app/theme/app_theme.dart';
import '../../domain/models/activity_models.dart';

class ChoiceActivityRenderer extends StatefulWidget {
  final ActivityModel activity;
  final Function({
    required bool isCorrect,
    required int attempts,
    required String selectedOptionId,
    required int xpEarned,
  }) onCompleted;

  const ChoiceActivityRenderer({
    super.key,
    required this.activity,
    required this.onCompleted,
  });

  @override
  State<ChoiceActivityRenderer> createState() => _ChoiceActivityRendererState();
}

class _ChoiceActivityRendererState extends State<ChoiceActivityRenderer> {
  String? _selectedOptionId;
  bool _isSubmitted = false;
  bool _isCorrect = false;
  int _attemptsCount = 0;
  bool _isFinalState = false;

  ChoiceActivityContent get _content => widget.activity.content;

  @override
  void didUpdateWidget(covariant ChoiceActivityRenderer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.activity.id != widget.activity.id) {
      setState(() {
        _selectedOptionId = null;
        _isSubmitted = false;
        _isCorrect = false;
        _attemptsCount = 0;
        _isFinalState = false;
      });
    }
  }

  void _handleSelectOption(String optionId) {
    if (_isSubmitted && _isFinalState) return;
    setState(() {
      _selectedOptionId = optionId;
    });
  }

  void _handleSubmit() {
    if (_selectedOptionId == null) return;

    setState(() {
      _attemptsCount++;
      _isSubmitted = true;
      _isCorrect = _content.correctOptionIds.contains(_selectedOptionId);
      _isFinalState = true;
    });
  }

  void _handleContinue() {
    widget.onCompleted(
      isCorrect: _isCorrect,
      attempts: _attemptsCount,
      selectedOptionId: _selectedOptionId ?? '',
      xpEarned: _isCorrect ? widget.activity.xp : 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    final optionLetters = ['A', 'B', 'C', 'D', 'E', 'F'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Main Question Content
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 680),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Question Prompt
                    Text(
                      _content.prompt,
                      style: GoogleFonts.outfit(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        height: 1.3,
                        color: const Color(0xFF2B2B2B),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Code Snippet if exists
                    if (_content.codeSnippet != null && _content.codeSnippet!.isNotEmpty) ...[
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(bottom: 20),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E293B),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: const Color(0xFF334155), width: 2),
                        ),
                        child: SelectableText(
                          _content.codeSnippet!,
                          style: GoogleFonts.firaCode(
                            fontSize: 14,
                            color: const Color(0xFFF8FAFC),
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],

                    // Options List
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _content.options.length,
                      itemBuilder: (context, index) {
                        final option = _content.options[index];
                        final letter = index < optionLetters.length ? optionLetters[index] : '${index + 1}';
                        final isSelected = _selectedOptionId == option.id;
                        final isCorrectOption = _content.correctOptionIds.contains(option.id);

                        Color borderColor = const Color(0xFFE5E5E5);
                        Color bgColor = Colors.white;
                        Color textColor = const Color(0xFF3C3C3C);
                        Color badgeBgColor = const Color(0xFFF1F5F9);
                        Color badgeTextColor = const Color(0xFF64748B);

                        if (_isSubmitted) {
                          if (isCorrectOption) {
                            borderColor = AppTheme.duoGreen;
                            bgColor = AppTheme.duoGreenLight;
                            textColor = const Color(0xFF1E5600);
                            badgeBgColor = AppTheme.duoGreen;
                            badgeTextColor = Colors.white;
                          } else if (isSelected && !_isCorrect) {
                            borderColor = AppTheme.duoRed;
                            bgColor = AppTheme.duoRedLight;
                            textColor = const Color(0xFF990000);
                            badgeBgColor = AppTheme.duoRed;
                            badgeTextColor = Colors.white;
                          }
                        } else if (isSelected) {
                          borderColor = AppTheme.duoBlue;
                          bgColor = const Color(0xFFE5F6FF);
                          textColor = const Color(0xFF005F9E);
                          badgeBgColor = AppTheme.duoBlue;
                          badgeTextColor = Colors.white;
                        }

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: InkWell(
                            onTap: () => _handleSelectOption(option.id),
                            borderRadius: BorderRadius.circular(18),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 180),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: bgColor,
                                borderRadius: BorderRadius.circular(18),
                                border: Border.all(color: borderColor, width: isSelected || (_isSubmitted && isCorrectOption) ? 3 : 2),
                                boxShadow: [
                                  BoxShadow(
                                    color: borderColor.withValues(alpha: 0.3),
                                    offset: const Offset(0, 4),
                                    blurRadius: 0,
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  // Badge (A, B, C, D)
                                  Container(
                                    width: 36,
                                    height: 36,
                                    decoration: BoxDecoration(
                                      color: badgeBgColor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Text(
                                        letter,
                                        style: GoogleFonts.outfit(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: badgeTextColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 14),

                                  // Option Text
                                  Expanded(
                                    child: Text(
                                      option.text,
                                      style: GoogleFonts.inter(
                                        fontSize: 16,
                                        fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                                        color: textColor,
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
                  ],
                ),
              ),
            ),
          ),
        ),

        // Duolingo Bottom Action Sheet (Check / Continue Banner)
        _buildBottomBanner(context),
      ],
    );
  }

  Widget _buildBottomBanner(BuildContext context) {
    if (!_isSubmitted) {
      // Pre-submission check button
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
                  onPressed: _selectedOptionId != null ? _handleSubmit : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _selectedOptionId != null ? AppTheme.duoGreen : const Color(0xFFE5E5E5),
                    foregroundColor: _selectedOptionId != null ? Colors.white : const Color(0xFFAFAFAF),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    'KONTROL ET',
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

    // Post-submission feedback banner (Correct or Incorrect)
    final bannerBg = _isCorrect ? AppTheme.duoGreenLight : AppTheme.duoRedLight;
    final bannerTextColor = _isCorrect ? const Color(0xFF1E5600) : const Color(0xFF990000);
    final buttonColor = _isCorrect ? AppTheme.duoGreen : AppTheme.duoRed;
    final iconData = _isCorrect ? Icons.check_circle_rounded : Icons.cancel_rounded;
    final titleText = _isCorrect ? 'Harika! 🎉' : 'Neredeyse! 💡';

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: bannerBg,
        border: Border(
          top: BorderSide(
            color: _isCorrect ? AppTheme.duoGreen : AppTheme.duoRed,
            width: 3,
          ),
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
                    Icon(iconData, color: buttonColor, size: 32),
                    const SizedBox(width: 12),
                    Text(
                      titleText,
                      style: GoogleFonts.outfit(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: bannerTextColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Explanation
                if (_content.explanation != null && _content.explanation!.isNotEmpty) ...[
                  Text(
                    _content.explanation!,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      height: 1.4,
                      color: bannerTextColor.withValues(alpha: 0.9),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 16),
                ],

                // Continue Button
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    onPressed: _handleContinue,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor,
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
