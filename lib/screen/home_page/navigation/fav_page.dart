import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lottie/lottie.dart';
import 'package:nrtfm/constant/color.dart';
import 'package:nrtfm/provider/audio_player/audio_player.dart';
import 'package:nrtfm/provider/userdata.dart';
import 'package:nrtfm/screen/home_page/others/music_page.dart';
import 'package:nrtfm/utils/barrel.dart';
import 'package:nrtfm/widget/bookmark_card/bookmark_card.dart';

class FavPage extends StatelessWidget {
  const FavPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Kcolor.bgColor,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              elevation: 0,
              leading: Visibility(
                visible: false,
                child: IconButton(
                  icon: const Icon(
                    Icons.music_note,
                    color: Color.fromARGB(199, 241, 8, 8),
                  ),
                  onPressed: () {},
                ),
              ),
              backgroundColor: Kcolor.bgColor,
              expandedHeight: 250.h,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  "Favourites",
                  style: GoogleFonts.hind(
                    color: Kcolor.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                background: Image.asset(
                  'assets/images/fabposter.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ];
        },
        body: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('AddToCard')
                    .where('userID',
                        isEqualTo:
                            Provider.of<UserDataProvider>(context, listen: true)
                                .getUid)
                    .snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 15.h),
                        child: SizedBox(
                          height: 100.h,
                          child: Lottie.asset('assets/loading.json'),
                        ),
                      ),
                    );
                  }
                  if (snapshot.data.docs.length == 0) {
                    return Padding(
                      padding: EdgeInsets.only(top: 15.h),
                      child: SizedBox(
                        height: 230.h,
                        child: Lottie.asset('assets/fav.json'),
                      ),
                    );
                  }
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data.docs.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return GestureDetector(
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
                                  snapshot.data.docs[index]['views'].toString(),
                                  snapshot.data.docs[index]['tittle'],
                                  snapshot.data.docs[index]['description']);

                          Get.to(() => MusicPage(
                                musicId: snapshot.data.docs[index]['musicId'],
                              ));
                        },
                        onLongPress: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Delete'),
                                  content: const Text(
                                      'Are you sure you want to delete this item?'),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Provider.of<UserDataProvider>(context,
                                                  listen: false)
                                              .addtoCardremove(
                                                  snapshot.data.docs[index]
                                                      ['musicId'],
                                                  snapshot.data.docs[index]
                                                      ['userID']);
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Yes')),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('No')),
                                  ],
                                );
                              });
                        },
                        child: Container(
                          padding: EdgeInsets.only(bottom: 1.5.h),
                          child: BookMarkCard(
                            imageUrl: snapshot.data.docs[index]['songPoster'],
                            title: snapshot.data.docs[index]['tittle'],
                            views:
                                '${snapshot.data.docs[index]['totalRating']} Likes | ${snapshot.data.docs[index]['catagory']}',
                            catagory: snapshot.data.docs[index]['catagory'],
                          ),
                        ),
                      );
                    },
                  );
                }),
          ],
        )),
      ),
    );
  }
}
