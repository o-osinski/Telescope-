// ignore_for_file: must_be_immutable

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:telescope/data/classes/major_bodies.dart';
import 'package:http/http.dart' as http;
import 'package:telescope/data/constants.dart';

Future<MajorBodies> fetchSpatialObject() async {
  final response = await http.get(
    Uri.parse("https://ssd.jpl.nasa.gov/api/horizons.api?format=json&COMMAND=%27MB%27"),
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

Future<String> fetchSpatialData(MajorBodies mb, String id, int position) async {
  final startDateRaw = DateTime.now();
  Duration duration = Duration(days:1);
  final endDate = startDateRaw.add(duration).toString().substring(0,10);
  final startDate = startDateRaw.toString().substring(0,10);
  //final time = DateTime.now().toString().substring(11,16);
  final response = await http.get(
    Uri.parse("https://ssd.jpl.nasa.gov/api/horizons.api?format=json&COMMAND=%27$id%27&OBJ_DATA=%27YES%27&MAKE_EPHEM=%27YES%27&EPHEM_TYPE=%27OBSERVER%27&CENTER=%27500@399%27&START_TIME=%27$startDate%27&STOP_TIME=%27$endDate%27&STEP_SIZE=%2710m%27&QUANTITIES=%271%27"),
  );
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    List result = mb.decode(jsonDecode(response.body) as Map<String, dynamic>);
    String data = result[0];
    List coord = result[1];
    if (position !=-1){
      mb.getMajorBodiesByID(position).setCoord(coord);  
    }
    return data;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Planets');
  }
}

class BottomSheetExample extends StatelessWidget {
  const BottomSheetExample({super.key});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MajorBodies>(
            future: futureSpatialObject,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              else if (snapshot.hasData){
                for ( var majorBodies in snapshot.data!.majorBodies ){
                  bodies.add(ListTile( title: Text(majorBodies.getName()),));
                }
                return Container(
                  child: () {
                     if (filteredBodies.isEmpty){
                      return SingleChildScrollView (
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
                                        String data = await fetchSpatialData(snapshot.data!,majorBodies.id,snapshot.data!.majorBodies.indexOf(majorBodies)).then((value) {return value;});
                                        showModalBottomSheet<void>(
                                          // ignore: use_build_context_synchronously
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
                    }
                    else{
                      for (var i =0;i<filteredBodies.length;){
                        return SingleChildScrollView (
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children : [
                                for ( var majorBodies in snapshot.data!.majorBodies )
                                if(majorBodies.getName().toLowerCase()==filteredBodies[i].toLowerCase())
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 10.0),
                                    child : SizedBox(
                                      width: 400.0,
                                      height: 100.0,
                                      child: ElevatedButton(
                                        child: Text(majorBodies.getName()),
                                        onPressed: () async {
                                          String data = await fetchSpatialData(snapshot.data!,majorBodies.id,-1).then((value) {return value;});
                                          showModalBottomSheet<void>(
                                            // ignore: use_build_context_synchronously
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
                      }
                    }
                  }(),);
                    }
              else {
                return const CircularProgressIndicator();
              }
            },
    );
  }
}