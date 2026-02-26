// Import the test package and Counter class
import 'package:telescope/data/classes/application.dart';
import 'package:telescope/data/classes/telescope.dart';
import 'package:telescope/data/classes/spatial_object.dart';
import 'package:telescope/data/constants.dart';
import 'package:test/test.dart';

void main() {
  group('Test getTelescope, getTarget', () {
    SpatialObject sun = SpatialObject(SpatialObjectType.star,"sun",0.0,0.0,0.0);
    Telescope myTelescope = Telescope(50.0, 50.0, 100.0, 350.0);
    Application myApp = Application(myTelescope, sun);
    test('Test getTelescope, Should have myTelescope', () {
      expect(myApp.getTelescope(),myTelescope);
    });

    test('Test getTarget, Should have sun', () {
      expect(myApp.getTarget(),sun);
    });
  });

    group('Test setCoord, setOrientation, setTilt', () {
    SpatialObject sun = SpatialObject(SpatialObjectType.star,"sun",0.0,0.0,0.0);
    Telescope myTelescope = Telescope(50.0, 50.0, 100.0, 350.0);
    Application myApp = Application(myTelescope, sun);

    SpatialObject mars = SpatialObject(SpatialObjectType.planet,"mars",20.0,20.0,20.0);
    Telescope myOtherTelescope = Telescope(100.0, 150.0, 160.0, 250.0);
    myApp.setTarget(mars);
    myApp.setTelescope(myOtherTelescope);
    test('Test getTelescope, Should have myTelescope', () {
      expect(myApp.getTelescope(),myOtherTelescope);
    });

    test('Test getTarget, Should have sun', () {
      expect(myApp.getTarget(),mars);
    });
  });
}