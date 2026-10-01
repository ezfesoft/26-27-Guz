import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/models/activity_models.dart';

class OrderingActivityRenderer extends StatefulWidget {
  final ActivityModel activity;
  final Function({
    required bool isCorrect,
    required int attempts,
    required String selectedOptionId,
    required int xpEarned,
  }) onCompleted;

  const OrderingActivityRenderer({
    super.key,
    required this.activity,
    required this.onCompleted,
  });

  @override
  State<OrderingActivityRenderer> createState() => _OrderingActivityRendererState();
}

class _OrderingActivityRendererState extends State<OrderingActivityRenderer> {
  OrderingActivityContent get _content => widget.activity.content as OrderingActivityContent;
  ActivitySettings get _settings => widget.activity.settings;

  late List<OrderingItem> _orderedItems;
  bool _isSubmitted = false;
  bool _isCorrect = false;
  int _attemptsCount = 0;
  bool _isFinalState = false;

  @override
  void initState() {
    super.initState();
    _orderedItems = List.from(_content.items);
  }

  @override
  void didUpdateWidget(covariant OrderingActivityRenderer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.activity.id != widget.activity.id) {
      setState(() {
        _isSubmitted = false;
        _isCorrect = false;
        _attemptsCount = 0;
        _isFinalState = false;
        _orderedItems = List.from(_content.items);
      });
    }
  }

  void _onReorder(int oldIndex, int newIndex) {
    if (_isSubmitted && _isFinalState) return;
    setState(() {
      if (newIndex > oldIndex) newIndex -= 1;
      final item = _orderedItems.removeAt(oldIndex);
      _orderedItems.insert(newIndex, item);
      _isSubmitted = false;
    });
  }

  void _handleSubmit() {
    final currentIds = _orderedItems.map((e) => e.id).toList();
    bool allCorrect = true;
    for (int i = 0; i < currentIds.length; i++) {
      if (i >= _content.correctOrder.length || currentIds[i] != _content.correctOrder[i]) {
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
      _isSubmitted = false;
    });
  }

  void _handleContinue() {
    widget.onCompleted(
      isCorrect: _isCorrect,
      attempts: _attemptsCount,
      selectedOptionId: _orderedItems.map((e) => e.id).join(','),
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
                avatar: const Icon(Icons.sort_rounded, size: 16, color: Color(0xFF4F46E5)),
                label: Text(
                  'Sıralama • ${widget.activity.skill}',
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

          // Reorderable List
          ReorderableListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _orderedItems.length,
            onReorder: _onReorder,
            itemBuilder: (context, index) {
              final item = _orderedItems[index];

              return Card(
                key: ValueKey(item.id),
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(color: Color(0xFFCBD5E1)),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                    child: Text(
                      '${index + 1}',
                      style: GoogleFonts.outfit(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  title: Text(item.text, style: GoogleFonts.inter(fontSize: 15)),
                  trailing: const Icon(Icons.drag_handle_rounded, color: Color(0xFF94A3B8)),
                ),
              );
            },
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
                    _isCorrect ? '✓ Doğru Sıralama!' : '✗ Sıralama Hatalı',
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
