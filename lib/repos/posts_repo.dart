import 'dart:convert';
import 'dart:developer';
 import 'package:http/http.dart' as http;

import '../models/post_data_ui_model.dart';
import '../utils/app_settings.dart';

class PostsRepo {
  static Future<List<PostDataUiModel>> fetchPosts() async {
    var client = http.Client();
    List<PostDataUiModel> posts = [];
    try {
      var response = await client.get(Uri.parse(AppSettings.apiConst.postsUrl));
      List result = jsonDecode(response.body);

      for (int i = 0; i < result.length; i++) {
        PostDataUiModel post = PostDataUiModel.fromMap(result[i] as Map<String, dynamic>);
        posts.add(post);
      }

      return posts;
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

}
