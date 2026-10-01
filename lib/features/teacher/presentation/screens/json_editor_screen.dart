import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../activities/domain/models/activity_models.dart';
import '../../../activities/presentation/registries/activity_renderer_registry.dart';

class JsonEditorScreen extends StatefulWidget {
  const JsonEditorScreen({super.key});

  @override
  State<JsonEditorScreen> createState() => _JsonEditorScreenState();
}

class _JsonEditorScreenState extends State<JsonEditorScreen> {
  final _jsonController = TextEditingController();
  String? _validationError;
  bool _isValid = true;
  ActivityModel? _previewActivity;

  static const String _defaultTemplate = '''{
  "courseId": "gorsel_programlama",
  "weekNumber": 3,
  "title": "Event ve Event Handler",
  "unlockAt": "2026-10-12T00:00:00+03:00",
  "activities": [
    {
      "id": "gp-w03-a01",
      "type": "choice",
      "title": "Event Handler Kavramı",
      "skill": "event_handler",
      "cognitiveLevel": "understand",
      "difficulty": 1,
      "xp": 10,
      "content": {
        "prompt": "Bir butona tıklandığında çalışan kod yapısına ne ad verilir?",
        "options": [
          {"id": "a", "text": "Event Handler"},
          {"id": "b", "text": "Property"},
          {"id": "c", "text": "Class Attribute"},
          {"id": "d", "text": "Namespace"}
        ],
        "correctOptionIds": ["a"],
        "explanation": "Event Handler, belirli bir olay gerçekleştiğinde çalışan metottur."
      },
      "settings": {
        "allowRetry": true,
        "maxAttempts": 2,
        "revealAnswerAfterMaxAttempts": true
      }
    }
  ]
}''';

  @override
  void initState() {
    super.initState();
    _jsonController.text = _defaultTemplate;
    _validateJson();
  }

  @override
  void dispose() {
    _jsonController.dispose();
    super.dispose();
  }

  void _validateJson() {
    setState(() {
      _validationError = null;
      _isValid = false;
      _previewActivity = null;
    });

    final text = _jsonController.text.trim();
    if (text.isEmpty) {
      setState(() => _validationError = 'JSON içeriği boş olamaz.');
      return;
    }

    try {
      final decoded = json.decode(text);
      if (decoded is! Map<String, dynamic>) {
        setState(() => _validationError = 'JSON Kök objesi bir Map olmalıdır.');
        return;
      }

      if (!decoded.containsKey('courseId') || !decoded.containsKey('activities')) {
        setState(() => _validationError = 'Eksik alanlar: "courseId" ve "activities" zorunludur.');
        return;
      }

      final activitiesRaw = decoded['activities'] as List<dynamic>?;
      if (activitiesRaw == null || activitiesRaw.isEmpty) {
        setState(() => _validationError = '"activities" listesi en az 1 etkinlik içermelidir.');
        return;
      }

      final firstActivityJson = activitiesRaw.first as Map<String, dynamic>;
      final activity = ActivityModel.fromJson(firstActivityJson);

      setState(() {
        _isValid = true;
        _previewActivity = activity;
      });
    } catch (e) {
      setState(() => _validationError = 'Sözdizimi (Syntax) Hatası: ${e.toString()}');
    }
  }

  void _saveDraft() {
    _validateJson();
    if (_isValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Taslak Başarıyla Kaydedildi 💾'),
          backgroundColor: Color(0xFF0284C7),
        ),
      );
    }
  }

  void _publish() {
    _validateJson();
    if (_isValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('İçerik Başarıyla Yayınlandı! 🚀'),
          backgroundColor: Color(0xFF10B981),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
        title: Text(
          'Öğretmen İçerik & JSON Editörü',
          style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        actions: [
          OutlinedButton.icon(
            onPressed: _saveDraft,
            icon: const Icon(Icons.save_outlined, size: 18),
            label: const Text('Taslak Kaydet'),
          ),
          const SizedBox(width: 8),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: ElevatedButton.icon(
              onPressed: _publish,
              icon: const Icon(Icons.publish_rounded, size: 18),
              label: const Text('Yayınla'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF10B981),
              ),
            ),
          ),
        ],
      ),
      body: Row(
        children: [
          // Left: JSON Code Editor
          Expanded(
            flex: 1,
            child: Container(
              color: const Color(0xFF0F172A),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'JSON Paket Tanımı',
                        style: GoogleFonts.outfit(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const Spacer(),
                      ElevatedButton.icon(
                        onPressed: _validateJson,
                        icon: const Icon(Icons.check_circle_outline, size: 16),
                        label: const Text('Doğrula'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF38BDF8),
                          foregroundColor: const Color(0xFF0F172A),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          textStyle: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  if (_validationError != null)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF451A1A),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xFFF87171)),
                      ),
                      child: Text(
                        _validationError!,
                        style: GoogleFonts.firaCode(
                          fontSize: 12,
                          color: const Color(0xFFFCA5A5),
                        ),
                      ),
                    )
                  else if (_isValid)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF064E3B),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '✓ JSON Şeması Geçerli',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF6EE7B7),
                        ),
                      ),
                    ),
                  Expanded(
                    child: TextField(
                      controller: _jsonController,
                      maxLines: null,
                      expands: true,
                      onChanged: (_) => _validateJson(),
                      style: GoogleFonts.firaCode(
                        fontSize: 13,
                        color: const Color(0xFFE2E8F0),
                        height: 1.5,
                      ),
                      decoration: const InputDecoration(
                        fillColor: Color(0xFF1E293B),
                        filled: true,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Right: Real-time Live Renderer Preview
          Expanded(
            flex: 1,
            child: Container(
              color: const Color(0xFFF8FAFC),
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.preview_rounded, color: Color(0xFF4F46E5)),
                      const SizedBox(width: 8),
                      Text(
                        'Öğrenci Görünüm Önizlemesi',
                        style: GoogleFonts.outfit(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: _previewActivity != null
                            ? ActivityRendererRegistry.getRenderer(
                                activity: _previewActivity!,
                                onCompleted: ({
                                  required bool isCorrect,
                                  required int attempts,
                                  required String selectedOptionId,
                                  required int xpEarned,
                                }) {},
                              )
                            : Center(
                                child: Text(
                                  'Geçerli bir JSON girildiğinde önizleme burada görünecektir.',
                                  style: GoogleFonts.inter(color: const Color(0xFF94A3B8)),
                                ),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
