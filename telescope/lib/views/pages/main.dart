import 'package:flutter/material.dart';
import 'package:telescope/widgets/modal.dart';
import 'package:telescope/widgets/searchbar.dart';


void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDark = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(colorSchemeSeed: const Color(0xff6750a4),brightness: isDark ? Brightness.dark : Brightness.light,),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('Fetch Data Telescope')),
        body: Container( 
          // BoxDecoration takes the image
          decoration: BoxDecoration( 
            // Image set to background of the body
            image: DecorationImage( 
              image: AssetImage("background.jpg"), fit: BoxFit.cover
            ),
          ),
          child : BottomSheetExample(),
        ),
      ),
    );
  }
}



