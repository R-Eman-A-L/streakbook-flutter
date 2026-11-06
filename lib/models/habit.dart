import 'package:intl/intl.dart';

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

  factory Habit.fromJson(Map<String, dynamic> form) {
    return Habit(
      id: form['id'] as int,
      name: form['name'] as String,
      completedDates: (form['completedDates'] as List).map((text) => DateTime.parse(text as String)).toSet(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'completedDates': completedDates
          .map((date) => DateFormat("yyyy-MM-dd").format(date))
          .toList(),
    };
  }
}
