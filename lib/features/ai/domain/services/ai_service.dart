import '../models/ai_models.dart';

abstract class AiService {
  Future<AiEvaluationResult> evaluateShortAnswer({
    required String question,
    required String studentAnswer,
    String? sampleAnswer,
  });

  Future<String> generateHint({
    required String question,
    required String studentLastMistake,
  });
}
