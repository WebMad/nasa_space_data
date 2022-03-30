import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:nasa_space_data/common/bloc_provider.dart';
import 'package:nasa_space_data/src/domain/entities/camera_entity.dart';
import 'package:nasa_space_data/src/domain/entities/rover_entity.dart';
import 'package:nasa_space_data/src/presentation/bloc/photo_list/photo_list_bloc.dart';
import 'package:nasa_space_data/src/presentation/bloc/photo_list/photo_list_event.dart';
import 'package:nasa_space_data/src/presentation/pages/photo_list_page.dart';
import 'package:nasa_space_data/src/presentation/pages/rover_page.dart';
import 'service_locator.dart' as di;
import 'src/presentation/bloc/rover/rover_bloc.dart';
import 'src/presentation/bloc/rover/rover_event.dart';
import 'src/presentation/pages/not_found_page.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  await di.init();

  runApp(
    MaterialApp(
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case "/":
            return MaterialPageRoute(
              builder: (context) => BlocProvider<RoverBloc>(
                bloc: () => RoverBloc()..inEvent.add(LoadRoverListEvent()),
                child: const RoverPage(),
              ),
            );
          case "/photos":
            return MaterialPageRoute(builder: (context) {
              var arguments = (settings.arguments as Map<String, dynamic>);
              return BlocProvider<PhotoListBloc>(
                bloc: () => PhotoListBloc()
                  ..inEvent.add(PhotoListLoadEvent(
                    earthDate: arguments["earthDate"],
                    camera: (arguments["camera"] as CameraEntity).name,
                    rover: (arguments["rover"] as RoverEntity).name,
                  )),
                child: PhotoListPage(
                    camera: arguments["camera"],
                    rover: arguments["rover"],
                    earthDate: arguments["earthDate"]),
              );
            });
        }
        return MaterialPageRoute(
          builder: (context) => const NotFoundPage(),
        );
      },
    ),
  );
}
