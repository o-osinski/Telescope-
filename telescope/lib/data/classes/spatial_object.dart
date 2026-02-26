import 'package:telescope/data/constants.dart';

class SpatialObject  {
  SpatialObjectType type;
  String name;
  double coordX;
  double coordY;
  double distance;

  SpatialObject(this.type,this.name,this.coordX,this.coordY,this.distance);

  SpatialObjectType getType() => type;
  String getName() => name;
  List<double> getCoord() => [coordX,coordY];
  double getDistance() => distance;
}
