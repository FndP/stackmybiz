import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_api_with_bloc/utils/themes/app_theme.dart';

part 'theme_event.dart';

part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc()
      : super(
            ThemeState(themeData: AppThemes.appThemData[AppTheme.lightTheme]));

  @override
  Stream<ThemeState> mapEventToState(ThemeEvent event) async* {
    try {
      if (event is ThemeEvent) {
        yield ThemeState(
          themeData: AppThemes.appThemData[event.appTheme],
        );
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
