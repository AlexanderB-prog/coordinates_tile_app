import 'package:bloc/bloc.dart';
import 'package:coordinates_tile/calculation_service.dart';

import 'main_event.dart';
import 'main_state.dart';

const List<int> zoomList = <int>[14, 15, 16, 17, 18, 19, 20];

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(MainState(316898, 164368, zoomList[5])) {
    on<InitEvent>(_init);
    on<InputZoomMainEvent>(_inputZoom);
    on<InputLatMainEvent>(_inputLat);
    on<InputLongMainEvent>(_inputLong);
    on<FindTileMainEvent>(_findTileMainEvent);
  }

  String _lat = '55.788276';
  String _long = '37.609961';
  int _zoom = zoomList[5];
  int _tileX = 0;
  int _tileY = 0;

  void _init(InitEvent event, Emitter<MainState> emit) async {
    emit(MainState(316898, 164368, 19));
  }

  void _inputLat(InputLatMainEvent event, _) async {
    _lat = event.text;
  }

  void _inputLong(InputLongMainEvent event, _) async {
    _long = event.text;
  }

  void _getXY(Emitter<MainState> emit) {
    try {
      _tileX = longToTileX(double.parse(_long), _zoom);
      _tileY = latToTileY(double.parse(_lat), _zoom);
    }catch (e) {
      const errorText = 'Некорректные координаты. '
          'Повторите воод координат. Пример широты 55.750626, долготы 37.597664';
      emit(ErrorMainState(_tileX, _tileY, _zoom,errorText));
    }
  }

  void _inputZoom(InputZoomMainEvent event, Emitter<MainState> emit) async {
    _zoom = event.zoom;
    _getXY(emit);
    emit(MainState(_tileX, _tileY, _zoom));
  }

  void _findTileMainEvent(
      FindTileMainEvent event, Emitter<MainState> emit) async {
    _getXY(emit);
    emit(MainState(_tileX, _tileY, _zoom));
  }
}
