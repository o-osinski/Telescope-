import 'package:flutter/material.dart';
import 'package:telescope/data/constants.dart';
// ignore: must_be_immutable
class SearchBarAppState extends StatelessWidget {
  bool isDark = false;
  SearchBarAppState({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SearchAnchor(
            builder: (BuildContext context, SearchController controller) {
              return SearchBar(
                controller: controller,
                padding: const WidgetStatePropertyAll<EdgeInsets>(
                  EdgeInsets.symmetric(horizontal: 16.0),
                ),
                onSubmitted: (query) {
                  filteredBodies= [];
                  int start = 0;
                  if (query.isEmpty){
                    filteredBodies= [];
                  }
                  else {
                  for (var i=0;i<query.length;i++){
                    if (query.substring(i) == " "){
                      filteredBodies.add(query.substring(start,i));
                      start = i;
                    }
                  }
                  filteredBodies.add(query.substring(start,query.length));
                  }
                },
              );
            },
            suggestionsBuilder:
                (BuildContext context, SearchController controller) {
                  return bodies;
                },
          ),
        );
  }
  }