import 'package:auto_size_text/auto_size_text.dart';
import 'package:nrtfm/constant/color.dart';
import 'package:nrtfm/utils/barrel.dart';

class ListCard extends StatelessWidget {
  final String title;
  final String name;
  final String description;
  final String image;
  final String views;
  final String rating;
  final GestureTapCallback? onTap;

  const ListCard({
    Key? key,
    required this.title,
    required this.name,
    required this.image,
    required this.onTap,
    required this.description,
    required this.views,
    required this.rating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: InkWell(
        onTap: onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6.h),
              child: SizedBox(
                width: 90.w,
                height: 85.h,
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
                          width: 90.w,
                          height: 85.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: const Color.fromRGBO(4, 4, 4, 0.38),
                          ),
                        ),
                      ),
                    );
                  },
                  errorWidget: (context, url, error) => Icon(
                    Icons.error,
                    size: 12.sp,
                  ),
                ),
              ),
            ),
            SizedBox(width: 7.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 180.w,
                            child: AutoSizeText(
                              title,
                              style: GoogleFonts.hind(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Kcolor.white),
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.play_arrow_sharp,
                                color: Kcolor.txt1,
                                size: 8.2.sp,
                              ),
                              SizedBox(
                                width: 0.5.w,
                              ),
                              SizedBox(
                                width: 57.w,
                                child: Text(
                                  "$views views",
                                  style: TextStyle(
                                      fontSize: 8.5.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Kcolor.txt1),
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        width: 35.w,
                        height: 18.h,
                        decoration: BoxDecoration(
                          color: Kcolor.review,
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: Center(
                          child: Text(rating,
                              style: TextStyle(
                                  fontSize: 8.sp,
                                  fontWeight: FontWeight.w800,
                                  color: Kcolor.white)),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 7.h,
                  ),
                  SizedBox(
                    height: 65.h,
                    child: Text(
                      description,
                      style: GoogleFonts.raleway(
                        fontSize: 9.sp,
                        color: Kcolor.txt2,
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.w600,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      maxLines: 5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
