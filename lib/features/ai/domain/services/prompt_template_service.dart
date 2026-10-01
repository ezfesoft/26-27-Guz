class PromptTemplateService {
  static String shortAnswerEvaluationPrompt({
    required String question,
    required String studentAnswer,
    String? sampleAnswer,
  }) {
    return '''
Sen bir Bilgisayar Teknolojileri akademisyen asistanısın.
Görevin: Öğrencinin açık uçlu yanıtını değerlendirmek ve TAVSİYE NİTELİĞİNDE geri bildirim üretmektir.

Soru: $question
Öğrencinin Yanıtı: $studentAnswer
${sampleAnswer != null ? 'Örnek Cevap: $sampleAnswer' : ''}

Yanıtını YALNIZCA aşağıdaki JSON formatında ver:
{
  "assessment": "correct" | "partially_correct" | "incorrect",
  "scoreSuggestion": 0-100 arası sayı,
  "strengths": ["Doğru açıklanan noktalar"],
  "weaknesses": ["Geliştirilmesi gereken noktalar"],
  "feedback": "Öğrenciye hitap eden yapıcı ve teşvik edici Türkçe açıklama",
  "needsTeacherReview": true
}
''';
  }

  static String hintPrompt({
    required String question,
    required String studentLastMistake,
  }) {
    return '''
Öğrenci şu soruda hata yaptı: "$question"
Son hatalı yanıtı: "$studentLastMistake"

Öğrenciye doğrudan cevabı VERMEDEN, düşünmesini sağlayacak tek cümlelik ipucu ver.
''';
  }
}
