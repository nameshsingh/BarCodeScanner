import 'package:flutter/material.dart';
import 'home_page.dart';

// Define this in your main.dart or a separate theme file
ThemeData appTheme() {
  return ThemeData(
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: Colors.blueGrey, // Previously known as accent color
      // Define other colorScheme properties as needed
    ),
    textTheme: TextTheme(
      headline6: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
      subtitle1: TextStyle(fontSize: 18.0, fontStyle: FontStyle.italic, color: Colors.blueGrey),
      button: TextStyle(color: Colors.white),
    ),
    // Define other theme properties as needed
  );
}


void main() => runApp(MaterialApp(theme: appTheme(), home: DefaultTabController(length: 2, child: HomePage())));
