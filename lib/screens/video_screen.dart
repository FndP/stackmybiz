import 'package:flutter/material.dart';
import 'package:flutter_api_with_bloc/screens/video_detail_screen.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({Key? key}) : super(key: key);

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          children: [
            GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => VideoDetailScreen(
                        color: Colors.amber,
                      )),
                );
              },
              child: Container(
                color: Colors.amber,
                height: 50,
              ),
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => VideoDetailScreen(
                        color: Colors.black,
                      )),
                );
              },
              child: Container(
                color: Colors.black,
                height: 50,
              ),
            )
          ],
        ),
      ),
    );
  }
}
