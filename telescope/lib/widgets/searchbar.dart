import 'package:flutter/material.dart';

class SearchBarAppState extends StatefulWidget {
  final Function(String) onSearch;
  const SearchBarAppState({super.key, required this.onSearch});

  @override
  State<SearchBarAppState> createState() => _SearchBarAppStateState();
}

class _SearchBarAppStateState extends State<SearchBarAppState> {
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
              widget.onSearch(query);
            },
          );
        },
        suggestionsBuilder: (BuildContext context, SearchController controller) {
          return [];
        },
      ),
    );
  }
}