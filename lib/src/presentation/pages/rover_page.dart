import 'package:flutter/material.dart';
import 'package:nasa_space_data/common/bloc_provider.dart';
import 'package:nasa_space_data/src/presentation/bloc/rover_bloc.dart';
import 'package:nasa_space_data/src/presentation/bloc/rover_event.dart';
import 'package:nasa_space_data/src/presentation/bloc/rover_state.dart';

class RoverPage extends StatelessWidget {
  const RoverPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<RoverBloc>(
        bloc: RoverBloc(),
        child: Builder(builder: (context) {
          return Center(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Test bloc"),
              StreamBuilder(
                stream: BlocProvider.of<RoverBloc>(context).outState,
                builder: (context, snapshot) {
                  var data = snapshot.data;
                  if (data is RoverLoadState) {
                    return const CircularProgressIndicator();
                  } else if (data is RoverLoadedState) {
                    return ListView(
                      shrinkWrap: true,
                      children: data.rovers
                          .map((e) => ListTile(
                                title: Text(e.name),
                              ))
                          .toList(),
                    );
                  }
                  return const Text("Нет данных");
                },
              ),
              ElevatedButton(
                onPressed: () {
                  BlocProvider.of<RoverBloc>(context)
                      .inEvent
                      .add(LoadRoverListEvent());
                },
                child: const Text("Add event"),
              )
            ],
          ));
        }),
      ),
    );
  }
}
