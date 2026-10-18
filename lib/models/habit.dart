class Habit {
  final int id;
  final String name;
  final bool doneToday;

  const Habit({required this.id, required this.name, this.doneToday = false});

  Habit copyWith({String? name, bool? doneToday}) => Habit(
    id: id,
    name: name ?? this.name,
    doneToday: doneToday ?? this.doneToday,
  );
}
