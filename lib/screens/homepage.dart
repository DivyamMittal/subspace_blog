import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:subspace_blog/Apis/apis.dart';
import 'package:subspace_blog/hive_database/hive_database.dart';
import 'package:subspace_blog/model/blog_model.dart';
import 'package:subspace_blog/screens/blogdetail.dart';
import 'package:subspace_blog/widgets/blogcard.dart';

class Homepage extends StatefulWidget {
  const Homepage({
    super.key,
  });

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final _mybox = Hive.box('mybox');
  Hivedatabase db = Hivedatabase();

  @override
  void initState() {
    if (_mybox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  bool isPresent(BlogModel data) {
    for (BlogModel d in db.listfavourite) {
      if (d.id == data.id) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Color(0xff1a1b1a),
        //   title: Image.asset(
        //     "assets/images/subspace_logo.png",
        //     height: 40,
        //   ),
        // ),
        backgroundColor: Color(0xff1a1b1a),
        body: FutureBuilder(
          future: APIs().fetchBlogs(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  // return BlogCard().blogcard(context, snapshot.data![index]);
                  var data = snapshot.data![index];
                  // return ValueListenableBuilder(
                  //     valueListenable: Hive.box('mybox').listenable(),
                  //     builder: (context, box, widget) {
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
                          margin: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                          color: Color(0xff1a1b1a),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: data.imageUrl != null
                                    ? Image.network(
                                        data.imageUrl,
                                      )
                                    : Image.asset(
                                        "assets/images/placeholder.png"),
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
                                  if (!isPresent(data)) {
                                    db.listfavourite.add(data);

                                    data.isFavourite = true;
                                    db.updateDatabase();
                                    log("data added");
                                  } else if (isPresent(data)) {
                                    log("Data is remocved");
                                    db.listfavourite.removeWhere(
                                        (blog) => blog.id == data.id);
                                    data.isFavourite = false;
                                    db.updateDatabase();
                                  }
                                  log("length of f list is: ${db.listfavourite.length}");

                                  for (var blog in db.listfavourite) {
                                    log("id: ${blog.id}, imageUrl: ${blog.imageUrl}, title: ${blog.title}");
                                  }
                                  setState(() {});
                                },
                                icon: isPresent(data)
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
                  // }
                  // );
                },
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}
