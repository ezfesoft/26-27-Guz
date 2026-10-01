import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/models/activity_models.dart';

class ShortAnswerActivityRenderer extends StatefulWidget {
  final ActivityModel activity;
  final Function({
    required bool isCorrect,
    required int attempts,
    required String selectedOptionId,
    required int xpEarned,
  }) onCompleted;

  const ShortAnswerActivityRenderer({
    super.key,
    required this.activity,
    required this.onCompleted,
  });

  @override
  State<ShortAnswerActivityRenderer> createState() => _ShortAnswerActivityRendererState();
}

class _ShortAnswerActivityRendererState extends State<ShortAnswerActivityRenderer> {
  ShortAnswerActivityContent get _content => widget.activity.content as ShortAnswerActivityContent;
  ActivitySettings get _settings => widget.activity.settings;

  final _textController = TextEditingController();
  bool _isSubmitted = false;
  bool _isCorrect = false;
  int _attemptsCount = 0;
  bool _isFinalState = false;

  @override
  void didUpdateWidget(covariant ShortAnswerActivityRenderer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.activity.id != widget.activity.id) {
      setState(() {
        _textController.clear();
        _isSubmitted = false;
        _isCorrect = false;
        _attemptsCount = 0;
        _isFinalState = false;
      });
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    final text = _textController.text.trim().toLowerCase();
    if (text.isEmpty) return;

    bool keywordMatched = false;
    for (final kw in _content.keywords) {
      if (text.contains(kw.toLowerCase())) {
        keywordMatched = true;
        break;
      }
    }

    setState(() {
      _attemptsCount++;
      _isSubmitted = true;
      _isCorrect = keywordMatched;

      if (_isCorrect || _attemptsCount >= _settings.maxAttempts) {
        _isFinalState = true;
      }
    });
  }

  void _handleRetry() {
    setState(() {
      _isSubmitted = false;
    });
  }

  void _handleContinue() {
    widget.onCompleted(
      isCorrect: _isCorrect,
      attempts: _attemptsCount,
      selectedOptionId: _textController.text.trim(),
      xpEarned: _isCorrect ? widget.activity.xp : 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Chip(
                backgroundColor: const Color(0xFFF1F5F9),
                avatar: const Icon(Icons.edit_note_rounded, size: 16, color: Color(0xFF4F46E5)),
                label: Text(
                  'Kısa Cevap • ${widget.activity.skill}',
                  style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFFEF3C7),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.bolt_rounded, size: 16, color: Color(0xFFD97706)),
                    const SizedBox(width: 4),
                    Text(
                      '+${widget.activity.xp} XP',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFFB45309),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            widget.activity.title,
            style: GoogleFonts.outfit(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            _content.prompt,
            style: GoogleFonts.inter(fontSize: 15, color: const Color(0xFF334155)),
          ),
          const SizedBox(height: 20),

          // Short Answer Input
          TextField(
            controller: _textController,
            enabled: !_isSubmitted || !_isFinalState,
            maxLines: 3,
            decoration: const InputDecoration(
              hintText: 'Cevabınızı buraya yazınız...',
              alignLabelWithHint: true,
            ),
          ),

          const SizedBox(height: 20),

          if (_isSubmitted) ...[
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _isCorrect ? const Color(0xFFECFDF5) : const Color(0xFFFEF2F2),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: _isCorrect ? const Color(0xFFA7F3D0) : const Color(0xFFFCA5A5),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _isCorrect ? '✓ Doğru Cevap!' : '✗ Cevabınız Eksik veya Hatalı',
                    style: GoogleFonts.outfit(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: _isCorrect ? const Color(0xFF065F46) : const Color(0xFF991B1B),
                    ),
                  ),
                  if (_content.sampleAnswer != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      'Örnek Cevap: ${_content.sampleAnswer!}',
                      style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600),
                    ),
                  ],
                  if (_content.explanation != null && (_isCorrect || _isFinalState)) ...[
                    const SizedBox(height: 6),
                    Text(
                      _content.explanation!,
                      style: GoogleFonts.inter(fontSize: 14, color: const Color(0xFF334155)),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],

          if (!_isSubmitted)
            ElevatedButton(
              onPressed: _handleSubmit,
              style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(50)),
              child: const Text('KONTROL ET'),
            )
          else if (!_isFinalState && _settings.allowRetry)
            OutlinedButton(
              onPressed: _handleRetry,
              style: OutlinedButton.styleFrom(minimumSize: const Size.fromHeight(50)),
              child: const Text('TEKRAR DENE'),
            )
          else
            ElevatedButton(
              onPressed: _handleContinue,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                backgroundColor: const Color(0xFF10B981),
              ),
              child: const Text('DEVAM ET'),
            ),
        ],
      ),
    );
  }
}
