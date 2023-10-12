import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:subspace_blog/model/blog_model.dart';

class BlogDetail extends StatelessWidget {
  const BlogDetail({super.key, required this.data});
  final BlogModel data;

  @override
  Widget build(BuildContext context) {
    var txt =
        "Voluptate ullamco pariatur voluptate in ad ea sunt occaecat. In laboris voluptate tempor sint dolor sit esse. Sunt dolore minim excepteur aliquip tempor magna nisi. Ipsum cillum aute non velit id quis anim. Cupidatat velit minim veniam nostrud exercitation veniam labore proident nulla sit aute commodo. Exercitation aute cillum reprehenderit sint. \n";
    return Scaffold(
      backgroundColor: Color(0xff1a1b1a),
      appBar: AppBar(
        backgroundColor: Color(0xff1a1b1a),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(CupertinoIcons.back),
          color: Colors.white,
        ),
      ),

      // body
      body: SingleChildScrollView(
        child: Column(
          children: [
            // image
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: data.imageUrl != null
                    ? Image.network(
                        data.imageUrl,
                      )
                    : Image.asset("assets/images/placeholder.png"),
              ),
            ),

            SizedBox(
              height: 20,
            ),

            // title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  data.title,
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Divider(
                color: Colors.white,
                thickness: 0.5,
                indent: 20,
                endIndent: 20,
              ),
            ),

            // content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                txt,
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                txt,
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
