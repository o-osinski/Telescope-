// Import the test package and Counter class
import 'package:telescope/data/classes/spatial_object.dart';
import 'package:telescope/data/constants.dart';
import 'package:test/test.dart';

void main() {
  group('getType, getCoord, getDistance', () {
    SpatialObject sun = SpatialObject(SpatialObjectType.star,"sun",0.0,0.0,0.0);
    test('Get type : should be star', () {
      expect(sun.getType(), SpatialObjectType.star);
    });

    test('Get name : should be sun', () {
      expect(sun.getName(), "sun");
    });

    test('Get Coordonate : should be [0.0,0.0]', () {
      expect(sun.getCoord(), [0.0,0.0]);
    });

    test('Get distance : should be 0.0', () {
      expect(sun.getDistance(), 0.0);
    });
    });
}