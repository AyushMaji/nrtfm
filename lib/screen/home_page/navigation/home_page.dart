import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lottie/lottie.dart';
import 'package:nrtfm/constant/color.dart';
import 'package:nrtfm/provider/audio_player/audio_player.dart';
import 'package:nrtfm/screen/home_page/others/music_page.dart';
import 'package:nrtfm/utils/barrel.dart';
import 'package:nrtfm/widget/banner/custom_banner.dart';
import 'package:nrtfm/widget/card/cd_card/cd_card.dart';
import 'package:nrtfm/widget/card/list_card/list_card.dart';
import 'package:nrtfm/widget/header/header.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CarouselController _controller = CarouselController();
  final controller = PageController(viewportFraction: 0.8, keepPage: true);
  final int _current = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Kcolor.bgColor,
        floatingActionButton: Provider.of<MusicPlayer>(context, listen: false)
                .isPlaying
            ? FloatingActionButton(
                onPressed: () async {
                  Get.to(() => MusicPage(
                      musicId: Provider.of<MusicPlayer>(context, listen: false)
                          .getmusicId));
                },
                backgroundColor: const Color.fromARGB(121, 255, 0, 0),
                child: Lottie.asset('assets/music.json')
                //  const Icon(Icons.music_note),
                )
            : const SizedBox(),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('music')
                      .orderBy('time', descending: true)
                      .snapshots(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return CarouselSlider.builder(
                        carouselController: _controller,
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, index, realIndex) {
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
                                      snapshot.data.docs[index]['views']
                                          .toString(),
                                      snapshot.data.docs[index]['tittle'],
                                      snapshot.data.docs[index]['description']);

                              Get.to(() => MusicPage(
                                    musicId: snapshot.data.docs[index]
                                        ['musicId'],
                                  ));
                            },
                            child: CustomPic(
                              imageUrl: snapshot.data.docs[index]['songBanner'],
                              height: 150.h,
                              width: double.infinity,
                            ),
                          );
                        },
                        options: CarouselOptions(
                          height: 190.h,
                          autoPlay: true,
                          enlargeCenterPage: true,
                          viewportFraction: 0.8,
                          aspectRatio: 2.0,
                          initialPage: 0,
                        ),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.w),
                child: Header(
                    url: "assets/images/top20.png",
                    icon: Icon(
                      Icons.arrow_forward_ios_sharp,
                      color: Kcolor.primaryColor,
                      size: 15.sp,
                    ),
                    isShow: true),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.w, top: 23.h),
                child: SizedBox(
                  height: 165.h,
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('music')
                          .limit(20)
                          .snapshots(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data.docs.length,
                            itemBuilder: (context, index) {
                              return CdCard(
                                title: snapshot.data.docs[index]['tittle'],
                                image: snapshot.data.docs[index]['songPoster'],
                                onTap: () {
                                  Provider.of<MusicPlayer>(context,
                                          listen: false)
                                      .musicPlayer(
                                          snapshot.data.docs[index]['music'],
                                          snapshot.data.docs[index]['musicId'],
                                          snapshot.data.docs[index]
                                              ['songPoster'],
                                          snapshot.data.docs[index]['rating']
                                              .toString(),
                                          snapshot
                                              .data.docs[index]['totalRating']
                                              .toString(),
                                          snapshot.data.docs[index]['views']
                                              .toString(),
                                          snapshot.data.docs[index]['tittle'],
                                          snapshot.data.docs[index]
                                              ['description']);

                                  Get.to(() => MusicPage(
                                        musicId: snapshot.data.docs[index]
                                            ['musicId'],
                                      ));
                                },
                                views: '300',
                              );
                            });
                      }),
                ),
              ),
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('music')
                      .orderBy('time', descending: true)
                      .snapshots(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, index) {
                          return Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.w, vertical: 2.5.h),
                              child: ListCard(
                                title: snapshot.data.docs[index]['tittle'],
                                name: 'Ayush Maji',
                                image: snapshot.data.docs[index]['songPoster'],
                                onTap: () {
                                  Provider.of<MusicPlayer>(context,
                                          listen: false)
                                      .musicPlayer(
                                          snapshot.data.docs[index]['music'],
                                          snapshot.data.docs[index]['musicId'],
                                          snapshot.data.docs[index]
                                              ['songPoster'],
                                          snapshot.data.docs[index]['rating']
                                              .toString(),
                                          snapshot
                                              .data.docs[index]['totalRating']
                                              .toString(),
                                          snapshot.data.docs[index]['views']
                                              .toString(),
                                          snapshot.data.docs[index]['tittle'],
                                          snapshot.data.docs[index]
                                              ['description']);

                                  Get.to(() => MusicPage(
                                        musicId: snapshot.data.docs[index]
                                            ['musicId'],
                                      ));
                                },
                                description: snapshot.data.docs[index]
                                    ['description'],
                                views: snapshot.data.docs[index]['views']
                                    .toString(),
                                rating: snapshot.data.docs[index]['rating']
                                    .toString(),
                              ));
                        });
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
