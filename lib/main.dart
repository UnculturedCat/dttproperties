import 'package:dttproperties/AppManagement/Navigation/navigation_manager.dart';
import 'package:dttproperties/AppManagement/Shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        //fontFamily: "Gotham SSm",
        textTheme: const TextTheme(
          titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          bodyLarge: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w500, color: detailColor),
          bodySmall: TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
          bodyMedium: TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
          labelLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
          labelMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
        ),
      ),
      home: NavigationManager(),
    );
  }
}
