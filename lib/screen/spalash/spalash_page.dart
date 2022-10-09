import 'dart:async';

import 'package:lottie/lottie.dart';
import 'package:nrtfm/provider/userdata.dart';
import 'package:nrtfm/screen/home_page/navigation/navigation.dart';
import 'package:nrtfm/screen/login_page/login_page.dart';
import 'package:nrtfm/utils/barrel.dart';
import 'package:nrtfm/constant/color.dart';

class SpalashPage extends StatefulWidget {
  const SpalashPage({Key? key}) : super(key: key);

  @override
  State<SpalashPage> createState() => _SpalashPageState();
}

class _SpalashPageState extends State<SpalashPage> {
  @override
  void initState() {
    getValidationData().whenComplete(() async {});
    super.initState();
  }

  Future getValidationData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var userId = preferences.getString('ID');
    // ignore: use_build_context_synchronously
    Provider.of<UserDataProvider>(context, listen: false).getUserData();
    Timer(const Duration(milliseconds: 3000), () {
      if (userId == null) {
        Provider.of<UserDataProvider>(context, listen: false).getUserData();
        Get.offAll(() => const LoginPage());
      } else {
        Provider.of<UserDataProvider>(context, listen: false).getUserData();
        Get.offAll(() => Navigation(id: userId));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          // Status bar color
          statusBarColor: Kcolor.bgColor,
          statusBarIconBrightness: Brightness.light, // For Android (dark icons)

          // For iOS (dark icons)
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 50.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'powered by NRT FM',
              style: GoogleFonts.roboto(
                color: const Color.fromARGB(255, 255, 255, 255),
                fontSize: 13.sp,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Kcolor.bgColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 250.h,
              child: Lottie.asset('assets/spalash.json', repeat: false),
            ),
          ],
        ),
      ),
    );
  }
}
