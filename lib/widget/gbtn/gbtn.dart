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
          padding: EdgeInsets.only(bottom: 20.h),
          child: Text(
            'NRT FM',
            style: GoogleFonts.averiaLibre(
              color: const Color.fromARGB(255, 255, 255, 255),
              fontSize: 53.sp,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 23.w, vertical: 30.h),
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              height: 50.h,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.sp),
                color: Kcolor.primaryColor,
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 15.w, right: 19.w),
                    child: Image.asset(
                      "assets/images/google_logo.png",
                      height: 32.h,
                      width: 54.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Text(
                    "Sign in with Google",
                    style: TextStyle(
                      color: Kcolor.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
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
