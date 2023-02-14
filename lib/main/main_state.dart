class MainState {
  final int X;
  final int Y;
  final int zoom;

  MainState(this.X, this.Y, this.zoom);
}


class ErrorMainState extends MainState {
  String text;
  ErrorMainState(super.X, super.Y, super.zoom,this.text);
}