import "package:telescope/data/classes/telescope.dart";
import "package:telescope/data/classes/spatial_object.dart";

class Application {
  dynamic myTelescope;
  dynamic target;
  dynamic api=0;

  Application(this.myTelescope,this.target);

  Telescope getTelescope() => myTelescope;

  SpatialObject getTarget() => target;

  dynamic getApi() => api;

  void setTelescope(Telescope newTelescope) {
    myTelescope = newTelescope;
  } 

  void setTarget(SpatialObject newTarget) {
    target = newTarget;
  } 
}

