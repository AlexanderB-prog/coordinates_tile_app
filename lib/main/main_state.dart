class MainState {
  final int X;
  final int Y;
  final int zoom;
  bool tileDisplay;

  MainState({required this.X, required this.Y, required this.zoom, required this.tileDisplay});
}


class ErrorMainState extends MainState {
  String text;

  ErrorMainState({required super.X, required super.Y, required super.zoom, required super.tileDisplay, required this.text});

}