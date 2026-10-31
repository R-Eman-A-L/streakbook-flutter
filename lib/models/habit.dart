class Habit {
  final int id;
  final String name;
  final Set<DateTime> completedDates;

  const Habit({
    required this.id,
    required this.name,
    this.completedDates = const {},
  });

  Habit copyWith({String? name, Set<DateTime>? completedDates}) => Habit(
    id: id,
    name: name ?? this.name,
    completedDates: completedDates ?? this.completedDates,
  );
}
