import 'package:flutter/material.dart';
import 'package:flutter_api_with_bloc/screens/login_screen.dart';
// import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'main.dart';
import 'network/bloc/comment/comment_bloc.dart';
import 'network/bloc/post/post_bloc.dart';
import 'network/bloc/theme/theme_bloc.dart';
import 'network/repositories/repository.dart';
import 'screens/dashboard_screen.dart';
import 'utils/home_screen.dart';

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AppState();
  }
}

class AppState extends State<App> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeBloc(),
      child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (BuildContext context, ThemeState themeState) {
            return MultiBlocProvider(
              providers: [
                BlocProvider<CommentBloc>(
                  create: (BuildContext context) => CommentBloc(repository: CommentRepository()),
                ),
                BlocProvider<PostBloc>(
                  create: (BuildContext context) => PostBloc(repository: PostRepository()),
                ),
              ],
              child: Sizer(
                  builder: (context, orientation, deviceType) {
                    return MaterialApp(
                        theme: themeState.themeData,
                        debugShowCheckedModeBanner: false,
                        home: storage.read('login')?DashboardScreen():LoginScreen()
                    );
                  }
              ),
            );
          }
      ),
    );
  }

}