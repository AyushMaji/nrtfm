import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nrtfm/constant/color.dart';
import 'package:nrtfm/provider/audio_player/audio_player.dart';
import 'package:nrtfm/provider/userdata.dart';
import 'package:nrtfm/screen/home_page/others/music_page.dart';
import 'package:nrtfm/utils/barrel.dart';
import 'package:nrtfm/widget/card/list_card/list_card.dart';

class YourCollection extends StatefulWidget {
  const YourCollection({super.key});

  @override
  State<YourCollection> createState() => _YourCollectionState();
}

class _YourCollectionState extends State<YourCollection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Kcolor.bgColor,
      appBar: AppBar(
        backgroundColor: Kcolor.primaryColor,
        title: const Text('Your Collection'),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 20.0.h),
        child: Center(
          child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('music').snapshots(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 2.h),
                      child: GestureDetector(
                        onLongPress: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Delete'),
                                content: const Text(
                                    'Are you sure to delete this song'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Provider.of<UserDataProvider>(context,
                                              listen: false)
                                          .deleteSong(
                                        snapshot.data.docs[index].id,
                                        snapshot.data.docs[index]['songPoster'],
                                        snapshot.data.docs[index]['songBanner'],
                                        snapshot.data.docs[index]['music'],
                                      );

                                      Navigator.pop(context);
                                    },
                                    child: const Text('Delete'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: ListCard(
                          title: snapshot.data.docs[index]['tittle'],
                          name: snapshot.data.docs[index]['ownername'],
                          image: snapshot.data.docs[index]['songPoster'],
                          onTap: () {
                            Provider.of<MusicPlayer>(context, listen: false)
                                .musicPlayer(
                                    snapshot.data.docs[index]['music'],
                                    snapshot.data.docs[index]['musicId'],
                                    snapshot.data.docs[index]['songPoster'],
                                    snapshot.data.docs[index]['rating']
                                        .toString(),
                                    snapshot.data.docs[index]['totalRating']
                                        .toString(),
                                    snapshot.data.docs[index]['views']
                                        .toString(),
                                    snapshot.data.docs[index]['tittle'],
                                    snapshot.data.docs[index]['description']);

                            Get.to(() => MusicPage(
                                  musicId: snapshot.data.docs[index]['musicId'],
                                ));
                          },
                          description: snapshot.data.docs[index]['description'],
                          views: snapshot.data.docs[index]['views'].toString(),
                          rating:
                              snapshot.data.docs[index]['rating'].toString(),
                        ),
                      ),
                    );
                  },
                );
              }),
        ),
      ),
    );
  }
}
