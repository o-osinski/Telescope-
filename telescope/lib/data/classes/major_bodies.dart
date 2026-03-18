import 'package:telescope/data/classes/spatial_object.dart';

class MajorBodies  {
  List<SpatialObject> majorBodies= [];

  MajorBodies(this.majorBodies);

  void setMajorBodies(List<SpatialObject> mb){
    majorBodies = mb;
  }

  factory MajorBodies.fromJson(Map<String, dynamic> json) {
    String result = json['result'];
    var i =0;
    List<SpatialObject> listMajorBodies = [];
    while (result.substring(i,i+3)!='- \n') {
      i++;
    }
    var start = i+3;
    var startDataBody = start;
    for (var j=start;j<result.length-1;j++) {
        if (result.substring(j,j+1)=='\n') {
          var majorBody = result.substring(startDataBody,j+1);
          if (majorBody.length<10){
            break;
          }
          var majorBodyId = majorBody.substring(0,10);
          for(var l =0;l<majorBodyId.length;l++){
            if (majorBodyId.substring(l,l+1)!=" "){
              majorBodyId = majorBodyId.substring(l);
              break;
            }
          }
          var majorBodyDesignation = "";
          for (var k=12;k<majorBody.length-2;k++){
            if ((majorBody.substring(k,k+2)=="  ")){
              majorBodyDesignation = majorBody.substring(11,k);
              if (majorBodyDesignation != " "){
                listMajorBodies.add(SpatialObject(majorBodyId,majorBodyDesignation,0,0,0,""));
              }
              startDataBody = j+1;
              break;
            }
          }
        } 
      }
    listMajorBodies.sort((a, b) => a.name.compareTo(b.name));
    return MajorBodies(listMajorBodies);
  }

  String decode(Map<String, dynamic> json){
    String result = json['result'];
    return result;
  }
}
