import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:subspace_blog/hive_database/hive_database.dart';
import 'package:subspace_blog/screens/blogdetail.dart';

class FavouriteBlogScreen extends StatefulWidget {
  const FavouriteBlogScreen({super.key});

  @override
  State<FavouriteBlogScreen> createState() => _FavouriteBlogScreenState();
}

class _FavouriteBlogScreenState extends State<FavouriteBlogScreen> {
  final _mybox = Hive.box('mybox');
  Hivedatabase db = Hivedatabase();

  @override
  void initState() {
    if (_mybox.get("Favourite") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1a1b1a),
      body: ListView.builder(
        itemCount: db.listfavourite.length,
        // itemCount: 3,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => BlogDetail(
                              data: db.listfavourite[index],
                            )));
              },
              child: Slidable(
                endActionPane: ActionPane(motion: StretchMotion(), children: [
                  SlidableAction(
                    onPressed: (context) {
                      db.listfavourite.remove(db.listfavourite[index]);
                      setState(() {});
                    },
                    icon: Icons.delete,
                    backgroundColor: Colors.red.shade300,
                    borderRadius: BorderRadius.circular(12),
                  )
                ]),
                child: Card(
                  color: Color(0xff1a1b1a),
                  elevation: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //title
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Text(
                            db.listfavourite[index].title,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),

                      // image
                      SizedBox(
                          // width: 200,
                          height: 100,
                          child: Image.network(
                            db.listfavourite[index].imageUrl,
                            fit: BoxFit.contain,
                          ))
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
