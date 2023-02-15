import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'main_bloc.dart';
import 'main_event.dart';
import 'main_state.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => MainBloc()..add(InitEvent()),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<MainBloc>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<MainBloc, MainState>(
  listener: (context, state) {
    if (state is ErrorMainState) {
      Scaffold.of(context).showBottomSheet((context) => GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 100,
          color: Colors.red,
          child: Text(
            state.text,
            style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w600),
          ),
        ),
      ));
    }
  },
  child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  SizedBox(
                    width: 230,
                    child: TextField(
                        keyboardType: TextInputType.number,
                      onSubmitted: (text) {
                        bloc.add(InputLatMainEvent(text));
                      },
                      onChanged: (text) {
                        bloc.add(InputLatMainEvent(text));
                      },
                      maxLines: 1,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(0),
                        hintStyle: const TextStyle(fontSize: 12),
                        hintText: 'Широта',
                        prefixIcon: const Icon(
                          Icons.location_on,
                          color: Colors.grey,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: 230,
                    child: TextField(
                        keyboardType: TextInputType.number,
                      onSubmitted: (text) {
                        bloc.add(InputLongMainEvent(text));
                      },
                      onChanged: (text) {
                        bloc.add(InputLongMainEvent(text));
                      },
                      maxLines: 1,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(0),
                        hintStyle: const TextStyle(fontSize: 12),
                        hintText: 'Долгота',
                        prefixIcon: const Icon(
                          Icons.location_on,
                          color: Colors.grey,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        focusedBorder: OutlineInputBorder(

                          borderRadius: BorderRadius.circular(20),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 50),
              Column(
                children: [
                 const Text('Zoom', style: TextStyle(fontWeight: FontWeight.w600,fontSize: 15),),
                  const SizedBox(height: 10,),
                  Card(
                    color: Colors.white,
                    child: BlocBuilder<MainBloc, MainState>(
                      builder: (context, state) {
                        return DropdownButton<int>(
                          disabledHint: const Text('Zoom',style: TextStyle(color: Colors.black),),
                          value: state.zoom,
                          icon: const Icon(Icons.map),
                          elevation: 16,
                          style: const TextStyle(color: Colors.deepPurple),
                          underline: Container(
                            height: 2,
                            color: Colors.black38,
                          ),
                          onChanged: (int? zoom) {
                            bloc.add(InputZoomMainEvent(zoom!));
                          },
                          items: zoomList.map<DropdownMenuItem<int>>((int value) {
                            return DropdownMenuItem<int>(
                              value: value,
                              child: Text('$value'),
                            );
                          }).toList(),
                        );
                      },
                    ),
                  )
                ],
              )
            ],
          ),
          const SizedBox(height: 15),
          ElevatedButton(
              onPressed: () {
                bloc.add(FindTileMainEvent());
              },
              child: const Text('Посмотреть tile')),
          const SizedBox(height: 15),
          const ShowTile(),
        ],
      ),
),
    );
  }
}

class ShowTile extends StatelessWidget {
  const ShowTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        return state.tileDisplay ? Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('X: ${state.X}'),
                  const SizedBox(
                    width: 50,
                  ),
                  Text('Y: ${state.Y}'),
                ],
              ),
              const SizedBox(height: 15),
              Container(
                padding: const EdgeInsets.all(1),
                color: Colors.black,
                child: Container(
                  color: Colors.white,
                  child: Image.network(
                    "https://core-carparks-renderer-lots.maps.yandex.net/maps-rdr-carparks/tiles?l=carparks&x=${state.X}&y=${state.Y}&z=${state.zoom}&scale=1&lang=ru_RU",
                    errorBuilder:
                        (BuildContext context, Object exception, StackTrace? stackTrace) {
                      return const Text('По введеным координатам Tile не найден.',style: TextStyle(color: Colors.red,fontWeight: FontWeight.w600),);
                    },

                  ),
                ),
              )
            ],
          ),
        ) : const SizedBox.shrink();
      },
    );
  }
}
