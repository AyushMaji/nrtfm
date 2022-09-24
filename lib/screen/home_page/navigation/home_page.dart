import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
                backgroundColor: Kcolor.primaryColor,
                child: const Icon(Icons.music_note),
              )
            : const SizedBox(),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 13.w),
                child: StreamBuilder(
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
                            return CustomPic(
                              imageUrl: snapshot.data.docs[index]['songBanner'],
                              height: 160.h,
                              width: double.infinity,
                            );
                          },
                          options: CarouselOptions(
                            height: 200.h,
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
                      // return CustomPic(
                      //     imageUrl: snapshot.data.docs[0].data()['songBanner'],
                      //     height: 160.h,
                      //     width: double.infinity);
                    }),
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                padding: EdgeInsets.only(left: 15.w, top: 20.h),
                child: SizedBox(
                  height: 160.h,
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('music')
                          // .orderBy('views', descending: true)
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
                                  // Provider.of<MusicPlayer>(context,
                                  //         listen: false)
                                  //     .musicPlayer(
                                  //   "https://previews.customer.envatousercontent.com/files/332744075/preview.mp3",
                                  //   "musicId",
                                  //   'https://picsum.photos/200/300?image=${index + 1}',
                                  //   '34',
                                  //   '4.5',
                                  //   '$index',
                                  //   'Title $index',
                                  //   'loream ipsum  loream ipsum  vloream  loream ipsum  loream ipsum  vloream ipsum loream ipsum shc as chas sc ahs ipsum loream ipsum shc as chas sc ahs loream ipsum  loream ipsum  vloream ipsum loream ipsum shc as chas sc ahs',
                                  // );
                                  // Get.to(() => const MusicPage(
                                  //       musicId: 'wevfwEVWV',
                                  //     ));
                                },
                                views: '300',
                              );
                            });
                      }),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 13.w),
                child: Header(
                    url: "assets/images/bookmark.png",
                    icon: Icon(
                      Icons.arrow_forward_ios_sharp,
                      color: Kcolor.primaryColor,
                      size: 15.sp,
                    ),
                    isShow: true),
              ),
              SizedBox(height: 20.h),
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('music')
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
                          return ListCard(
                              title: snapshot.data.docs[index]['tittle'],
                              name: 'Ayush Maji',
                              image: snapshot.data.docs[index]['songPoster'],
                              onTap: () {},
                              description: snapshot.data.docs[index]
                                  ['description'],
                              views: '300',
                              rating: '4.5');
                        });
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
