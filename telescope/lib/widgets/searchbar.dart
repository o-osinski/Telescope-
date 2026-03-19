import 'package:flutter/material.dart';
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
              );
            },
            suggestionsBuilder:
                (BuildContext context, SearchController controller) {
                  return List<ListTile> .generate(5, (int index) {
                    final String item = 'item $index';
                    return ListTile(
                      title: Text(item),
                      onTap: () {
                          controller.closeView(item);
                      },
                    );
                  });
                },
          ),
        );
  }
  }