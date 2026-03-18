class SpatialObject  {
  String id;
  String name;
  double coordX;
  double coordY;
  double distance;

  SpatialObject(this.id,this.name,this.coordX,this.coordY,this.distance);

  String getId() => id;
  String getName() => name;
  List<double> getCoord() => [coordX,coordY];
  double getDistance() => distance;
}
