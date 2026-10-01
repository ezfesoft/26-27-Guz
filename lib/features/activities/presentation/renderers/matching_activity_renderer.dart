import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/models/activity_models.dart';

class MatchingActivityRenderer extends StatefulWidget {
  final ActivityModel activity;
  final Function({
    required bool isCorrect,
    required int attempts,
    required String selectedOptionId,
    required int xpEarned,
  }) onCompleted;

  const MatchingActivityRenderer({
    super.key,
    required this.activity,
    required this.onCompleted,
  });

  @override
  State<MatchingActivityRenderer> createState() => _MatchingActivityRendererState();
}

class _MatchingActivityRendererState extends State<MatchingActivityRenderer> {
  MatchingActivityContent get _content => widget.activity.content as MatchingActivityContent;
  ActivitySettings get _settings => widget.activity.settings;

  String? _selectedLeftId;
  final Map<String, String> _userMatches = {}; // leftId -> rightId
  bool _isSubmitted = false;
  bool _isCorrect = false;
  int _attemptsCount = 0;
  bool _isFinalState = false;
  late List<MatchingPair> _shuffledRightPairs;

  @override
  void initState() {
    super.initState();
    _shuffledRightPairs = List.from(_content.pairs)..shuffle();
  }

  @override
  void didUpdateWidget(covariant MatchingActivityRenderer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.activity.id != widget.activity.id) {
      setState(() {
        _selectedLeftId = null;
        _userMatches.clear();
        _isSubmitted = false;
        _isCorrect = false;
        _attemptsCount = 0;
        _isFinalState = false;
        _shuffledRightPairs = List.from(_content.pairs)..shuffle();
      });
    }
  }

  void _selectLeft(String leftId) {
    if (_isSubmitted && _isFinalState) return;
    setState(() {
      _selectedLeftId = leftId;
    });
  }

  void _selectRight(String rightId) {
    if (_isSubmitted && _isFinalState) return;
    if (_selectedLeftId == null) return;

    setState(() {
      _userMatches[_selectedLeftId!] = rightId;
      _selectedLeftId = null;
      _isSubmitted = false;
    });
  }

  void _handleSubmit() {
    if (_userMatches.length < _content.pairs.length) return;

    bool allCorrect = true;
    for (final pair in _content.pairs) {
      if (_userMatches[pair.leftId] != pair.rightId) {
        allCorrect = false;
        break;
      }
    }

    setState(() {
      _attemptsCount++;
      _isSubmitted = true;
      _isCorrect = allCorrect;

      if (_isCorrect || _attemptsCount >= _settings.maxAttempts) {
        _isFinalState = true;
      }
    });
  }

  void _handleRetry() {
    setState(() {
      _userMatches.clear();
      _selectedLeftId = null;
      _isSubmitted = false;
    });
  }

  void _handleContinue() {
    widget.onCompleted(
      isCorrect: _isCorrect,
      attempts: _attemptsCount,
      selectedOptionId: _userMatches.values.join(','),
      xpEarned: _isCorrect ? widget.activity.xp : 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    final allMatched = _userMatches.length == _content.pairs.length;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Chip(
                backgroundColor: const Color(0xFFF1F5F9),
                avatar: const Icon(Icons.style_rounded, size: 16, color: Color(0xFF4F46E5)),
                label: Text(
                  'Eşleştirme • ${widget.activity.skill}',
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
          const SizedBox(height: 24),

          // Matching Grid (Left & Right columns)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left Column
              Expanded(
                child: Column(
                  children: _content.pairs.map((pair) {
                    final isSelected = _selectedLeftId == pair.leftId;
                    final hasMatched = _userMatches.containsKey(pair.leftId);

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: InkWell(
                        onTap: () => _selectLeft(pair.leftId),
                        borderRadius: BorderRadius.circular(12),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFFEEF2FF)
                                : (hasMatched ? const Color(0xFFF0FDF4) : Colors.white),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isSelected
                                  ? const Color(0xFF4F46E5)
                                  : (hasMatched ? const Color(0xFF10B981) : const Color(0xFFCBD5E1)),
                              width: isSelected ? 2 : 1,
                            ),
                          ),
                          child: Text(
                            pair.leftText,
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(width: 16),

              // Right Column
              Expanded(
                child: Column(
                  children: _shuffledRightPairs.map((pair) {
                    final isMatchedWithCurrent = _selectedLeftId != null &&
                        _userMatches[_selectedLeftId] == pair.rightId;
                    final isMatchedAny = _userMatches.containsValue(pair.rightId);

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: InkWell(
                        onTap: () => _selectRight(pair.rightId),
                        borderRadius: BorderRadius.circular(12),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: isMatchedWithCurrent
                                ? const Color(0xFFEEF2FF)
                                : (isMatchedAny ? const Color(0xFFF0FDF4) : Colors.white),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isMatchedAny ? const Color(0xFF10B981) : const Color(0xFFCBD5E1),
                            ),
                          ),
                          child: Text(
                            pair.rightText,
                            style: GoogleFonts.inter(fontSize: 14),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Feedback area
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
                    _isCorrect ? '✓ Bütün Eşleştirmeler Doğru!' : '✗ Bazı Eşleştirmeler Hatalı',
                    style: GoogleFonts.outfit(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: _isCorrect ? const Color(0xFF065F46) : const Color(0xFF991B1B),
                    ),
                  ),
                  if (_content.explanation != null && (_isCorrect || _isFinalState)) ...[
                    const SizedBox(height: 8),
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
              onPressed: allMatched ? _handleSubmit : null,
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
