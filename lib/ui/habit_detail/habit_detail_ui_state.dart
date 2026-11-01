class HabitDetailUiState {
  final String? habitName;
  final bool doneToday;
  final bool isNotFound;
  final List<bool> last7Days;
  final int currentStreak;

  const HabitDetailUiState({
    this.habitName,
    this.doneToday = false,
    this.isNotFound = false,
    this.last7Days = const [],
    this.currentStreak = 0,
  });
}
