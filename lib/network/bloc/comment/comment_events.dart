import 'package:flutter/cupertino.dart';

@immutable
abstract class CommentEvents {
  const CommentEvents();

}

class FetchData extends CommentEvents {
  final String postId;

  const FetchData(
      this.postId);

  @override
  List<Object?> get props => [postId];

  @override
  String toString() => 'Post Id: $postId}';
}
