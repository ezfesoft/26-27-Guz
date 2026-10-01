import 'dart:convert';
import '../../../activities/domain/models/activity_models.dart';

class JsonValidationResult {
  final bool isValid;
  final String? errorMessage;
  final Map<String, dynamic>? parsedJson;

  const JsonValidationResult.valid(this.parsedJson)
      : isValid = true,
        errorMessage = null;

  const JsonValidationResult.invalid(this.errorMessage)
      : isValid = false,
        parsedJson = null;
}

class JsonContentValidator {
  static JsonValidationResult validateWeekPackage(String jsonString) {
    if (jsonString.trim().isEmpty) {
      return const JsonValidationResult.invalid('JSON paketi boş olamaz.');
    }

    try {
      final decoded = json.decode(jsonString);
      if (decoded is! Map<String, dynamic>) {
        return const JsonValidationResult.invalid('JSON Kök objesi bir Map ({...}) olmalıdır.');
      }

      if (!decoded.containsKey('courseId') || decoded['courseId'].toString().isEmpty) {
        return const JsonValidationResult.invalid('Zorunlu alan eksik: "courseId"');
      }

      if (!decoded.containsKey('weekNumber')) {
        return const JsonValidationResult.invalid('Zorunlu alan eksik: "weekNumber"');
      }

      if (!decoded.containsKey('activities') || decoded['activities'] is! List) {
        return const JsonValidationResult.invalid('Zorunlu alan eksik veya hatalı tip: "activities" (Liste olmalı)');
      }

      final activities = decoded['activities'] as List<dynamic>;
      if (activities.isEmpty) {
        return const JsonValidationResult.invalid('"activities" listesi en az 1 etkinlik içermelidir.');
      }

      for (int i = 0; i < activities.length; i++) {
        final actJson = activities[i];
        if (actJson is! Map<String, dynamic>) {
          return JsonValidationResult.invalid('${i + 1}. etkinlik geçersiz obje formatında.');
        }

        if (!actJson.containsKey('id') || actJson['id'].toString().isEmpty) {
          return JsonValidationResult.invalid('${i + 1}. etkinlikte "id" zorunludur.');
        }

        if (!actJson.containsKey('type') || actJson['type'].toString().isEmpty) {
          return JsonValidationResult.invalid('${i + 1}. etkinlikte "type" zorunludur.');
        }

        // Validate model creation
        try {
          ActivityModel.fromJson(actJson);
        } catch (e) {
          return JsonValidationResult.invalid('${i + 1}. etkinlik veri yapısı hatalı: $e');
        }
      }

      return JsonValidationResult.valid(decoded);
    } catch (e) {
      return JsonValidationResult.invalid('Sözdizimi (Syntax) Hatası: ${e.toString()}');
    }
  }
}
