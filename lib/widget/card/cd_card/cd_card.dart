import 'package:nrtfm/constant/color.dart';
import 'package:nrtfm/utils/barrel.dart';

class CdCard extends StatelessWidget {
  final String title;
  final String views;
  final String image;
  final GestureTapCallback? onTap;
  const CdCard({
    Key? key,
    required this.title,
    required this.views,
    required this.image,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Kcolor.transparent,
      highlightColor: Kcolor.transparent,
      onTap: onTap,
      child: SizedBox(
        width: 170.w,
        height: 180.h,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: 14.h,
                  right: -40.w,
                  child: RotatedBox(
                    quarterTurns: 3,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        CircleAvatar(
                          radius: 45.sp,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(45),
                            child: CachedNetworkImage(
                              imageUrl: image,
                              height: 150.h,
                              width: 150.w,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Center(
                                child: Shimmer.fromColors(
                                  baseColor:
                                      const Color.fromRGBO(225, 225, 225, 1),
                                  highlightColor: Colors.white,
                                  child: const CircleAvatar(
                                    backgroundColor: Colors.grey,
                                    radius: 45,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned.fill(
                          child: Align(
                            alignment: Alignment.center,
                            child: CircleAvatar(
                              radius: 45.sp,
                              backgroundColor:
                                  const Color.fromARGB(108, 52, 52, 52),
                              child: const CircleAvatar(
                                  radius: 24,
                                  backgroundColor: Color.fromARGB(177, 0, 0, 1),
                                  child: CircleAvatar(
                                    radius: 16,
                                    backgroundColor: Kcolor.bgColor,
                                  )),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    width: 115.w,
                    height: 107.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: image,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      placeholder: (context, url) {
                        return Center(
                          child: Shimmer.fromColors(
                            baseColor: const Color.fromARGB(255, 32, 32, 32),
                            highlightColor: Colors.white,
                            child: Container(
                              width: 115.w,
                              height: 107.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: const Color.fromRGBO(4, 4, 4, 0.38),
                              ),
                            ),
                          ),
                        );
                      },
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 6.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 110.w,
                      child: Text(
                        title,
                        style: TextStyle(
                            overflow: TextOverflow.clip,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w400,
                            color: Kcolor.txt2),
                        maxLines: 1,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Row(
                      children: [
                        Icon(
                          Icons.play_arrow_rounded,
                          size: 9.sp,
                          color: Kcolor.txt1,
                        ),
                        SizedBox(
                          width: 90.w,
                          child: Text(
                            " $views views",
                            style: TextStyle(
                                overflow: TextOverflow.fade,
                                fontSize: 9.sp,
                                fontWeight: FontWeight.w400,
                                color: Kcolor.txt1),
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
