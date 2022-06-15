import 'package:flutter/material.dart';

class VideoDetailScreen extends StatefulWidget {
  Color? color;
  VideoDetailScreen({this.color, Key? key}) : super(key: key);

  @override
  State<VideoDetailScreen> createState() => _VideoDetailScreenState();
}

class _VideoDetailScreenState extends State<VideoDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: widget.color,
      ),
    );
  }
}
