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
  final response = await http.get(
    Uri.parse("https://ssd.jpl.nasa.gov/api/horizons.api?format=json&COMMAND='$id'"),
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
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    textStyle: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),
                                  child: Text(majorBodies.getName()),
                                  onPressed: () async {
                                    String data = await fetchSpatialData(snapshot.data!,majorBodies.id).then((value) {return value;});
                                    showModalBottomSheet<void>(
                                      // ignore: use_build_context_synchronously
                                      context: context,
                                      builder: (BuildContext context) {
                                        return SizedBox(
                                          height: 200,
                                          child: SingleChildScrollView(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                Text(data),
                                                ElevatedButton(
                                                  child: const Text('Close BottomSheet'),
                                                  onPressed: () => Navigator.pop(context),
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