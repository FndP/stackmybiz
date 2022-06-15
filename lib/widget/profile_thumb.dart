import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ProfileThumb extends StatelessWidget {
  String imgUrl;
  double? width;
  double? height;
  EdgeInsetsGeometry? margin;

  ProfileThumb(
      {required this.imgUrl, this.width, this.height, this.margin, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 6.h,
      width: width ?? 6.h,
      margin: margin ?? EdgeInsets.all(0),
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover, image: NetworkImage("$imgUrl")),
          borderRadius: BorderRadius.all(Radius.circular(10.h))),
    );
  }
}
