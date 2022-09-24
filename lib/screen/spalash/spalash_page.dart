import 'dart:async';

import 'package:nrtfm/provider/userdata.dart';
import 'package:nrtfm/screen/home_page/navigation/navigation.dart';
import 'package:nrtfm/screen/login_page/login_page.dart';
import 'package:nrtfm/utils/barrel.dart';

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
    Timer(const Duration(milliseconds: 1000), () {
      if (userId == null) {
        Provider.of<UserDataProvider>(context, listen: false).getUserData();
        Get.offAll(() => const LoginPage());
      } else {
        Get.offAll(() => Navigation(id: userId));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
}
