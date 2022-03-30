import 'package:flutter/material.dart';
import 'package:nasa_space_data/common/bloc_provider.dart';
import 'package:nasa_space_data/src/domain/entities/camera_entity.dart';
import 'package:nasa_space_data/src/domain/entities/rover_entity.dart';
import 'package:nasa_space_data/src/presentation/bloc/photo_list/photo_list_bloc.dart';
import 'package:nasa_space_data/src/presentation/bloc/photo_list/photo_list_event.dart';
import 'package:nasa_space_data/src/presentation/bloc/photo_list/photo_list_state.dart';
import 'package:nasa_space_data/src/presentation/bloc/rover/rover_event.dart';

class PhotoListPage extends StatefulWidget {
  final RoverEntity rover;
  final CameraEntity camera;
  final DateTime earthDate;

  const PhotoListPage(
      {Key? key,
      required this.rover,
      required this.camera,
      required this.earthDate})
      : super(key: key);

  @override
  State<PhotoListPage> createState() => _PhotoListPageState();
}

class _PhotoListPageState extends State<PhotoListPage> {
  final scroll = ScrollController();

  late DateTime earthDate;

  @override
  void initState() {
    earthDate = widget.earthDate;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    scroll.addListener(() {
      if (scroll.position.atEdge) {
        if (scroll.position.pixels != 0) {
          BlocProvider.of<PhotoListBloc>(context).inEvent.add(
              PhotoListLoadEvent(
                  camera: widget.camera.name,
                  earthDate: earthDate,
                  rover: widget.rover.name));
        }
      }
    });
    return Scaffold(
      appBar: AppBar(
          title: Text(
              "Ровер: ${widget.rover.name} | Камера: ${widget.camera.name}")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                        "Дата выборки: ${earthDate.day.toString().padLeft(2, '0')}.${earthDate.month.toString().padLeft(2, '0')}.${earthDate.year}"),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () {
                    showDatePicker(
                            context: context,
                            initialDate: earthDate,
                            firstDate: widget.rover.landingDate,
                            lastDate: widget.rover.maxDate!)
                        .then((value) => setState(() {
                              if (value != null) {
                                earthDate = value;
                                BlocProvider.of<PhotoListBloc>(context)
                                    .inEvent
                                    .add(PhotoListLoadEvent(
                                      rover: widget.rover.name,
                                      earthDate: value,
                                      camera: widget.camera.name,
                                      changedDate: true,
                                    ));
                              }
                            }));
                  },
                ),
              ],
            ),
            Expanded(
              child: StreamBuilder(
                stream: BlocProvider.of<PhotoListBloc>(context).outState,
                builder: (context, snapshot) {
                  var data = snapshot.data;
                  if (data is PhotoListLoadState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (data is PhotoListLoadErrorState) {
                    return Center(
                      child: Text(data.msg),
                    );
                  } else if (data is PhotoListLoadedState &&
                      data.photos.isNotEmpty) {
                    return ListView.builder(
                      controller: scroll,
                      itemCount: data.photos.length,
                      itemBuilder: (context, index) {
                        return Image.network(
                          data.photos[index].imgSrc,
                          key: ValueKey(data.photos[index].id),
                        );
                      },
                    );
                  }

                  return const Center(child: Text("Нет данных"));
                },
              ),
            ),
            StreamBuilder(
              stream: BlocProvider.of<PhotoListBloc>(context).outState,
              builder: (context, snapshot) {
                var data = snapshot.data;
                if (data is PhotoListAdditionLoadingState) {
                  return const SizedBox(
                    width: 60,
                    height: 60,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                return const Text("");
              },
            ),
          ],
        ),
      ),
    );
  }
}
