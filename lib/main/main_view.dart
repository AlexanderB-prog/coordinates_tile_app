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
      backgroundColor: Colors.grey,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 230,
            child: TextField(
              onSubmitted: (text) {
                context.read<MainBloc>().add(InputZoomMainEvent(text));
              },
              onChanged: (text) {
                context.read<MainBloc>().add(InputZoomMainEvent(text));
              },
              maxLines: 1,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(0),
                hintStyle: const TextStyle(fontSize: 12),
                hintText: 'Zoom',
                prefixIcon: const Icon(
                  Icons.location_on,
                  color: Colors.grey,
                ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderSide: const BorderSide(style: BorderStyle.none),
                  borderRadius: BorderRadius.circular(20),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(style: BorderStyle.none),
                  borderRadius: BorderRadius.circular(20),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(style: BorderStyle.none),
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
              onSubmitted: (text) {
                context.read<MainBloc>().add(InputLatMainEvent(text));
              },
              onChanged: (text) {
                context.read<MainBloc>().add(InputLatMainEvent(text));
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
                  borderSide: const BorderSide(style: BorderStyle.none),
                  borderRadius: BorderRadius.circular(20),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(style: BorderStyle.none),
                  borderRadius: BorderRadius.circular(20),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(style: BorderStyle.none),
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
              onSubmitted: (text) {
                context.read<MainBloc>().add(InputLongMainEvent(text));
              },
              onChanged: (text) {
                context.read<MainBloc>().add(InputLongMainEvent(text));
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
                  borderSide: const BorderSide(style: BorderStyle.none),
                  borderRadius: BorderRadius.circular(20),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(style: BorderStyle.none),
                  borderRadius: BorderRadius.circular(20),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(style: BorderStyle.none),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                context.read<MainBloc>().add(FindTileMainEvent());
              },
              child: const Text('Посмотреть tile')),
          ShowTile(),
        ],
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
        return Container(
          color: Colors.grey,
          child: (state.X == 1 && state.Y == 1)
              ? SizedBox.shrink()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('X: ${state.X}'),
                        SizedBox(
                          width: 50,
                        ),
                        Text('Y: ${state.Y}'),
                      ],
                    ),
                    Container(
                      color: Colors.white,
                      child: Image.network(
                        "https://core-carparks-renderer-lots.maps.yandex.net/maps-rdr-carparks/tiles?l=carparks&x=${state.X}&y=${state.Y}&z=${state.zoom}&scale=1&lang=ru_RU",
                      ),
                    )
                  ],
                ),
        );
      },
    );
  }
}
