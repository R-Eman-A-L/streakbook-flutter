class HabitDetailUiState {
  final String? habitName;
  final bool doneToday;
  final bool isNotFound;

  const HabitDetailUiState({
    this.habitName,
    this.doneToday = false,
    this.isNotFound = false,
  });
}
