// ignore_for_file: unnecessary_null_comparison

import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:nrtfm/utils/barrel.dart';
import 'package:nrtfm/utils/messsenger.dart';

class UserDataProvider extends ChangeNotifier {
  String? uid;
  String? get getUid => uid;
  String? name;
  String? get getName => name;
  bool isUplode = false;
  bool get getIsuplode => isUplode;
  String? userPic;
  String? get getUserPic => userPic;
  Future getUserData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    uid = preferences.getString('ID');
    name = preferences.getString('NAME');
    userPic = preferences.getString('PHOTO');

    notifyListeners();
  }

  //! ============= Uplode Song  Function ======================= >

  Future uplodeSong(
      File songPoster,
      File songBanner,
      String tittle,
      String description,
      PlatformFile musicFile,
      String catagory,
      String ownerId,
      String ownerName) async {
    if (songPoster != null &&
        songBanner != null &&
        musicFile != null &&
        description != null &&
        tittle != null) {
      isUplode = true;
      notifyListeners();
      try {
        String songPosterUrl = await FirebaseStorage.instance
            .ref('songPoster/${DateTime.now()}.jpg')
            .putFile(songPoster)
            .then((value) => value.ref.getDownloadURL());
        String songBannerUrl = await FirebaseStorage.instance
            .ref('songBanner/${DateTime.now()}.jpg')
            .putFile(songBanner)
            .then((value) => value.ref.getDownloadURL());
        String musicUrl = await FirebaseStorage.instance
            .ref('music/${DateTime.now()}.mp3')
            .putFile(File(musicFile.path!))
            .then((value) => value.ref.getDownloadURL());
        String docId = tittle + DateTime.now().toString();
        FirebaseFirestore.instance.collection('music').doc(docId).set({
          'songPoster': songPosterUrl,
          'songBanner': songBannerUrl,
          'tittle': tittle,
          'description': description,
          'music': musicUrl,
          'ownerid': getUid,
          'ownername': ownerName,
          'catagory': catagory,
          'views': 0,
          'rating': 0,
          'totalRating': 0,
          'musicId': docId,
          'time': DateTime.now(),
        }).whenComplete(() {
          isUplode = false;
          notifyListeners();
          Snackber.successSnackbar('Uplode successefully', 'Done');
          notifyListeners();
        });
        notifyListeners();
      } catch (e) {
        Snackber.errorSnackbar('Uplode failed', 'Try again');
      }
    } else {
      Snackber.errorSnackbar('Please fill all the fileds', 'Try again');
    }
    notifyListeners();
  }

  //! ============= Uplode Song  Function ======================= >

  //!  ==========  delete song function and dlt songbanner and songposter ==== >
  Future deleteSong(String songId, String songPoster, String songBanner,
      String songUrl) async {
    try {
      await FirebaseStorage.instance.refFromURL(songPoster).delete();
      await FirebaseStorage.instance.refFromURL(songBanner).delete();
      await FirebaseStorage.instance.refFromURL(songUrl).delete();

      await FirebaseFirestore.instance.collection('music').doc(songId).delete();
      Snackber.successSnackbar('Song deleted', 'Done');
    } catch (e) {
      Snackber.errorSnackbar('Song not deleted', 'Try again');
    }
  }
  //!  ==========  delete song function and dlt songbanner and songposter ==== >

  //!  ============ review and comment song =================== >
  Future rating(
    String musicId,
    num rating,
    String userID,
    String comment,
  ) async {
    final firebaseFirestore = FirebaseFirestore.instance;
    firebaseFirestore
        .collection("Users")
        .where('id', isEqualTo: userID)
        .get()
        .then((value) => {
              value.docs.forEach((result) {
                firebaseFirestore
                    .collection("music")
                    .doc(musicId)
                    .collection('Comments')
                    .doc(userID)
                    .set({
                  'musicId': musicId,
                  'rating': rating,
                  'userID': userID,
                  'comment': comment,
                  'pic': result.data()['picture'],
                  'Ownername': result.data()['name'],
                  'timeStamp': DateTime.now(),
                }).whenComplete(() => {
                          firebaseFirestore
                              .collection("music")
                              .doc(musicId)
                              .collection('Comments')
                              .get()
                              .then((value) {
                            for (var result in value.docs) {
                              num totalratingNumber = value.docs.length;
                              num totalPoint = 0;
                              num ratting = 0;

                              for (var i = 0; i < totalratingNumber; i++) {
                                totalPoint =
                                    totalPoint + value.docs[i]['rating'];
                                ratting = totalPoint / totalratingNumber;
                              }

                              firebaseFirestore
                                  .collection("music")
                                  .doc(musicId)
                                  .update({
                                'rating': ratting.toStringAsFixed(1),
                                'totalRating': value.docs.length,
                              });
                            }
                          })
                        });
                log("all data saved");
                Snackber.successSnackbar('Rating done', 'Done');
                notifyListeners();
              })
            });

    notifyListeners();
  }

  Future totalRating(musicId) async {
    final firebaseFirestore = FirebaseFirestore.instance;
    firebaseFirestore
        .collection("music")
        .doc(musicId)
        .collection('Comments')
        .get()
        .then((value) {
      for (var result in value.docs) {
        num totalratingNumber = value.docs.length;
        num totalPoint = 0;
        num ratting = 0;

        for (var i = 0; i < totalratingNumber; i++) {
          totalPoint = totalPoint + value.docs[i]['rating'];
          ratting = totalPoint / totalratingNumber;
        }

        firebaseFirestore.collection("music").doc(musicId).update({
          'rating': ratting.toStringAsFixed(1),
        });
      }
    });

    notifyListeners();
  }

  //!  ============ review and comment song =================== >

  Future CommentDlt(musicId, userId) async {
    final firebaseFirestore = FirebaseFirestore.instance;
    firebaseFirestore
        .collection("music")
        .doc(musicId)
        .collection('Comments')
        .doc(userId)
        .delete()
        .whenComplete(() {
      final firebaseFirestore = FirebaseFirestore.instance;
      firebaseFirestore
          .collection("music")
          .doc(musicId)
          .collection('Comments')
          .get()
          .then((value) {
        for (var result in value.docs) {
          num totalratingNumber = value.docs.length;
          num totalPoint = 0;
          num ratting = 0;

          for (var i = 0; i < totalratingNumber; i++) {
            totalPoint = totalPoint + value.docs[i]['rating'];
            ratting = totalPoint / totalratingNumber;
          }

          firebaseFirestore.collection("Shops").doc(musicId).update({
            'rating': ratting.toStringAsFixed(1),
            'totalRating': value.docs.length,
          });
        }
      });
      Snackber.successSnackbar('Comment deleted', 'Done');
      notifyListeners();
      print("dlt your comment");
    });
  }

  Future addtoCard(String musicId, String userID) async {
    final firebaseFirestore = FirebaseFirestore.instance;
    String addtocardid = musicId + userID;
    firebaseFirestore
        .collection("music")
        .where('musicId', isEqualTo: musicId)
        .get()
        .then((value) {
      for (var result in value.docs) {
        firebaseFirestore.collection("AddToCard").doc(addtocardid).set({
          'musicId': musicId,
          'music': result.data()['music'],
          'description': result.data()['description'],
          'songPoster': result.data()['songPoster'],
          'tittle': result.data()['tittle'],
          'catagory': result.data()['catagory'],
          'totalRating': result.data()['totalRating'],
          'userID': userID,
          'rating': result.data()['rating'],
          'price': result.data()['price'],
          'views': result.data()['views'],
          'timeStamp': DateTime.now(),
        });
        Snackber.successSnackbar('Added to your Playlist', 'Done');

        log("all data saved");
        notifyListeners();
      }
    });
  }

  Future addtoCardremove(String musicId, String userID) async {
    final firebaseFirestore = FirebaseFirestore.instance;
    String addtocardid = musicId + userID;
    firebaseFirestore.collection("AddToCard").doc(addtocardid).delete();
    Snackber.successSnackbar('Removed from your Playlist', 'Done');
    log("all data remove to card ");
    notifyListeners();
  }
}
