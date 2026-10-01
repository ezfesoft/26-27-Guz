class AiEvaluationResult {
  final String assessment; // e.g. "correct", "partially_correct", "incorrect"
  final int scoreSuggestion; // 0-100
  final List<String> strengths;
  final List<String> weaknesses;
  final String feedback;
  final bool needsTeacherReview;

  const AiEvaluationResult({
    required this.assessment,
    required this.scoreSuggestion,
    required this.strengths,
    required this.weaknesses,
    required this.feedback,
    this.needsTeacherReview = true,
  });

  factory AiEvaluationResult.fromJson(Map<String, dynamic> json) {
    return AiEvaluationResult(
      assessment: json['assessment'] as String? ?? 'partially_correct',
      scoreSuggestion: (json['scoreSuggestion'] as num?)?.toInt() ?? 70,
      strengths: (json['strengths'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      weaknesses: (json['weaknesses'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      feedback: json['feedback'] as String? ?? '',
      needsTeacherReview: json['needsTeacherReview'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() => {
        'assessment': assessment,
        'scoreSuggestion': scoreSuggestion,
        'strengths': strengths,
        'weaknesses': weaknesses,
        'feedback': feedback,
        'needsTeacherReview': needsTeacherReview,
      };
}
