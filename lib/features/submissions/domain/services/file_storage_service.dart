import 'dart:typed_data';

class SubmissionValidationResult {
  final bool isValid;
  final String? errorMessage;

  const SubmissionValidationResult.valid()
      : isValid = true,
        errorMessage = null;

  const SubmissionValidationResult.invalid(this.errorMessage)
      : isValid = false;
}

class SubmissionValidator {
  static const List<String> allowedExtensions = [
    'txt',
    'png',
    'jpg',
    'jpeg',
    'webp',
  ];

  static const int maxFileSizeBytes = 5 * 1024 * 1024; // 5 MB

  static SubmissionValidationResult validateFile({
    required String fileName,
    required int fileSizeBytes,
  }) {
    final extension = fileName.split('.').last.toLowerCase();
    if (!allowedExtensions.contains(extension)) {
      return SubmissionValidationResult.invalid(
        'İzin verilmeyen dosya formatı (.$extension). Sadece TXT, PNG, JPG, JPEG ve WEBP kabul edilir.',
      );
    }

    if (fileSizeBytes > maxFileSizeBytes) {
      return const SubmissionValidationResult.invalid(
        'Dosya boyutu 5 MB üst sınırını aşamaz.',
      );
    }

    return const SubmissionValidationResult.valid();
  }
}

abstract class FileStorageService {
  Future<String> uploadSubmissionFile({
    required String userId,
    required String fileName,
    required Uint8List fileBytes,
  });

  Future<void> deleteSubmissionFile(String storagePath);
}
