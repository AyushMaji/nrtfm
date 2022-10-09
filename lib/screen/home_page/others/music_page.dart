import 'dart:developer';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:like_button/like_button.dart';
import 'package:lottie/lottie.dart';
import 'package:marquee_text/marquee_direction.dart';
import 'package:marquee_text/marquee_text.dart';
import 'package:nrtfm/constant/color.dart';
import 'package:nrtfm/provider/audio_player/audio_player.dart';
import 'package:nrtfm/provider/userdata.dart';
import 'package:nrtfm/utils/barrel.dart';
import 'package:nrtfm/widget/banner/custom_banner.dart';
import 'package:nrtfm/widget/card/list_card/list_card.dart';
import 'package:nrtfm/widget/comment_box/comment_box.dart';
import 'package:nrtfm/widget/play_pause_btn.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:timeago/timeago.dart' as timeago;

class MusicPage extends StatefulWidget {
  final String musicId;

  const MusicPage({
    Key? key,
    required this.musicId,
  }) : super(key: key);

  @override
  State<MusicPage> createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> {
  @override
  Widget build(BuildContext context) {
    bool ispaused = Provider.of<MusicPlayer>(context, listen: true).isPaused;
    String? userId =
        Provider.of<UserDataProvider>(context, listen: true).getUid;
    String isSongState =
        Provider.of<MusicPlayer>(context, listen: true).getprocessState;

    Future<bool> onLikeButtonTapped(bool isLiked) async {
      if (isLiked == true) {
        Provider.of<UserDataProvider>(context, listen: false)
            .addtoCardremove(widget.musicId, userId!);
        log(isLiked.toString());
      }
      if (isLiked == false) {
        Provider.of<UserDataProvider>(context, listen: false)
            .addtoCard(widget.musicId, userId!);
        log(isLiked.toString());
      }
      return !isLiked;
    }

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.h),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: AppBar(
              elevation: 0,
              backgroundColor: Kcolor.transparent,
              leading: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.arrow_back_ios_rounded,
                    color: Kcolor.primaryColor,
                    size: 25.sp,
                  )),
              actions: [
                CircleAvatar(
                  backgroundColor: const Color.fromARGB(0, 255, 255, 255),
                  child: LikeButton(
                    onTap: onLikeButtonTapped,
                    circleColor: const CircleColor(
                        start: Color(0xff00ddff), end: Colors.red),
                    bubblesColor: const BubblesColor(
                      dotPrimaryColor: Colors.white,
                      dotSecondaryColor: Colors.pink,
                    ),
                    likeBuilder: (bool isLiked) {
                      return Icon(
                        Icons.favorite_border,
                        color: const Color.fromARGB(255, 243, 3, 83),
                        size: 25.sp,
                      );
                    },
                  ),
                ),
                IconButton(
                    onPressed: () {
                      Provider.of<MusicPlayer>(context, listen: false)
                          .audiooff();
                      Get.back();
                    },
                    icon: Icon(
                      Icons.close,
                      color: Kcolor.white,
                      size: 25.sp,
                    )),
              ],
            ),
          ),
        ),
        backgroundColor: Kcolor.bgColor,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Center(
              child: Column(children: [
            // ========================================== song related ==================================== //
            Column(
              children: [
                //======poster ========///
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.w),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: CustomPic(
                      imageUrl: Provider.of<MusicPlayer>(context, listen: true)
                          .getposter,
                      width: double.infinity,
                      height: 250.h,
                    ),
                  ),
                ),
                //====== poster ========///
                SizedBox(height: 20.h),
                //====== Tittle ========///
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 25.w),
                  child: SizedBox(
                    width: double.infinity,
                    child: MarqueeText(
                        text: TextSpan(
                          text: Provider.of<MusicPlayer>(context, listen: true)
                              .gettittle,
                        ),
                        speed: 17,
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                          fontSize: 17.sp,
                          color: Kcolor.white,
                        ),
                        alwaysScroll: true,
                        marqueeDirection: MarqueeDirection.rtl),
                  ),
                ),
                //====== Tittle ========///
                SizedBox(height: 20.h),
                //====== Details ========///
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          Provider.of<MusicPlayer>(context, listen: true)
                              .gettotalRating,
                          style: TextStyle(
                            fontSize: 20.sp,
                            color: Kcolor.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 2.h),
                        Text(
                          "Likes",
                          style: TextStyle(
                            fontSize: 20.sp,
                            color: Kcolor.white,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 40.w,
                      ),
                      child: Column(
                        children: [
                          Text(
                            Provider.of<MusicPlayer>(context, listen: true)
                                .getviews,
                            style: TextStyle(
                              fontSize: 20.sp,
                              color: Kcolor.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 2.h),
                          Text(
                            "Views",
                            style: TextStyle(
                              fontSize: 20.sp,
                              color: Kcolor.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          Provider.of<MusicPlayer>(context, listen: true)
                              .getrating,
                          style: TextStyle(
                            fontSize: 20.sp,
                            color: Kcolor.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 2.h),
                        Text(
                          "Rating",
                          style: TextStyle(
                            fontSize: 20.sp,
                            color: Kcolor.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                //====== Details ========///
                SizedBox(height: 40.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: SizedBox(
                    width: double.infinity,
                    child: ProgressBar(
                      progress: Provider.of<MusicPlayer>(context, listen: true)
                          .getposition,
                      buffered: Provider.of<MusicPlayer>(context, listen: true)
                          .getbufferedPosition,
                      total: Provider.of<MusicPlayer>(context, listen: true)
                          .getduration,
                      progressBarColor: Colors.red,
                      baseBarColor: Colors.white.withOpacity(0.24),
                      bufferedBarColor: const Color.fromARGB(255, 151, 180, 252)
                          .withOpacity(0.24),
                      thumbColor: Colors.white,
                      barHeight: 10,
                      thumbRadius: 11.0,
                      timeLabelPadding: 1.h,
                      timeLabelTextStyle: TextStyle(
                        color: Kcolor.white,
                        fontSize: 12.sp,
                      ),
                      onSeek: (duration) {
                        Provider.of<MusicPlayer>(context, listen: false)
                            .changeSideValue(duration);
                      },
                    ),
                  ),
                ),
                //====== controller ========///
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: InkWell(
                        onTap: () {
                          Provider.of<MusicPlayer>(context, listen: false)
                                  .getismute
                              ? Provider.of<MusicPlayer>(context, listen: false)
                                  .changeVolume(1.0)
                              : Provider.of<MusicPlayer>(context, listen: false)
                                  .changeVolume(0);
                        },
                        child: Provider.of<MusicPlayer>(context, listen: true)
                                .getismute
                            ? Icon(
                                Icons.volume_off,
                                color: Kcolor.txt1,
                                size: 25.sp,
                              )
                            : Icon(
                                Icons.volume_up_sharp,
                                color: Kcolor.txt1,
                                size: 25.sp,
                              ),
                      ),
                    ),
                    PlayPauseBtn(
                        ispaused: ispaused,
                        isSongState: isSongState,
                        iconSize: 27.sp,
                        radius: 35.sp,
                        size: 50.sp,
                        endRadius: 50.sp),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: InkWell(
                        onTap: () {
                          Provider.of<MusicPlayer>(context, listen: false)
                                  .getisRepeat
                              ? Provider.of<MusicPlayer>(context, listen: false)
                                  .loopOn()
                              : Provider.of<MusicPlayer>(context, listen: false)
                                  .loopOff();
                        },
                        child: Provider.of<MusicPlayer>(context, listen: false)
                                .getisRepeat
                            ? Icon(
                                Icons.repeat,
                                color: Kcolor.txt1,
                                size: 25.sp,
                              )
                            : Icon(
                                Icons.repeat_one,
                                color: Kcolor.txt1,
                                size: 25.sp,
                              ),
                      ),
                    ),
                  ],
                ),
                //====== controller ========///
                SizedBox(height: 10.h),
                //====== description ========//
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: SizedBox(
                    width: double.infinity,
                    child: Text(
                      "Description",
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: Kcolor.txt2,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: SizedBox(
                    width: double.infinity,
                    child: Text(
                      Provider.of<MusicPlayer>(context, listen: true)
                          .getdescription,
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Kcolor.txt1,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
                //====== description ========//
              ],
            ),
            // ========================================== song related ==================================== //
            SizedBox(height: 50.h),
            // ========================================== recomendation ==================================== //
            Column(
              children: [
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("music")
                        .snapshots(),
                    builder: (context, AsyncSnapshot snapshot) {
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
                            padding: EdgeInsets.symmetric(vertical: 2.h),
                            child: ListCard(
                              title: snapshot.data.docs[index]['tittle'],
                              name: snapshot.data.docs[index]['tittle'],
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
                                        snapshot.data.docs[index]
                                            ['description']);

                                Get.to(() => MusicPage(
                                      musicId: snapshot.data.docs[index]
                                          ['musicId'],
                                    ));
                              },
                              description: snapshot.data.docs[index]
                                  ['description'],
                              views:
                                  snapshot.data.docs[index]['views'].toString(),
                              rating: snapshot.data.docs[index]['rating']
                                  .toString(),
                            ),
                          );
                        },
                      );
                    })
              ],
            ),
            // ========================================== recomendation ==================================== //
            SizedBox(height: 34.h),
            // ========================================== comments ==================================== //
            Column(
              children: [
                /// ==== review box  ====== ///
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: SizedBox(
                    width: double.infinity,
                    child: Text(
                      "Reviews",
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: Kcolor.txt2,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                SizedBox(height: 25.h),
                Container(
                  height: 85.h,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(0),
                    ),
                    color: Color.fromARGB(82, 12, 12, 12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text("Reviews",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: GoogleFonts.koHo(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w700,
                                color: const Color.fromRGBO(0, 197, 126, 1))),
                      ),
                      RatingBarIndicator(
                        rating: double.parse(
                            Provider.of<MusicPlayer>(context, listen: true)
                                .getrating),
                        unratedColor: const Color.fromARGB(155, 255, 255, 255),
                        itemBuilder: (context, index) => const Icon(
                          Icons.star,
                          color: Color.fromARGB(255, 184, 167, 35),
                        ),
                        itemCount: 5,
                        itemSize: 25.0.sp,
                        direction: Axis.horizontal,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                Provider.of<MusicPlayer>(context, listen: true)
                                    .gettotalRating,
                                textScaleFactor: 0.85,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: GoogleFonts.koHo(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: const Color.fromRGBO(0, 197, 126, 1),
                                )),
                            Text("REVIEW",
                                textScaleFactor: 0.85,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: GoogleFonts.koHo(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: const Color.fromRGBO(0, 197, 126, 1),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                /// ==== review box  ====== ///
                SizedBox(height: 20.h),

                /// ==== comment Button  ====== ///
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Kcolor.primaryColor,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.sp),
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: const Color.fromARGB(184, 46, 46, 46),
                            offset: const Offset(0, 4),
                            blurRadius: 25.sp)
                      ],
                      color: const Color.fromARGB(52, 11, 11, 11),
                    ),
                    height: 40.h,
                    width: double.infinity,
                    child: InkWell(
                      onTap: () {
                        final ratingDialog = RatingDialog(
                          starSize: 30.sp,
                          submitButtonText: 'Submit',
                          onCancelled: () => log('cancelled'),
                          onSubmitted: (response) {
                            log('rating: ${response.rating}, '
                                'comment: ${response.comment}');
                            Provider.of<UserDataProvider>(context,
                                    listen: false)
                                .rating(widget.musicId, response.rating,
                                    userId!, response.comment);
                          },
                          title: const Text("Rate this music"),
                        );

                        showDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (context) => ratingDialog,
                        );
                      },
                      child: Center(
                        child: Text(
                          "GIVE YOUR REVIEW",
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: Kcolor.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                /// ==== comment Button  ====== ///
                SizedBox(height: 40.h),

                /// ==== comment box ====== ///
                SizedBox(
                  width: double.infinity,
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('music')
                          .doc(widget.musicId)
                          .collection('Comments')
                          .orderBy('timeStamp', descending: true)
                          .snapshots(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (snapshot.data.docs.length == 0) {
                          return Column(
                            children: [
                              SizedBox(
                                height: 250.h,
                                child: Lottie.asset('assets/review.json'),
                              ),
                            ],
                          );
                        }
                        return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data.docs.length,
                            itemBuilder: (context, index) {
                              return Container(
                                padding: EdgeInsets.symmetric(vertical: 5.w),
                                child: CommentBox(
                                    cmtowner: snapshot.data.docs[index]
                                        ['userID'],
                                    comment: snapshot.data.docs[index]
                                        ['comment'],
                                    userID: userId!,
                                    time:
                                        " ${timeago.format(snapshot.data.docs[index]['timeStamp'].toDate())} ",
                                    userName: snapshot.data.docs[index]
                                        ['Ownername'],
                                    image: snapshot.data.docs[index]['pic'],
                                    deleteTap: () {
                                      Provider.of<UserDataProvider>(context,
                                              listen: false)
                                          .CommentDlt(
                                        widget.musicId,
                                        userId,
                                      );
                                    }),
                              );
                            });
                      }),
                ),

                /// ==== comment box ====== ///
                SizedBox(
                  height: 20.h,
                )
              ],
            ),
            // ========================================== comments ==================================== //
          ])),
        ));
  }
}
