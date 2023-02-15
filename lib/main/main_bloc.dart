import 'package:bloc/bloc.dart';
import 'package:coordinates_tile/calculation_service.dart';

import 'main_event.dart';
import 'main_state.dart';

const List<int> zoomList = <int>[14, 15, 16, 17, 18, 19, 20];

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(MainState(X: 0, Y: 0, zoom: zoomList[5], tileDisplay: false)) {
    on<InitEvent>(_init);
    on<InputZoomMainEvent>(_inputZoom);
    on<InputLatMainEvent>(_inputLat);
    on<InputLongMainEvent>(_inputLong);
    on<FindTileMainEvent>(_findTileMainEvent);
  }

  String _lat = '';
  String _long = '';
  int _zoom = zoomList[5];
  int _tileX = 0;
  int _tileY = 0;
  bool _tileDisplay = false;

  void _init(InitEvent event, Emitter<MainState> emit) async {
    emit(MainState(X: 0, Y: 0, zoom: zoomList[5], tileDisplay: _tileDisplay));
  }

  void _inputLat(InputLatMainEvent event, _) async {
    _lat = event.text;
  }

  void _inputLong(InputLongMainEvent event, _) async {
    _long = event.text;
  }

  void _getXY() {

      _tileX = longToTileX(double.parse(_long), _zoom);
      _tileY = latToTileY(double.parse(_lat), _zoom);

  }

  void _inputZoom(InputZoomMainEvent event, Emitter<MainState> emit) async {
    _zoom = event.zoom;
    if (_lat!='' || _long!='') {
      try {
      _getXY();
      emit(MainState(X: _tileX, Y: _tileY, zoom: _zoom, tileDisplay: _tileDisplay,));
      }catch (e) {
        _tileDisplay = false;
        const errorText = 'Некорректные координаты. '
            'Повторите воод координат. Пример широты 55.750626, долготы 37.597664';
        emit(ErrorMainState(X: _tileX, Y: _tileY, zoom: _zoom, tileDisplay: _tileDisplay, text: errorText));
      }

    } else {
      emit(MainState(X: 0, Y: 0, zoom: _zoom, tileDisplay: false));
    }

  }

  void _findTileMainEvent(

      FindTileMainEvent event, Emitter<MainState> emit) async {
    try {

    _getXY();
    _tileDisplay = true;
    emit(MainState(X: _tileX, Y: _tileY, zoom: _zoom, tileDisplay: _tileDisplay,));
  }catch (e) {
  _tileDisplay = false;
  const errorText = 'Некорректные координаты. '
  'Повторите воод координат. Пример широты 55.750626, долготы 37.597664';
  emit(ErrorMainState(X: _tileX, Y: _tileY, zoom: _zoom, tileDisplay: _tileDisplay, text: errorText));
  }

  }
}
