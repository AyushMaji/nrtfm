import 'package:nrtfm/screen/home_page/navigation/navigation.dart';
import 'package:nrtfm/utils/barrel.dart';
import 'package:nrtfm/widget/gbtn/gbtn.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/login_bg.png'),
          fit: BoxFit.cover,
        ),
      ),
      height: double.infinity,
      width: double.infinity,
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Color.fromARGB(243, 0, 0, 0),
                Color.fromARGB(237, 0, 0, 0),
                Color.fromARGB(209, 0, 0, 0),
                Color.fromARGB(206, 7, 7, 7),
                Color.fromARGB(51, 0, 0, 0)
              ]),
        ),
        child: Gbtn(onTap: () {
          Get.to(() => const Navigation());
        }),
      ),
    ));
  }
}
