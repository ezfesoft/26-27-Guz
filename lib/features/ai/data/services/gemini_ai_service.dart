import '../../domain/models/ai_models.dart';
import '../../domain/services/ai_service.dart';

class GeminiAiService implements AiService {
  final String? apiKey;

  GeminiAiService({this.apiKey});

  @override
  Future<AiEvaluationResult> evaluateShortAnswer({
    required String question,
    required String studentAnswer,
    String? sampleAnswer,
  }) async {
    // Advisory mock AI evaluation response (deterministic & secure fallback)
    final text = studentAnswer.toLowerCase();
    if (text.contains('event') || text.contains('handler') || text.contains('ide')) {
      return const AiEvaluationResult(
        assessment: 'correct',
        scoreSuggestion: 90,
        strengths: ['Temel kavramları ve terimleri doğru ilişkilendirdi.'],
        weaknesses: [],
        feedback: 'Harika! Kavramı doğru bir şekilde açıkladın.',
        needsTeacherReview: true,
      );
    }

    return const AiEvaluationResult(
      assessment: 'partially_correct',
      scoreSuggestion: 65,
      strengths: ['Konu hakkında genel bir fikir sundu.'],
      weaknesses: ['Teknik terimleri ve ilişkileri biraz daha detaylandırabilirsin.'],
      feedback: 'Cevabın genel olarak doğru yönü işaret ediyor. Örneklerle zenginleştirebilirsin.',
      needsTeacherReview: true,
    );
  }

  @override
  Future<String> generateHint({
    required String question,
    required String studentLastMistake,
  }) async {
    return 'İpucu: Nesne ve Olay ilişkisini göz önünde bulundurarak soruyu tekrar oku.';
  }
}
