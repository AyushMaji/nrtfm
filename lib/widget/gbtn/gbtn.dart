import 'package:nrtfm/constant/color.dart';
import 'package:nrtfm/utils/barrel.dart';

class Gbtn extends StatelessWidget {
  final GestureTapCallback onTap;

  const Gbtn({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 10.h),
          child: SizedBox(
            height: 9.h,
            width: 90.w,
            child: Image.asset(
              "assets/images/logo.png",
              height: 10.h,
              width: 87.w,
            ),
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: 7.h,
            width: 85.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.sp),
              color: Kcolor.primaryColor,
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 4.w, right: 9.w),
                  child: Image.asset(
                    "assets/images/google_logo.png",
                    height: 4.5.h,
                    width: 13.w,
                    fit: BoxFit.cover,
                  ),
                ),
                Text(
                  "Sign in with Google",
                  style: TextStyle(
                    color: Kcolor.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 4.5.h,
        )
      ],
    );
  }
}
