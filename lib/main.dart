import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nrtfm/constant/color.dart';
import 'package:nrtfm/controller/login/login_bloc.dart';
import 'package:nrtfm/provider/audio_player/audio_player.dart';
import 'package:nrtfm/provider/userdata.dart';
import 'package:nrtfm/screen/spalash/spalash_page.dart';

import 'utils/barrel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(systemNavigationBarColor: Kcolor.black));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<LoginBloc>(create: (_) => LoginBloc()),
            ],
            child: MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (_) => UserDataProvider()),
                ChangeNotifierProvider(create: (_) => MusicPlayer()),
              ],
              child: GetMaterialApp(
                  theme: ThemeData(useMaterial3: true),
                  title: 'Flutter Demo',
                  debugShowCheckedModeBanner: false,
                  home: const SpalashPage()),
            ),
          );
        });
  }
}
