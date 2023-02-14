abstract class MainEvent {}

class InitEvent extends MainEvent {}

class InputLatMainEvent extends MainEvent {
  final String text;

  InputLatMainEvent(this.text);
}

class InputLongMainEvent extends MainEvent {
  final String text;

  InputLongMainEvent(this.text);
}
class InputZoomMainEvent extends MainEvent {
  final String text;

  InputZoomMainEvent(this.text);
}


class FindTileMainEvent extends MainEvent {}