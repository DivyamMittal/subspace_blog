import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:subspace_blog/model/blog_model.dart';

class APIs {
  Future<List<BlogModel>> fetchBlogs() async {
    List<dynamic> list;
    final String url = 'https://intent-kit-16.hasura.app/api/rest/blogs';
    final String adminSecret =
        '32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6';

    try {
      final response = await http.get(Uri.parse(url), headers: {
        'x-hasura-admin-secret': adminSecret,
      });

      if (response.statusCode == 200) {
        var data = response.body;
        final decodedData = jsonDecode(data);
        if (decodedData["blogs"] != null) {
          List<BlogModel> blogs = (decodedData["blogs"] as List)
              .map((blogJson) => BlogModel.fromJson(blogJson))
              .toList();
          return blogs;
        } else {
          return [];
        }
        // print('Response data: ${response.body}');
      } else {
        // Request failed
        return [];
        // print('Request failed with status code: ${response.statusCode}');
        // print('Response data: ${response.body}');
      }
    } catch (e) {
      // Handle any errors that occurred during the request
      print('Error: $e');
      return [];
    }
  }
}
