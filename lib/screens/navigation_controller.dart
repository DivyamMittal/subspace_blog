// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:subspace_blog/hive_database/hive_database.dart';
import 'package:subspace_blog/screens/favourite_blogs_screen.dart';
import 'package:subspace_blog/screens/homepage.dart';

class NavigationController extends StatefulWidget {
  const NavigationController({super.key});

  @override
  State<NavigationController> createState() => _NavigationControllerState();
}

class _NavigationControllerState extends State<NavigationController> {
  int indx = 0;
  final screens = [Homepage(), FavouriteBlogScreen()];
  final _mybox = Hive.box('mybox');
  Hivedatabase db = Hivedatabase();

  @override
  void initState() {
    if (_mybox.get("Favourite") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    // db.loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff1a1b1a),
        title: Image.asset(
          "assets/images/subspace_logo.png",
          height: 40,
        ),
      ),
      backgroundColor: Color(0xff1a1b1a),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
            elevation: 1,
            indicatorColor: Color(0xff444444),
            backgroundColor: Color(0xff1a1b1a),
            labelBehavior: NavigationDestinationLabelBehavior.alwaysHide),
        child: NavigationBar(
          selectedIndex: indx,
          onDestinationSelected: (value) => setState(() => indx = value),
          destinations: const [
            NavigationDestination(
                icon: Icon(
                  Icons.home,
                  color: Colors.white,
                ),
                label: "Home"),
            NavigationDestination(
                icon: Icon(
                  Icons.favorite_outline,
                  color: Colors.white,
                ),
                label: "Favourites"),
          ],
        ),
      ),
      body: screens[indx],
    );
  }
}
