import 'package:flutter_api_with_bloc/network/model/comment_response.dart';
import 'package:flutter_api_with_bloc/network/model/post_response.dart';
import 'package:flutter_api_with_bloc/utils/constants.dart';

import 'apiprovider.dart';

abstract class ServiceApi{
  Future<List<PostResponse>> getPosts();
  Future<List<CommentResponse>> getComments({String postId});
}

class ApiService extends ServiceApi{

  @override
  Future<List<PostResponse>> getPosts() async {
    ApiProvider apiProvider = ApiProvider();

    try {
      var response = await apiProvider.get(getPostsUrl);
      List<PostResponse> data = List<PostResponse>.from(response.map((x) => PostResponse.fromJson(x)));

      return data;
    } catch(e){
      throw e;
      // return List<PostResponse>.empty();
    }
  }

  @override
  Future<List<CommentResponse>> getComments({String postId = ""}) async {
    ApiProvider apiProvider = ApiProvider();

    try {
      var response = await apiProvider.get("$getCommentUrl?postId=$postId");
      List<CommentResponse> data = List<CommentResponse>.
      from(response.map((x) => CommentResponse.fromJson(x)));

      return data;
    } catch(e){
      return List<CommentResponse>.empty();
    }
  }
}