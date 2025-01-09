import 'package:spa_client_app/config/bloc_config.dart';

class MainProviders {
  static get providers => [
        BlocProvider(create: (_) => LoginBloc()),
        BlocProvider(create: (_) => HomeBloc()),
        // BlocProvider(create: (_) => UsersDataBloc()),
        // BlocProvider(create: (_) => LandingBloc()),
        // BlocProvider(create: (_) => UserDataBloc()),
        // BlocProvider(create: (_) => ProfileBloc()),
        // BlocProvider(create: (_) => UsersRolesBloc()),
        // BlocProvider(create: (_) => UserWopBloc()),
        // BlocProvider(create: (_) => ManageVideosBloc()),
        // BlocProvider(create: (_) => VideosFolderBloc()),
        // BlocProvider(create: (_) => VideosBloc()),
        // BlocProvider(create: (_) => UserWopRoutinesBloc()),
        // BlocProvider(create: (_) => UserWopRoutinesDayBloc()),
        BlocProvider(create: (_) => ChatBloc()),
        // BlocProvider(create: (_) => TempUsersBloc()),
        BlocProvider(create: (_) => AssessmentsBloc()),
        BlocProvider(create: (_) => PublicityBloc()),
        // BlocProvider(create: (_) => ProductBloc()),
        BlocProvider(create: (_) => DiscountBloc()),
        BlocProvider(create: (_) => ClientAppSettingsBloc()),
      ];
}
