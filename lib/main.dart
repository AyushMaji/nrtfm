import 'package:nrtfm/constant/color.dart';
import 'package:nrtfm/screen/login_page/login_page.dart';
import 'utils/barrel.dart';

void main() {
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
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return GetMaterialApp(
              theme: ThemeData(
                useMaterial3: true,
              ),
              title: 'NRT FM',
              debugShowCheckedModeBanner: false,
              home: const LoginPage());
        });
  }
}
