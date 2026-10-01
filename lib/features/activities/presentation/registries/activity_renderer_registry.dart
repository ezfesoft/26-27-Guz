import 'package:flutter/material.dart';
import '../../domain/models/activity_models.dart';
import '../renderers/choice_activity_renderer.dart';
import '../renderers/matching_activity_renderer.dart';
import '../renderers/ordering_activity_renderer.dart';
import '../renderers/project_submission_activity_renderer.dart';
import '../renderers/short_answer_activity_renderer.dart';

class ActivityRendererRegistry {
  static Widget getRenderer({
    required ActivityModel activity,
    required Function({
      required bool isCorrect,
      required int attempts,
      required String selectedOptionId,
      required int xpEarned,
    }) onCompleted,
  }) {
    final key = ValueKey(activity.id);
    switch (activity.type) {
      case ActivityType.project:
        return ProjectSubmissionActivityRenderer(
          key: key,
          activity: activity,
          onCompleted: onCompleted,
        );
      case ActivityType.matching:
        return MatchingActivityRenderer(
          key: key,
          activity: activity,
          onCompleted: onCompleted,
        );
      case ActivityType.ordering:
        return OrderingActivityRenderer(
          key: key,
          activity: activity,
          onCompleted: onCompleted,
        );
      case ActivityType.shortAnswer:
        return ShortAnswerActivityRenderer(
          key: key,
          activity: activity,
          onCompleted: onCompleted,
        );
      case ActivityType.choice:
      default:
        return ChoiceActivityRenderer(
          key: key,
          activity: activity,
          onCompleted: onCompleted,
        );
    }
  }
}
