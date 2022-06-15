import 'package:equatable/equatable.dart';
import 'package:flutter_api_with_bloc/network/model/comment_response.dart';
import 'package:flutter_api_with_bloc/network/model/post_response.dart';

abstract class ViewState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadingState extends ViewState {}

class InitialState extends ViewState {}

class LoadedState extends ViewState {
  final List<PostResponse>? postResponse;
  final List<CommentResponse>? commentResponse;

  LoadedState({this.commentResponse, this.postResponse});
}

/// State indicating that data was loaded successfully, but was null or empty.
class Empty extends ViewState {
  final msg;

  Empty({this.msg});
}

class ErrorState extends ViewState {
  final error;

  ErrorState({this.error});
}
