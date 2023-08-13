class Timestamp {
  final int time;
  late final DateTime date;

  Timestamp(this.time) {
    date = DateTime.fromMillisecondsSinceEpoch(time);
  }

  @override
  toString() {
    return date.toString();
  }
}
