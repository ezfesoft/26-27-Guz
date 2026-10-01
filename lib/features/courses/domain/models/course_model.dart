class CourseModel {
  final String id;
  final String title;
  final String shortTitle;
  final String semester;
  final bool published;
  final int order;
  final String? description;
  final String? iconName;
  final String groupId; // 'BGT1', 'BGT2', 'TVT2'

  const CourseModel({
    required this.id,
    required this.title,
    required this.shortTitle,
    required this.semester,
    required this.published,
    required this.order,
    this.description,
    this.iconName,
    this.groupId = 'BGT1',
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      shortTitle: json['shortTitle'] as String? ?? '',
      semester: json['semester'] as String? ?? '',
      published: json['published'] as bool? ?? false,
      order: (json['order'] as num?)?.toInt() ?? 0,
      description: json['description'] as String?,
      iconName: json['iconName'] as String?,
      groupId: json['groupId'] as String? ?? 'BGT1',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'shortTitle': shortTitle,
      'semester': semester,
      'published': published,
      'order': order,
      'description': description,
      'iconName': iconName,
      'groupId': groupId,
    };
  }
}
