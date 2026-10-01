class WeekModel {
  final String id;
  final int weekNumber;
  final String title;
  final String description;
  final DateTime unlockAt;
  final bool published;
  final List<String> activityOrder;
  final List<String>? learningObjectives;

  const WeekModel({
    required this.id,
    required this.weekNumber,
    required this.title,
    required this.description,
    required this.unlockAt,
    required this.published,
    required this.activityOrder,
    this.learningObjectives,
  });

  factory WeekModel.fromJson(Map<String, dynamic> json) {
    return WeekModel(
      id: json['id'] as String? ?? '',
      weekNumber: (json['weekNumber'] as num?)?.toInt() ?? 1,
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      unlockAt: json['unlockAt'] != null
          ? DateTime.parse(json['unlockAt'].toString())
          : DateTime.now(),
      published: json['published'] as bool? ?? false,
      activityOrder: (json['activityOrder'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      learningObjectives: (json['learningObjectives'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'weekNumber': weekNumber,
      'title': title,
      'description': description,
      'unlockAt': unlockAt.toIso8601String(),
      'published': published,
      'activityOrder': activityOrder,
      if (learningObjectives != null) 'learningObjectives': learningObjectives,
    };
  }
}
