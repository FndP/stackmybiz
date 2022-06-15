import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

var baseUrl = "http://jsonplaceholder.typicode.com/";

var randomLandScapeImageUrl = "https://picsum.photos/500/300?random=1";
var randomImageUrl = "https://picsum.photos/500/300?random=";

///api end points
String getPostsUrl = "posts";
String getCommentUrl = "comments";

///Common Error
String internetError = "Please Check Your network connectivity.";
String kContinue = "Continue";

Widget divider(){
  return Divider(
    color: Colors.grey,
    height: 1.h,
  );
}

printLog(var msg) {
  debugPrint(msg);
}

void stopKeyboard(BuildContext context) {
  FocusScope.of(context).requestFocus(FocusNode());
}