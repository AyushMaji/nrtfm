import 'package:nrtfm/constant/color.dart';
import 'package:nrtfm/utils/barrel.dart';
import 'package:nrtfm/widget/banner/custom_banner.dart';

class BookMarkCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String views;
  final String catagory;

  const BookMarkCard(
      {super.key,
      required this.imageUrl,
      required this.title,
      required this.views,
      required this.catagory});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.only(
          left: 10.w,
          right: 10.w,
          top: 10.h,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.sp),
                  child:
                      CustomPic(imageUrl: imageUrl, height: 50.h, width: 65.w),
                ),
                SizedBox(width: 10.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 198.w,
                      child: Text(
                        title,
                        style: TextStyle(
                          color: Kcolor.txt2,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      views,
                      style: TextStyle(
                        color: Kcolor.txt1,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Icon(
              Icons.favorite,
              color: Colors.green,
              size: 20.sp,
            )
          ],
        ),
      ),
    );
  }
}
