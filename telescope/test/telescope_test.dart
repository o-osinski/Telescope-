// Import the test package and Counter class
import 'package:telescope/data/classes/telescope.dart';
import 'package:test/test.dart';

void main() {
  group('Test getCoord, getOrientation, getTilt', () {
    Telescope myTelescope = Telescope(50.0, 50.0, 100.0, 350.0);
    test('Test getCoord, Should have [50.0,50.0]', () {
      expect(myTelescope.getCoord(),[50.0,50.0]);
    });

    test('Test getOrientation, Should have 100.0 ', () {
      expect(myTelescope.getOrientation(), 100.0);
    });

    test('Test getTilt, Should have 350.0 ', () {
      expect(myTelescope.getTilt(), 350.0);
    });
  });

    group('Test setCoord, setOrientation, setTilt', () {
    Telescope myTelescope = Telescope(50.0, 50.0, 100.0, 350.0);
    myTelescope.setCoord(20.0,30.0);
    myTelescope.setOrientation(2.0);
    myTelescope.setTilt(60.0);
    test('Test getCoord, Should have [50.0,50.0]', () {
      expect(myTelescope.getCoord(),[20.0,30.0]);
    });

    test('Test getOrientation, Should have 100.0 ', () {
      expect(myTelescope.getOrientation(), 2.0);
    });

    test('Test getTilt, Should have 350.0 ', () {
      expect(myTelescope.getTilt(), 60.0);
    });
  });
}