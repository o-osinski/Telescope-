import 'package:flutter/material.dart';
import 'package:telescope/widgets/modal.dart';
import 'package:telescope/widgets/searchbar.dart';
import 'package:telescope/widgets/floatingbutton.dart';
import 'dart:io';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDark = false;
  String filterQuery = "";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorSchemeSeed: const Color(0xff6750a4),
        brightness: isDark ? Brightness.dark : Brightness.light,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('Fetch Data Telescope')),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SearchBarAppState(
                onSearch: (String query) {
                  setState(() {
                    filterQuery = query;
                  });
                },
              ),
              BottomSheetExample(filterQuery: filterQuery),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButtonExample(),
      ),
    );
  }
}