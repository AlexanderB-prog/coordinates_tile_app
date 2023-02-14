
import 'package:bloc/bloc.dart';
import 'package:coordinates_tile/calculation_service.dart';

import 'main_event.dart';
import 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(MainState(316898,164368,19)) {
    on<InitEvent>(_init);
    on<InputZoomMainEvent>(_inputZoom);
    on<InputLatMainEvent>(_inputLat);
    on<InputLongMainEvent>(_inputLong);
    on<FindTileMainEvent>(_findTileMainEvent);
  }

  String _lat = '55.788276';
  String _long = '37.609961';
  String _zoom = '19';

  void _init(InitEvent event, Emitter<MainState> emit) async {
    emit(MainState(316898,164368,19));
  }

  void _inputLat(InputLatMainEvent event, _) async {
    _lat = event.text;
  }
  void _inputLong(InputLongMainEvent event, _) async {
    _long = event.text;
  }
  void _inputZoom(InputZoomMainEvent event, _) async {
    _zoom = event.text;
    final zoom=int.parse(_zoom);
    final int Y = latToTileY(double.parse(_lat), zoom);
    final int X = longToTileX(double.parse(_long), zoom);
    emit(MainState(X, Y,zoom));
  }
  void _findTileMainEvent(
      FindTileMainEvent event, Emitter<MainState> emit) async {
    final zoom=int.parse(_zoom);
   final int Y = latToTileY(double.parse(_lat), zoom);
    final int X = longToTileX(double.parse(_long), zoom);
    emit(MainState(X, Y,zoom));
  }
}
