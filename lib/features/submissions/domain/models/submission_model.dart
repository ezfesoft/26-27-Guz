enum SubmissionStatus {
  submitted,
  pendingReview,
  approved,
  needsRevision;

  static SubmissionStatus fromString(String value) {
    switch (value.toLowerCase()) {
      case 'approved':
        return SubmissionStatus.approved;
      case 'needs_revision':
      case 'needsrevision':
        return SubmissionStatus.needsRevision;
      case 'pending_review':
      case 'pendingreview':
        return SubmissionStatus.pendingReview;
      case 'submitted':
      default:
        return SubmissionStatus.submitted;
    }
  }

  String toJson() => name;
}

class SubmissionModel {
  final String id;
  final String studentId;
  final String courseId;
  final String weekId;
  final String activityId;
  final String fileType; // txt, png, jpg, jpeg, webp
  final String fileUrl;
  final String fileName;
  final SubmissionStatus status;
  final int? score;
  final String? teacherFeedback;
  final DateTime createdAt;

  const SubmissionModel({
    required this.id,
    required this.studentId,
    required this.courseId,
    required this.weekId,
    required this.activityId,
    required this.fileType,
    required this.fileUrl,
    required this.fileName,
    this.status = SubmissionStatus.pendingReview,
    this.score,
    this.teacherFeedback,
    required this.createdAt,
  });

  factory SubmissionModel.fromJson(Map<String, dynamic> json) {
    return SubmissionModel(
      id: json['id'] as String? ?? '',
      studentId: json['studentId'] as String? ?? '',
      courseId: json['courseId'] as String? ?? '',
      weekId: json['weekId'] as String? ?? '',
      activityId: json['activityId'] as String? ?? '',
      fileType: json['fileType'] as String? ?? 'txt',
      fileUrl: json['fileUrl'] as String? ?? '',
      fileName: json['fileName'] as String? ?? 'submission.txt',
      status: SubmissionStatus.fromString(json['status'] as String? ?? 'pending_review'),
      score: (json['score'] as num?)?.toInt(),
      teacherFeedback: json['teacherFeedback'] as String?,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'].toString())
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'studentId': studentId,
        'courseId': courseId,
        'weekId': weekId,
        'activityId': activityId,
        'fileType': fileType,
        'fileUrl': fileUrl,
        'fileName': fileName,
        'status': status.toJson(),
        if (score != null) 'score': score,
        if (teacherFeedback != null) 'teacherFeedback': teacherFeedback,
        'createdAt': createdAt.toIso8601String(),
      };
}
