import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:subspace_blog/screens/navigation_controller.dart';

import 'hive_database/blog_model_adapter.dart';

void main() async {
  // initialize the hive
  await Hive.initFlutter();
  Hive.registerAdapter(BlogModelAdapter());

  // open a box
  var box = await Hive.openBox("mybox");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        iconTheme: IconThemeData(color: Colors.white), // Custom icon color
        textTheme: TextTheme(
          headline6: TextStyle(
            color: Colors.white, // Custom text color for the AppBar title
            fontSize: 20.0, // Custom font size for the AppBar title
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: NavigationController(),
    );
  }
}
