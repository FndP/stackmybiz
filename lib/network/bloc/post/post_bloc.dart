import 'dart:io';
import 'package:flutter_api_with_bloc/network/model/post_response.dart';
import 'package:flutter_api_with_bloc/network/repositories/repository.dart';
import '../view_state.dart';
import 'post_events.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostBloc extends Bloc<PostEvents,ViewState>
{

  final PostRepository repository;
  late List<PostResponse> responseData;
  PostBloc({required this.repository}) : super(InitialState());

  @override
  Stream<ViewState> mapEventToState(PostEvents event) async* {

    switch(event)
    {
      case PostEvents.fetchData:

        yield  LoadingState();

        try {
          responseData = await repository.getPostList();

          if(responseData.isNotEmpty){
            yield LoadedState(postResponse: responseData);
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
            error: ('${e.toString()}'),
          );
        }
        break;
    }

  }

}