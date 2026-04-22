class Telescope {
  double coordX,coordY;
  List<double> orientation;
  List<double> tilt;
  Telescope(this.coordX,this.coordY,this.orientation,this.tilt);

  List<double> getCoord() => [coordX,coordY];

  List<double> getOrientation() => orientation;

  List<double> getTilt() => tilt;

  void setCoord(double x,double y) {
    coordX = x; 
    coordY = y;
  } 

  void setOrientation (List<double> newOrientation) {
    orientation = newOrientation;
  }

  void setTilt (List<double> newTilt){
    tilt = newTilt;
  }
}