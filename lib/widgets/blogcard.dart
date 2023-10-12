import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:subspace_blog/screens/blogdetail.dart';

import '../hive_database/hive_database.dart';
import '../model/blog_model.dart';

class BlogCard {
  final _mybox = Hive.box('mybox');
  Hivedatabase db = new Hivedatabase();

  Widget blogcard(BuildContext context, BlogModel data) {
    return ValueListenableBuilder(
        valueListenable: Hive.box('mybox').listenable(),
        builder: (context, box, widget) {
          return InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => BlogDetail(
                            data: data,
                          )));
            },
            child: Stack(
              children: [
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  color: Color(0xff1a1b1a),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: data.imageUrl != null
                            ? Image.network(
                                data.imageUrl,
                              )
                            : Image.asset("assets/images/placeholder.png"),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        data.title,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Positioned(
                    right: 25,
                    top: 25,
                    child: CircleAvatar(
                      backgroundColor: Colors.white.withOpacity(0.2),
                      child: IconButton(
                        onPressed: () {
                          // if (!data.isFavourite) {
                          //   db.listfavourite.add(data);
                          //   // db.updateDatabase();
                          //   data.isFavourite = true;
                          // } else {
                          //   db.listfavourite.remove(data);
                          //   // db.updateDatabase();
                          //   data.isFavourite = false;
                          // }
                          db.listfavourite.add(data);
                          db.updateDatabase();
                          // Only call setState() if the state of the button has changed.
                          // log("$data");
                          log("length of f list is: ${db.listfavourite.length}");
                          // log(db.listfavourite.toString());
                          for (var blog in db.listfavourite) {
                            log("id: ${blog.id}, imageUrl: ${blog.imageUrl}, title: ${blog.title}");
                          }
                          // setState(() {});
                        },
                        icon: data.isFavourite
                            ? Icon(
                                Icons.favorite,
                                color: Colors.red,
                              )
                            : Icon(Icons.favorite_outline),
                      ),
                    ))
              ],
            ),
          );
        });
  }
}
