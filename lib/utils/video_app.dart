import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoApp extends StatefulWidget {
  final String videoName;
  const VideoApp({super.key, required this.videoName});

  @override
  State<VideoApp> createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  late VideoPlayerController controller;
  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.asset(
        'lib/videos/${widget.videoName.toLowerCase()}.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
    controller.setLooping(true);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (!controller.value.isPlaying) {
            controller.play();
          } else {
            controller.pause();
          }
        });
      },
      child: controller.value.isInitialized
          ? AspectRatio(
              aspectRatio: controller.value.aspectRatio,
              child: VideoPlayer(controller),
            )
          : Container(),
    );
  }

  @override
  dispose() {
    super.dispose();
    controller.dispose();
  }
}
