
import 'package:spa_client_app/config/bloc_config.dart';

import '../../../../models/server/videos_folder_model/videos_folder_model.dart';

class VideosFolderBloc extends Cubit<VideosFolderModel?> {
  VideosFolderBloc() : super(null);

  void emitFolder(VideosFolderModel folder) => emit(folder);

  // void readFolderById(String id, context) async {
  //   final folders = await context.read<ManageVideosBloc>().state;
  //   final folder = folders.firstWhere((element) => element.id == id);
  // }

  // void addVideos(BuildContext context) {
  //   final videos = context.read<VideosBloc>().state;
  //   if (videos.isEmpty) return;
  //   final folder = state;
  //   if (folder == null) return;
  //   folder.videos.addAll(videos);
  //   emit(folder);
  // }
}
