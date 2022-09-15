import 'package:nrtfm/constant/color.dart';
import 'package:nrtfm/utils/barrel.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Kcolor.bgColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Kcolor.bgColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios,
              color: Color.fromARGB(255, 130, 128, 128)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Center(
          child: Text(
            'About',
            style: GoogleFonts.poppins(
              color: Kcolor.txt2,
              fontSize: 17.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        actions: [
          Opacity(
            opacity: 0,
            child: IconButton(
              icon: const Icon(Icons.search, color: Color.fromRGBO(0, 0, 0, 1)),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 2.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 17.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'About Us',
                    style: GoogleFonts.poppins(
                      color: const Color.fromARGB(255, 135, 134, 134),
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    'Eat Incredible is a food delivery app that allows you to order food from your  Eat Incredible is a food delivery app that  passionate about food and technology. We are committed to providing you with the best food delivery experience.  favorite restaurants and have it delivered to your doorstep. We are a team of young and vibrant individuals who are passionate about food and technology. We are committed to providing you with the best food delivery experience. Eat Incredible is a food delivery app that allows you to order food from your favorite restaurants and have it delivered to your doorstep. We are a team of young and vibrant individuals who are passionate about food and technology. We are committed to providing you with the best food delivery experience.',
                    style: GoogleFonts.poppins(
                      color: const Color.fromARGB(255, 113, 112, 112),
                      fontSize: 11.5.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 15.h),
                  Text(
                    'Contact Us',
                    style: GoogleFonts.poppins(
                      color: const Color.fromARGB(255, 135, 134, 134),
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 1.5.h),
                  TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.email_outlined,
                        color: Kcolor.primaryColor),
                    label: Text(
                      'nothing12@gmai.com',
                      style: GoogleFonts.poppins(
                        color: const Color.fromARGB(255, 113, 112, 112),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.phone, color: Kcolor.primaryColor),
                    label: Text(
                      '+91 1234567890',
                      style: GoogleFonts.poppins(
                        color: const Color.fromARGB(255, 113, 112, 112),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
