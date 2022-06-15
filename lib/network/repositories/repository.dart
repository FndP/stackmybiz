import 'package:flutter_api_with_bloc/network/api/service_api.dart';
import 'package:flutter_api_with_bloc/network/model/comment_response.dart';
import 'package:flutter_api_with_bloc/network/model/post_response.dart';

class PostRepository {
  Future<List<PostResponse>> getPostList() {
    return ApiService().getPosts();
  }
}

class CommentRepository {
  Future<List<CommentResponse>> getCommentList({required String postId}) {
    return ApiService().getComments(postId: postId);
  }
}
