class SpatialObject  {
  String id;
  String name;
  List coord;
  double distance;
  String designation;

  SpatialObject(this.id,this.name,this.coord,this.distance,this.designation);

  String getId() => id;
  String getName() => name;
  List<dynamic> getCoord() => coord;
  void setCoord(List coordInput) => coord = coordInput;
  double getDistance() => distance;
}
