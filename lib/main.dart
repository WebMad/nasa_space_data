import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:nasa_space_data/src/presentation/pages/rover_page.dart';
import 'service_locator.dart' as di;

void main() async {
  await dotenv.load(fileName: ".env");
  await di.init();

  runApp(
    MaterialApp(
      builder: (context, child) {
        return const RoverPage();
      },
    ),
  );
}
