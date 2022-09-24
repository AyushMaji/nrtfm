import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nrtfm/controller/login/login_bloc.dart';
import 'package:nrtfm/screen/home_page/navigation/navigation.dart';
import 'package:nrtfm/screen/spalash/spalash_page.dart';
import 'package:nrtfm/utils/barrel.dart';
import 'package:nrtfm/utils/messsenger.dart';
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
        child: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            state.when(
              initial: () {},
              loading: () {},
              login: (uid, uname) {
                Snackber.successSnackbar('Login Success', 'Welcome $uname');
                Get.off(() => Navigation(
                      id: uid,
                    ));
              },
              logout: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return const SpalashPage();
                  }),
                );
              },
            );
          },
          builder: (context, state) {
            return state.when(
              initial: () {
                return Gbtn(onTap: () {
                  BlocProvider.of<LoginBloc>(context).add(const Login());
                });
              },
              loading: () {
                return const Center(child: CircularProgressIndicator());
              },
              login: (uid, uname) {
                return const SizedBox();
              },
              logout: () {
                return Gbtn(onTap: () {
                  BlocProvider.of<LoginBloc>(context).add(const Login());
                });
              },
            );
          },
        ),
      ),
    ));
  }
}
