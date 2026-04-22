import 'package:flutter/material.dart';
import 'package:telescope/data/classes/major_bodies.dart';
import 'package:telescope/widgets/modal.dart';
import 'package:telescope/data/classes/telescope.dart';


enum SpatialObjectType { star, satellite, planet, nebula, none}

Future<MajorBodies> futureSpatialObject = fetchSpatialObject();
List<ListTile> bodies = [];
List<String> filteredBodies = [];
Telescope telescope = Telescope(0.0,0.0,[0.0,0.0,0.0],[0.0,0.0,0.0]);
