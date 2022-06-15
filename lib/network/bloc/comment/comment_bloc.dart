import 'dart:io';
import 'package:flutter_api_with_bloc/network/model/comment_response.dart';
import 'package:flutter_api_with_bloc/network/repositories/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../view_state.dart';
import 'comment_events.dart';

class CommentBloc extends Bloc<CommentEvents,ViewState>
{

  final CommentRepository repository;
  late List<CommentResponse> responseData;
  CommentBloc({required this.repository}) : super(InitialState());

  @override
  Stream<ViewState> mapEventToState(CommentEvents event) async* {
    if (event is FetchData) {
      yield  LoadingState();

      try {
        responseData = await repository.getCommentList(postId: event.postId);

        if(responseData.isNotEmpty){
          yield LoadedState(commentResponse: responseData);
        }else{
          yield Empty(msg: "No data found");
        }

      }on SocketException {
        yield ErrorState(
          error: ('No Internet'),
        );
      } on HttpException {
        yield ErrorState(
          error: ('No Service'),
        );
      } on FormatException {
        yield ErrorState(
          error: ('No Format Exception'),
        );
      } catch (e) {
        print(e.toString());
        yield ErrorState(
          error: ('Un Known Error ${e.toString()}'),
        );
      }
    }
  }

}