String formatDuration(Duration duration) {
  if (duration.inSeconds < 60) {
    return '${duration.inSeconds}s';
  }
  if (duration.inMinutes < 60) {
    return '${duration.inMinutes}m'
        ' ${duration.inSeconds - duration.inMinutes * 60}s';
  }
  if (duration.inHours < 24) {
    return '${duration.inHours.toString().padLeft(2, '0')}h'
        ' ${duration.inMinutes - duration.inHours * 60}m'
        ' ${duration.inSeconds - duration.inMinutes * 60}s';
  }
  return '${duration.inDays.toString().padLeft(2, '0')}d'
      ' ${(duration.inHours - duration.inDays * 24).toString().padLeft(2, '0')}h'
      ' ${duration.inMinutes - duration.inHours * 60}m'
      ' ${duration.inSeconds - duration.inMinutes * 60}s';
}

extension DurationExtension on Duration {
  String format() => formatDuration(this);
}
