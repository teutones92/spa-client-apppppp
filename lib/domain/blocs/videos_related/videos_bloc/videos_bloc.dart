import 'package:flutter/material.dart';

import 'package:spa_client_app/config/bloc_config.dart';
import 'package:spa_client_app/global/global_video_player_view/global_video_player_view.dart';
import 'package:spa_client_app/models/server/videos_folder_model/videos_folder_model.dart';

class VideosBlocState {
  final List<VideoModel> videosList;
  final VideoModel? video;
  final List<VideosFolderModel> foldersList;
  final VideosFolderModel? folder;

  VideosBlocState(
      {required this.videosList,
      required this.foldersList,
      required this.folder,
      required this.video});

  factory VideosBlocState.initial() => VideosBlocState(
      videosList: [], foldersList: [], folder: null, video: null);

  VideosBlocState copyWith(
          {List<VideoModel>? videosList,
          List<VideosFolderModel>? foldersList,
          VideosFolderModel? folder,
          VideoModel? video}) =>
      VideosBlocState(
        videosList: videosList ?? this.videosList,
        foldersList: foldersList ?? this.foldersList,
        folder: folder ?? this.folder,
        video: video ?? this.video,
      );
}

class VideosBloc extends Cubit<List<VideoModel>> {
  VideosBloc() : super([]);

  void emitVideos(List<VideoModel> videos) => emit(videos);

  Future<void> playVideo(VideoModel video, BuildContext context) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return GlobalVideoPlayerView(
            videoUrl: video.videoUrl,
            videoName: video.title,
          );
        },
      ),
    );
  }
}
