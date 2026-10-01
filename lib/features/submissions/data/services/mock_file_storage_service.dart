import 'dart:typed_data';
import '../../domain/services/file_storage_service.dart';

class MockFileStorageService implements FileStorageService {
  @override
  Future<String> uploadSubmissionFile({
    required String userId,
    required String fileName,
    required Uint8List fileBytes,
  }) async {
    final validation = SubmissionValidator.validateFile(
      fileName: fileName,
      fileSizeBytes: fileBytes.length,
    );

    if (!validation.isValid) {
      throw Exception(validation.errorMessage);
    }

    return 'https://mock-storage.skillpath.edu.tr/submissions/$userId/$fileName';
  }

  @override
  Future<void> deleteSubmissionFile(String storagePath) async {
    // Mock delete
  }
}
