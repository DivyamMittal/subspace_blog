import 'package:hive_flutter/hive_flutter.dart';
import 'package:get/get.dart';
import 'package:subspace_blog/model/blog_model.dart';

class Hivedatabase {
  List<BlogModel> listfavourite = <BlogModel>[];

  // reference our box
  final _myBox = Hive.box("mybox");

  // run this method if this is the first time ever opening the app
  void createInitialData() {
    listfavourite =
        List<BlogModel>.from(_myBox.get("Favourite", defaultValue: []));
    // listfavourite.add(BlogModel(id: "1", imageUrl: "imageUrl", title: "title"));
  }

  // load the data from database
  // void loadData() {
  //   listfavourite = _myBox.get("Favourite") ?? <BlogModel>[];
  // }

  void loadData() {
    final dynamic data = _myBox.get("Favourite");
    if (data != null) {
      listfavourite = List<BlogModel>.from(data);
    } else {
      listfavourite = <BlogModel>[];
    }
    // listfavourite = _myBox.get("Favourite");
  }

  // update the database
  void updateDatabase() {
    _myBox.put("Favourite", listfavourite);
  }
}
