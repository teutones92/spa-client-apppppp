import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spa_client_app/config/theme_conf.dart';
import 'package:spa_client_app/domain/service/user_auth_service/user_auth_service.dart';
import 'package:spa_client_app/firebase_options.dart';
import 'package:spa_client_app/providers/main_provider.dart';
import 'package:spa_client_app/screens/start/start.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  UserAuthService.sharedPref = await SharedPreferences.getInstance();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: MainProviders.providers,
      child: MaterialApp(
        theme: MainThemeConf.theme(context),
        home: const Start(),
      ),
    );
  }
}
