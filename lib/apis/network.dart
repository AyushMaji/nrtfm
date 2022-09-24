import 'package:cloud_firestore/cloud_firestore.dart';

class Network {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<void> loginData(
      String userUid, String userName, String userEmail, String userPic) async {
    return await firebaseFirestore.collection('Users').doc(userUid).set({
      'id': userUid,
      'name': userName,
      'email': userEmail,
      'picture': userPic,
      'admin': false,
      'timeStamp': DateTime.now(),
    });
  }
}
