import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:nasa_space_data/common/exceptions.dart';
import 'package:nasa_space_data/src/data/models/photo_model.dart';
import 'package:nasa_space_data/src/data/models/rover_model.dart';
import 'package:http/http.dart' as http;

abstract class NasaRemoteDataSource {
  Future<List<RoverModel>> roverList();

  Future<List<PhotoModel>> photoList(DateTime earthDate, String rover,
      {String camera = "all", int page = 1});
}

class NasaRemoteDataSourceImpl extends NasaRemoteDataSource {
  final http.Client httpClient;

  NasaRemoteDataSourceImpl(this.httpClient);

  @override
  Future<List<PhotoModel>> photoList(DateTime earthDate, String rover,
      {String camera = "all", int page = 1}) async {
    var response = await httpClient.get(Uri.parse(dotenv.env["BASE_URI"]! +
        "mars-photos/api/v1/rovers/$rover/photos?api_key="
            "${dotenv.env["NASA_API_KEY"]}&earth_date=${earthDate.year}-"
            "${earthDate.month}-${earthDate.day}&camera=$camera&page=$page"));

    if (response.statusCode == 200) {
      return (jsonDecode(response.body)["photos"] as List<dynamic>)
          .map((e) => PhotoModel.fromJson(e))
          .toList();
    }
    throw RequestException();
  }

  @override
  Future<List<RoverModel>> roverList() async {
    var response = await httpClient.get(Uri.parse(dotenv.env["BASE_URI"]! +
        "mars-photos/api/v1/rovers?api_key=${dotenv.env["NASA_API_KEY"]}"));

    if (response.statusCode == 200) {
      return (jsonDecode(response.body)["rovers"] as List<dynamic>)
          .map((e) => RoverModel.fromJson(e))
          .toList();
    }
    throw RequestException();
  }
}
