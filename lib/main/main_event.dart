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
  final int zoom;

  InputZoomMainEvent(this.zoom);
}


class FindTileMainEvent extends MainEvent {}