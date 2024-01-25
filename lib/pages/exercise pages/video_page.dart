import 'package:flutter/material.dart';
import 'package:muscletracking_app/utils/video_app.dart';

class VideoPage extends StatelessWidget {
  final String muscleGroup;
  const VideoPage({super.key, required this.muscleGroup});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        forceMaterialTransparency: false,
        elevation: 1,
      ),
      body: VideoApp(
        videoName: muscleGroup,
      ),
    );
  }
}
