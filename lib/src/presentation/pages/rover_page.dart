import 'package:flutter/material.dart';
import 'package:nasa_space_data/common/bloc_provider.dart';
import 'package:nasa_space_data/src/presentation/bloc/rover/rover_bloc.dart';
import 'package:nasa_space_data/src/presentation/bloc/rover/rover_state.dart';

class RoverPage extends StatelessWidget {
  const RoverPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Список роверов")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder(
              stream: BlocProvider.of<RoverBloc>(context).outState,
              builder: (context, snapshot) {
                var data = snapshot.data;
                if (data is RoverLoadState) {
                  return const Center(child: CircularProgressIndicator());
                } else if (data is RoverLoadErrorState) {
                  return Text(data.msg);
                } else if (data is RoverLoadedState) {
                  return Expanded(
                    child: ListView(
                      children: data.rovers
                          .map((e) => Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(children: [
                                    Text(e.name,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold)),
                                    e.maxDate != null
                                        ? Text(
                                            "Дата последнего обновления: ${e.maxDate!.day.toString().padLeft(2, '0')}.${e.maxDate!.month.toString().padLeft(2, '0')}.${e.maxDate!.year}")
                                        : const Text("Неизвестно"),
                                    const Text("Камеры:"),
                                    Column(
                                      children: (e.cameras ?? [])
                                          .map(
                                            (camera) => ListTile(
                                              title: Text(camera.name),
                                              onTap: () {
                                                Navigator.of(context).pushNamed(
                                                    '/photos',
                                                    arguments: {
                                                      "camera": camera,
                                                      "rover": e,
                                                      "earthDate": e.maxDate,
                                                    });
                                              },
                                            ),
                                          )
                                          .toList(),
                                    ),
                                  ]),
                                ),
                              ))
                          .toList(),
                    ),
                  );
                }
                return const Center(child: Text("Нет данных"));
              },
            ),
          ],
        ),
      ),
    );
  }
}
