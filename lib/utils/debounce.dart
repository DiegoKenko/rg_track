import 'dart:async';

class Debounce {
  Timer? _timer;
  late final Duration _duration;

  Debounce([Duration duration = const Duration(milliseconds: 300)]) {
    _duration = duration;
  }

  void debounce(Function callback) {
    _timer?.cancel();
    _timer = Timer(_duration, () {
      callback.call();
      _timer = null;
    });
  }
}
