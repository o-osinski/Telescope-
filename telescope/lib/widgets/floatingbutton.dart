import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:telescope/data/constants.dart';
import 'package:sensors_plus/sensors_plus.dart';

void getOrientation() {
  var accelerometer;
  accelerometer = accelerometerEventStream().listen((AccelerometerEvent event){
      telescope.setTilt([event.x,event.y,event.z]);
      accelerometer.cancel();
    },
    onError: (error) {
      },
    cancelOnError: true,
  );
  var magnetometer;
  magnetometer = magnetometerEventStream().listen(
    (MagnetometerEvent event) {
      telescope.setOrientation([event.x,event.y,event.z]);
      magnetometer.cancel();
    },
    onError: (error) {
      },
    cancelOnError: true,
  );
}

void calibrate() async {
  bool serviceEnabled;
  LocationPermission permission;
  //Get Location
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }
  
  if (permission == LocationPermission.deniedForever) {
    return Future.error(
      'Location permissions are permanently denied, we cannot request permissions.');
  }
  //Set Location
  Position position = await Geolocator.getCurrentPosition();
  telescope.setCoord(position.latitude,position.longitude);

}

class FloatingActionButtonExampleApp extends StatelessWidget {
  const FloatingActionButtonExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: FloatingActionButtonExample());
  }
}

class FloatingActionButtonExample extends StatelessWidget {
  const FloatingActionButtonExample({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
                  onPressed: () {
                    calibrate();
                    getOrientation();
                    print(telescope.getCoord().toString());
                    print(telescope.getTilt().toString());
                    print(telescope.getOrientation().toString());
                  },
                  label: const Text('Calibrate'),
                  icon: const Icon(Icons.compass_calibration_sharp),
          );
  }
}