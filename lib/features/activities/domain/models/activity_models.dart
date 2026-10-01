enum ActivityType {
  choice,
  matching,
  ordering,
  shortAnswer,
  outputPrediction,
  fillBlank,
  debug,
  scenario,
  codeCompletion,
  interactive,
  simulation,
  project;

  static ActivityType fromString(String value) {
    switch (value.toLowerCase()) {
      case 'choice':
        return ActivityType.choice;
      case 'matching':
        return ActivityType.matching;
      case 'ordering':
        return ActivityType.ordering;
      case 'short_answer':
      case 'shortanswer':
        return ActivityType.shortAnswer;
      case 'output_prediction':
        return ActivityType.outputPrediction;
      case 'fill_blank':
        return ActivityType.fillBlank;
      case 'debug':
        return ActivityType.debug;
      case 'scenario':
        return ActivityType.scenario;
      case 'code_completion':
        return ActivityType.codeCompletion;
      case 'interactive':
        return ActivityType.interactive;
      case 'simulation':
        return ActivityType.simulation;
      case 'project':
        return ActivityType.project;
      default:
        return ActivityType.choice;
    }
  }

  String toJson() => name;
}

class ActivityOption {
  final String id;
  final String text;

  const ActivityOption({required this.id, required this.text});

  factory ActivityOption.fromJson(Map<String, dynamic> json) {
    return ActivityOption(
      id: json['id'] as String? ?? '',
      text: json['text'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {'id': id, 'text': text};
}

class ActivitySettings {
  final bool allowRetry;
  final int maxAttempts;
  final bool revealAnswerAfterMaxAttempts;
  final bool showExplanationAfterSubmit;

  const ActivitySettings({
    this.allowRetry = true,
    this.maxAttempts = 2,
    this.revealAnswerAfterMaxAttempts = true,
    this.showExplanationAfterSubmit = true,
  });

  factory ActivitySettings.fromJson(Map<String, dynamic> json) {
    return ActivitySettings(
      allowRetry: json['allowRetry'] as bool? ?? true,
      maxAttempts: (json['maxAttempts'] as num?)?.toInt() ?? 2,
      revealAnswerAfterMaxAttempts:
          json['revealAnswerAfterMaxAttempts'] as bool? ?? true,
      showExplanationAfterSubmit:
          json['showExplanationAfterSubmit'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() => {
        'allowRetry': allowRetry,
        'maxAttempts': maxAttempts,
        'revealAnswerAfterMaxAttempts': revealAnswerAfterMaxAttempts,
        'showExplanationAfterSubmit': showExplanationAfterSubmit,
      };
}

class ChoiceActivityContent {
  final String prompt;
  final List<ActivityOption> options;
  final List<String> correctOptionIds;
  final String? explanation;
  final String? codeSnippet;
  final Map<String, String>? feedback;

  const ChoiceActivityContent({
    required this.prompt,
    required this.options,
    required this.correctOptionIds,
    this.explanation,
    this.codeSnippet,
    this.feedback,
  });

  factory ChoiceActivityContent.fromJson(Map<String, dynamic> json) {
    return ChoiceActivityContent(
      prompt: json['prompt'] as String? ?? '',
      options: (json['options'] as List<dynamic>?)
              ?.map((e) => ActivityOption.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      correctOptionIds: (json['correctOptionIds'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      explanation: json['explanation'] as String?,
      codeSnippet: json['codeSnippet'] as String?,
      feedback: (json['feedback'] as Map<String, dynamic>?)?.map(
        (key, value) => MapEntry(key, value.toString()),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        'prompt': prompt,
        'options': options.map((e) => e.toJson()).toList(),
        'correctOptionIds': correctOptionIds,
        if (explanation != null) 'explanation': explanation,
        if (codeSnippet != null) 'codeSnippet': codeSnippet,
        if (feedback != null) 'feedback': feedback,
      };
}

class MatchingPair {
  final String leftId;
  final String leftText;
  final String rightId;
  final String rightText;

  const MatchingPair({
    required this.leftId,
    required this.leftText,
    required this.rightId,
    required this.rightText,
  });

  factory MatchingPair.fromJson(Map<String, dynamic> json) {
    return MatchingPair(
      leftId: json['leftId'] as String? ?? '',
      leftText: json['leftText'] as String? ?? '',
      rightId: json['rightId'] as String? ?? '',
      rightText: json['rightText'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'leftId': leftId,
        'leftText': leftText,
        'rightId': rightId,
        'rightText': rightText,
      };
}

class MatchingActivityContent {
  final String prompt;
  final List<MatchingPair> pairs;
  final String? explanation;

  const MatchingActivityContent({
    required this.prompt,
    required this.pairs,
    this.explanation,
  });

  factory MatchingActivityContent.fromJson(Map<String, dynamic> json) {
    return MatchingActivityContent(
      prompt: json['prompt'] as String? ?? '',
      pairs: (json['pairs'] as List<dynamic>?)
              ?.map((e) => MatchingPair.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      explanation: json['explanation'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'prompt': prompt,
        'pairs': pairs.map((e) => e.toJson()).toList(),
        if (explanation != null) 'explanation': explanation,
      };
}

class OrderingItem {
  final String id;
  final String text;

  const OrderingItem({required this.id, required this.text});

  factory OrderingItem.fromJson(Map<String, dynamic> json) {
    return OrderingItem(
      id: json['id'] as String? ?? '',
      text: json['text'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {'id': id, 'text': text};
}

class OrderingActivityContent {
  final String prompt;
  final List<OrderingItem> items;
  final List<String> correctOrder;
  final String? explanation;

  const OrderingActivityContent({
    required this.prompt,
    required this.items,
    required this.correctOrder,
    this.explanation,
  });

  factory OrderingActivityContent.fromJson(Map<String, dynamic> json) {
    return OrderingActivityContent(
      prompt: json['prompt'] as String? ?? '',
      items: (json['items'] as List<dynamic>?)
              ?.map((e) => OrderingItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      correctOrder: (json['correctOrder'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      explanation: json['explanation'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'prompt': prompt,
        'items': items.map((e) => e.toJson()).toList(),
        'correctOrder': correctOrder,
        if (explanation != null) 'explanation': explanation,
      };
}

class ShortAnswerActivityContent {
  final String prompt;
  final List<String> keywords;
  final String? sampleAnswer;
  final String? explanation;

  const ShortAnswerActivityContent({
    required this.prompt,
    required this.keywords,
    this.sampleAnswer,
    this.explanation,
  });

  factory ShortAnswerActivityContent.fromJson(Map<String, dynamic> json) {
    return ShortAnswerActivityContent(
      prompt: json['prompt'] as String? ?? '',
      keywords: (json['keywords'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      sampleAnswer: json['sampleAnswer'] as String?,
      explanation: json['explanation'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'prompt': prompt,
        'keywords': keywords,
        if (sampleAnswer != null) 'sampleAnswer': sampleAnswer,
        if (explanation != null) 'explanation': explanation,
      };
}

class ActivityModel {
  final String id;
  final ActivityType type;
  final String title;
  final String skill;
  final String cognitiveLevel;
  final int difficulty;
  final int xp;
  final dynamic content;
  final ActivitySettings settings;

  const ActivityModel({
    required this.id,
    required this.type,
    required this.title,
    required this.skill,
    required this.cognitiveLevel,
    required this.difficulty,
    required this.xp,
    required this.content,
    required this.settings,
  });

  factory ActivityModel.fromJson(Map<String, dynamic> json) {
    final typeStr = json['type'] as String? ?? 'choice';
    final actType = ActivityType.fromString(typeStr);
    final rawContent = json['content'] as Map<String, dynamic>? ?? json;

    dynamic parsedContent;
    switch (actType) {
      case ActivityType.matching:
        parsedContent = MatchingActivityContent.fromJson(rawContent);
        break;
      case ActivityType.ordering:
        parsedContent = OrderingActivityContent.fromJson(rawContent);
        break;
      case ActivityType.shortAnswer:
        parsedContent = ShortAnswerActivityContent.fromJson(rawContent);
        break;
      case ActivityType.choice:
      default:
        parsedContent = ChoiceActivityContent.fromJson(rawContent);
        break;
    }

    return ActivityModel(
      id: json['id'] as String? ?? '',
      type: actType,
      title: json['title'] as String? ?? '',
      skill: json['skill'] as String? ?? '',
      cognitiveLevel: json['cognitiveLevel'] as String? ?? 'understand',
      difficulty: (json['difficulty'] as num?)?.toInt() ?? 1,
      xp: (json['xp'] as num?)?.toInt() ?? 10,
      content: parsedContent,
      settings: json['settings'] != null
          ? ActivitySettings.fromJson(json['settings'] as Map<String, dynamic>)
          : const ActivitySettings(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type.toJson(),
        'title': title,
        'skill': skill,
        'cognitiveLevel': cognitiveLevel,
        'difficulty': difficulty,
        'xp': xp,
        'content': content.toJson(),
        'settings': settings.toJson(),
      };
}
