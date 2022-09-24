import 'package:nrtfm/constant/color.dart';
import 'package:nrtfm/utils/barrel.dart';

class CommentBox extends StatelessWidget {
  final String userName;
  final String userID;
  final String image;
  final String cmtowner;
  final String comment;
  final String time;
  final GestureTapCallback? deleteTap;

  const CommentBox(
      {Key? key,
      required this.cmtowner,
      required this.comment,
      required this.userID,
      required this.time,
      required this.userName,
      required this.image,
      required this.deleteTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 2.0.w),
      child: Column(children: [
        Center(
          child: comment.isNotEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: CachedNetworkImage(
                            imageUrl: image,
                            height: 30.h,
                            width: 30.h,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Center(
                              child: Shimmer.fromColors(
                                baseColor:
                                    const Color.fromARGB(255, 32, 32, 32),
                                highlightColor: Colors.white,
                                child: CircleAvatar(
                                  backgroundColor:
                                      const Color.fromRGBO(4, 4, 4, 0.38),
                                  radius: 5.h,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Row(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20.0),
                                  topLeft: Radius.circular(20.0),
                                  bottomRight: Radius.circular(20.0),
                                ),
                                color: Color.fromRGBO(232, 233, 243, 0.11),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 290.w,
                                    child: Padding(
                                      padding: EdgeInsets.all(10.h),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    userName,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: GoogleFonts.hind(
                                                      fontSize: 11.sp,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Kcolor.white,
                                                    ),
                                                  ),
                                                  SizedBox(width: 8.w),
                                                  Text(
                                                    time,
                                                    style: GoogleFonts.koHo(
                                                      fontSize: 9.sp,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Kcolor.txt1,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              userID == cmtowner
                                                  ? InkWell(
                                                      splashColor:
                                                          Kcolor.transparent,
                                                      onTap: deleteTap,
                                                      child: Icon(
                                                        Icons.delete,
                                                        size: 17.sp,
                                                        color:
                                                            Kcolor.primaryColor,
                                                      ))
                                                  : const Text(''),
                                            ],
                                          ),
                                          SizedBox(height: 0.8.h),
                                          Text(
                                            comment,
                                            style: GoogleFonts.hind(
                                              fontSize: 11.2.sp,
                                              fontWeight: FontWeight.w500,
                                              color: Kcolor.txt1,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                )
              : SizedBox(height: 0.h),
        )
      ]),
    );
  }
}
