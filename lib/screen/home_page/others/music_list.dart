import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nrtfm/constant/color.dart';
import 'package:nrtfm/provider/audio_player/audio_player.dart';
import 'package:nrtfm/screen/home_page/others/music_page.dart';
import 'package:nrtfm/utils/barrel.dart';
import 'package:nrtfm/widget/card/list_card/list_card.dart';

class MusicList extends StatefulWidget {
  final String catagory;
  const MusicList({Key? key, required this.catagory}) : super(key: key);

  @override
  State<MusicList> createState() => _MusicListState();
}

class _MusicListState extends State<MusicList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 1,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_rounded,
              color: Kcolor.primaryColor,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(widget.catagory.toUpperCase(),
              style: const TextStyle(
                color: Kcolor.txt1,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              )),
          backgroundColor: Kcolor.bgColor,
        ),
        backgroundColor: Kcolor.bgColor,
        body: Padding(
          padding: EdgeInsets.only(top: 20.0.h),
          child: Center(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('music')
                    .where('catagory', isEqualTo: widget.catagory)
                    .snapshots(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.data.docs.length == 0) {
                    return const Text("No Data",
                        style: TextStyle(
                          color: Kcolor.white,
                        ));
                  }
                  return ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.h),
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
                      );
                    },
                  );
                }),
          ),
        ));
  }
}
