import '../../../../app/config/app_config.dart';
import '../../../../app/services/server_time_service.dart';
import '../models/week_model.dart';

class WeekUnlockService {
  /// Evaluates whether a week is unlocked based on verified online server time.
  /// When [AppConfig.testMode] is true, always returns true.
  static bool isWeekUnlocked(WeekModel week, {DateTime? currentTime}) {
    if (AppConfig.testMode) return true;
    final now = currentTime ?? ServerTimeService.getNow();
    return now.isAfter(week.unlockAt) || now.isAtSameMomentAs(week.unlockAt);
  }

  /// Calculates course completion percentage considering ONLY currently unlocked weeks.
  static double calculateUnlockedCourseProgress({
    required List<WeekModel> allWeeks,
    required Set<String> completedWeekIds,
    DateTime? currentTime,
  }) {
    final now = currentTime ?? ServerTimeService.getNow();
    final unlockedWeeks = allWeeks
        .where((week) => isWeekUnlocked(week, currentTime: now))
        .toList();

    if (unlockedWeeks.isEmpty) return 0.0;

    final completedCount = unlockedWeeks
        .where((week) => completedWeekIds.contains(week.id))
        .length;

    return (completedCount / unlockedWeeks.length) * 100;
  }
}
