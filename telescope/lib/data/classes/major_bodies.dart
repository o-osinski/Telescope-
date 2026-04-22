import 'package:telescope/data/classes/spatial_object.dart';

class MajorBodies  {
  List<SpatialObject> majorBodies= [];

  MajorBodies(this.majorBodies);

  void setMajorBodies(List<SpatialObject> mb){
    majorBodies = mb;
  }
  List<SpatialObject> getMajorBodies(){
    return majorBodies;
  }

  SpatialObject getMajorBodiesByID(int id) {
    return majorBodies[id];
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
                listMajorBodies.add(SpatialObject(majorBodyId,majorBodyDesignation,[],0,""));
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

  List decode(Map<String, dynamic> json){
    String result = json['result'];
    bool startFound = false;
    int startIndex=0;
    int endIndex=0;
    for (var i=0;i<result.length-3;i++){
      if (result.substring(i,i+2) == '*\n' && !startFound){
        startIndex = i+2;
        startFound = true;
      }
      else if (result.substring(i,i+2) == "\n*" && startFound){
        endIndex = i-1;
        break;
      }
    }
    bool startFoundCoord = false;
    int startIndexCoord=0;
    int endIndexCoord=0;
    int row = 0;
    for (var i=0;i<result.length-6;i++){
      if (result.substring(i,i+5) == '\$\$SOE' && !startFoundCoord){
        startIndexCoord = i+5;
        startFoundCoord = true;
      }
      else if (result.substring(i,i+5) == "\$\$EOE" && startFoundCoord){
        endIndexCoord = i-1;
        break;
      }
      else if (result.substring(i,i+1) == "\n" && startFoundCoord){
        row +=1;
      }
    }
    String coord = result.substring(startIndexCoord,endIndexCoord);

    List coordClean = [];
    for (var j=0;j<row-1;j++){
      coordClean.add([coord.substring(j*47+1,j*47+13),coord.substring(j*47+14,j*47+19),coord.substring(j*47+24,j*47+35),coord.substring(j*47+36,j*47+47)]);
    }
    result = result.substring(startIndex,endIndex);
    return [result,coordClean];
  }
}
