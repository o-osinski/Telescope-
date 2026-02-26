class Telescope {
  double coordX,coordY;
  double orientation, tilt;

  Telescope(this.coordX,this.coordY,this.orientation,this.tilt);

  List<double> getCoord() => [this.coordX,this.coordY];

  double getOrientation() => this.orientation;

  double getTilt() => this.tilt;

  void setCoord(double x,double y) {
    coordX = x; 
    coordY = y;
  } 

  void setOrientation (double newOrientation) {
    orientation = newOrientation;
  }

  void setTilt (double newTilt){
    tilt = newTilt;
  }
}