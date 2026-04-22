import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:telescope/data/classes/major_bodies.dart';
import 'package:http/http.dart' as http;

Future<MajorBodies> fetchSpatialObject() async {
  final response = await http.get(
    Uri.parse("https://ssd.jpl.nasa.gov/api/horizons.api?format=json&COMMAND=%27MB%27"),
  );
  if (response.statusCode == 200) {
    return MajorBodies.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to load Planets');
  }
}

Future<String> fetchSpatialData(MajorBodies mb, String id, int position) async {
  final startDateRaw = DateTime.now();
  Duration duration = const Duration(days: 1);
  final endDate = startDateRaw.add(duration).toString().substring(0, 10);
  final startDate = startDateRaw.toString().substring(0, 10);
  final response = await http.get(
    Uri.parse("https://ssd.jpl.nasa.gov/api/horizons.api?format=json&COMMAND=%27$id%27&OBJ_DATA=%27YES%27&MAKE_EPHEM=%27YES%27&EPHEM_TYPE=%27OBSERVER%27&CENTER=%27500@399%27&START_TIME=%27$startDate%27&STOP_TIME=%27$endDate%27&STEP_SIZE=%2710m%27&QUANTITIES=%271%27"),
  );
  if (response.statusCode == 200) {
    List result = mb.decode(jsonDecode(response.body) as Map<String, dynamic>);
    String data = result[0];
    List coord = result[1];
    if (position != -1) {
      mb.getMajorBodiesByID(position).setCoord(coord);
    }
    return data;
  } else {
    throw Exception('Failed to load Planets');
  }
}

class BottomSheetExample extends StatefulWidget {
  final String filterQuery;
  const BottomSheetExample({super.key, required this.filterQuery});

  @override
  State<BottomSheetExample> createState() => _BottomSheetExampleState();
}

class _BottomSheetExampleState extends State<BottomSheetExample> {
  late Future<MajorBodies> futureSpatialObject;

  @override
  void initState() {
    super.initState();
    futureSpatialObject = fetchSpatialObject();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MajorBodies>(
      future: futureSpatialObject,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('${snapshot.error}');
        } else if (snapshot.hasData) {
          final majorBodiesList = snapshot.data!.majorBodies;
          final filteredBodies = widget.filterQuery.isEmpty
              ? majorBodiesList
              : majorBodiesList.where((body) =>
                  body.getName().toLowerCase().contains(widget.filterQuery.toLowerCase()),
                ).toList();

          return SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var majorBodies in filteredBodies)
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                      child: SizedBox(
                        width: 400.0,
                        height: 100.0,
                        child: ElevatedButton(
                          child: Text(majorBodies.getName()),
                          onPressed: () async {
                            String data = await fetchSpatialData(
                              snapshot.data!,
                              majorBodies.id,
                              widget.filterQuery.isEmpty
                                  ? majorBodiesList.indexOf(majorBodies)
                                  : -1,
                            );
                            if (!mounted) return;
                            showModalBottomSheet<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return SizedBox(
                                  height: 400,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 10.0,
                                            horizontal: 10.0,
                                          ),
                                          margin: const EdgeInsets.symmetric(vertical: 20.0),
                                          child: Text(data),
                                        ),
                                        SizedBox(
                                          height: 50,
                                          width: 300,
                                          child: Align(
                                            alignment: Alignment.bottomCenter,
                                            child: ElevatedButton(
                                              child: const Text('Aim this target'),
                                              onPressed: () => Navigator.pop(context),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}