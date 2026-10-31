abstract class Clock {
  DateTime today();
}

class SystemClock implements Clock {
  @override
  DateTime today() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }
}

class FakeClock implements Clock {
  final DateTime _date;
  FakeClock(this._date);
  @override
  DateTime today() => _date;
}
