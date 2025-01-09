import 'package:flutter/material.dart';
import 'package:spa_client_app/config/bloc_config.dart';
import 'package:spa_client_app/domain/service/db_services/db_videos_service/db_videos_service.dart';
import 'package:spa_client_app/models/server/videos_folder_model/videos_folder_model.dart';

class ManageVideosBlocState {
  final List<VideosFolderModel> foldersList;
  final bool loading;
  final VideosFolderModel folder;

  ManageVideosBlocState({
    required this.foldersList,
    required this.loading,
    required this.folder,
  });

  ManageVideosBlocState copyWith({
    List<VideosFolderModel>? foldersList,
    bool? loading,
    VideosFolderModel? folder,
  }) => ManageVideosBlocState(
        foldersList: foldersList ?? this.foldersList,
        loading: loading ?? this.loading,
        folder: folder ?? this.folder,
      );


  factory ManageVideosBlocState.initial() =>
     ManageVideosBlocState(
      foldersList: [],
      loading: true,
      folder: VideosFolderModel(
        folderName: '',
        videos: [],
      ),
    );
  

}


class ManageVideosBloc extends Cubit<ManageVideosBlocState> {
  ManageVideosBloc() : super(ManageVideosBlocState.initial());
  final TextEditingController folderNameController = TextEditingController();
  final ValueNotifier<bool> activeFolderSelected = ValueNotifier<bool>(false);



  Future<void> readFolders() async {
    emit(state.copyWith(loading: true));
    final folders = await DbVideosService.readFolders();
    emit(state.copyWith(loading: false, foldersList: folders));
  }




  // void openFolder(VideosFolderModel folder, BuildContext context,
  //     {bool isUserWop = false}) {
  //   context.read<VideosFolderBloc>().emitFolder(folder);
  //   context.read<VideosBloc>().emitVideos(folder.videos);
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => VideosFolderView(isUserWop: isUserWop),
  //     ),
  //   );
  // }
}
