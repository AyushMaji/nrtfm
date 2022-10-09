import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nrtfm/apis/network.dart';
import 'package:nrtfm/screen/spalash/spalash_page.dart';
import 'package:nrtfm/utils/barrel.dart';

part 'login_bloc.freezed.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  LoginBloc() : super(const _Initial()) {
    on<Login>((event, emit) async {
      emit(const _Loading());
      SharedPreferences preferences = await SharedPreferences.getInstance();
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken);
      final UserCredential userCredential =
          await firebaseAuth.signInWithCredential(authCredential);
      final User? user = userCredential.user;
      preferences.setString('ID', user!.uid);
      preferences.setString('EMAIL', user.email!);
      preferences.setString('PHOTO', user.photoURL!);
      preferences.setString('NAME', user.displayName!);
      final doc =
          await firebaseFirestore.collection('Users').doc(user.uid).get();
      if (doc.exists) {
        emit(_Login(user.uid, user.displayName!));
      } else {
        Network().loginData(
            user.uid, user.displayName!, user.email!, user.photoURL!);
        emit(_Login(user.uid, user.displayName!));
      }
    });

    on<Logout>((event, emit) async {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      googleSignIn.signOut();
      SharedPreferences.getInstance().then((value) {
        value.clear();

        Get.offAll(const SpalashPage());
      });
      emit(const _Logout());
    });
  }
}
