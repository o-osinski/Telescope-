// ignore_for_file: must_be_immutable

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:telescope/data/classes/major_bodies.dart';
import 'package:http/http.dart' as http;

Future<MajorBodies> fetchSpatialObject() async {
  final response = await http.get(
    Uri.parse("https://ssd.jpl.nasa.gov/api/horizons.api?format=json&COMMAND='MB'"),
  );
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return MajorBodies.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Planets');
  }
}

Future<String> fetchSpatialData(MajorBodies mb, String id) async {
  final startDate = DateTime.now().toString().substring(0,10);
  final day = int.parse(startDate.substring(8,10))+1;
  final endDate = DateTime.now().toString().substring(0,8) + day.toString();
  final time = DateTime.now().toString().substring(11,16);
  final response = await http.get(
    Uri.parse("https://ssd.jpl.nasa.gov/api/horizons.api?format=json&COMMAND='$id'&OBJ_DATA='YES'&MAKE_EPHEM='YES'&EPHEM_TYPE='OBSERVER'&CENTER='500@399'&START_TIME='$startDate'&STOP_TIME='$endDate'&STEP_SIZE='10m'&QUANTITIES='1'"),
  );
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    String data = mb.decode(jsonDecode(response.body) as Map<String, dynamic>);
    return data;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Planets');
  }
}

class BottomSheetExample extends StatelessWidget {
  BottomSheetExample({super.key});
  late Future<MajorBodies> futureSpatialObject = fetchSpatialObject();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<MajorBodies>(
            future: futureSpatialObject,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              else if (snapshot.hasData){
                return Scaffold (
                  body: SingleChildScrollView(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children : [
                            for ( var majorBodies in snapshot.data!.majorBodies )
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10.0),
                              child : SizedBox(
                                width: 400.0,
                                height: 100.0,
                                child: ElevatedButton(
                                  child: Text(majorBodies.getName()),
                                  onPressed: () async {
                                    String data = await fetchSpatialData(snapshot.data!,majorBodies.id).then((value) {return value;});
                                    showModalBottomSheet<void>(
                                      // ignore: use_build_context_synchronously
                                      context: context,
                                      builder: (BuildContext context) {
                                        return 
                                          SizedBox(
                                          height: 400,
                                          child: SingleChildScrollView(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                Container(
                                                  padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                                                  margin: EdgeInsets.symmetric(vertical: 20.0),
                                                  child :Text(data),
                                                ),
                                                SizedBox (
                                                  height: 50,
                                                  width: 300,
                                                  child: Align(
                                                    alignment: Alignment.bottomCenter,
                                                    child : ElevatedButton(
                                                      child: const Text('Close BottomSheet'),
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
                    ),
                );
              }
              else {
                return const CircularProgressIndicator();
              }
            },
      ),
    ),
    );
  }
}