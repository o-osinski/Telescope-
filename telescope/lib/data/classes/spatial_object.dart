class SpatialObject  {
  String id;
  String name;
  double coordX;
  double coordY;
  double distance;
  String designation;

  SpatialObject(this.id,this.name,this.coordX,this.coordY,this.distance,this.designation);

  String getId() => id;
  String getName() => name;
  List<double> getCoord() => [coordX,coordY];
  double getDistance() => distance;
}
