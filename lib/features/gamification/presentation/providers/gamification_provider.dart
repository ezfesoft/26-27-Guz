import 'package:flutter_riverpod/flutter_riverpod.dart';

class GamificationState {
  final int streak;
  final int gems;
  final int hearts;
  final int maxHearts;
  final int xp;
  final Set<String> completedWeekIds;
  final Set<String> perfectWeekIds;

  const GamificationState({
    this.streak = 0,
    this.gems = 0,
    this.hearts = 5,
    this.maxHearts = 5,
    this.xp = 0,
    this.completedWeekIds = const {},
    this.perfectWeekIds = const {},
  });

  GamificationState copyWith({
    int? streak,
    int? gems,
    int? hearts,
    int? maxHearts,
    int? xp,
    Set<String>? completedWeekIds,
    Set<String>? perfectWeekIds,
  }) {
    return GamificationState(
      streak: streak ?? this.streak,
      gems: gems ?? this.gems,
      hearts: hearts ?? this.hearts,
      maxHearts: maxHearts ?? this.maxHearts,
      xp: xp ?? this.xp,
      completedWeekIds: completedWeekIds ?? this.completedWeekIds,
      perfectWeekIds: perfectWeekIds ?? this.perfectWeekIds,
    );
  }
}

class GamificationNotifier extends StateNotifier<GamificationState> {
  GamificationNotifier() : super(const GamificationState());

  void decrementHeart() {
    if (state.hearts > 0) {
      state = state.copyWith(hearts: state.hearts - 1);
    }
  }

  void refillHearts() {
    state = state.copyWith(hearts: state.maxHearts);
  }

  void addXp(int amount) {
    state = state.copyWith(xp: state.xp + amount);
  }

  void addGems(int amount) {
    state = state.copyWith(gems: state.gems + amount);
  }

  void completeWeek(String weekId, {required bool isPerfect}) {
    final updatedCompleted = Set<String>.from(state.completedWeekIds)..add(weekId);
    final updatedPerfect = Set<String>.from(state.perfectWeekIds);

    if (isPerfect) {
      updatedPerfect.add(weekId);
    }

    state = state.copyWith(
      completedWeekIds: updatedCompleted,
      perfectWeekIds: updatedPerfect,
    );
  }
}

final gamificationProvider =
    StateNotifierProvider<GamificationNotifier, GamificationState>((ref) {
  return GamificationNotifier();
});
