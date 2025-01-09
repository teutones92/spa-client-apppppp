import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class GlobalVideoPlayerView extends StatefulWidget {
  const GlobalVideoPlayerView(
      {super.key, required this.videoUrl, required this.videoName});
  final String videoUrl;
  final String videoName;

  @override
  State<GlobalVideoPlayerView> createState() => _GlobalVideoPlayerViewState();
}

class _GlobalVideoPlayerViewState extends State<GlobalVideoPlayerView> {
  late FlickManager flickManager;
  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.networkUrl(
        Uri.parse(widget.videoUrl),
      ),
    );
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Text(
            widget.videoName.isEmpty ? 'Video Player' : widget.videoName,
          ),
        ),
      ),
      body: FlickVideoPlayer(
        flickManager: flickManager,
        preferredDeviceOrientation: const [DeviceOrientation.portraitUp],
        preferredDeviceOrientationFullscreen: const [
          DeviceOrientation.landscapeLeft
        ],
      ),
    );
  }
}
