import 'package:nrtfm/constant/color.dart';
import 'package:nrtfm/utils/barrel.dart';

class AccountInfoPage extends StatefulWidget {
  const AccountInfoPage({super.key});

  @override
  State<AccountInfoPage> createState() => _AccountInfoPageState();
}

class _AccountInfoPageState extends State<AccountInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Kcolor.bgColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Kcolor.bgColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios,
              color: Color.fromARGB(255, 111, 110, 110)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Center(
          child: Text(
            'Account Info',
            style: GoogleFonts.poppins(
              color: const Color.fromRGBO(97, 97, 97, 1),
              fontSize: 12.sp,
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
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.9.h),
        child: SizedBox(
          height: 6.h,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              // ignore: deprecated_member_use
              primary: const Color(0xffE20A13),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.sp),
              ),
              padding: EdgeInsets.symmetric(vertical: 1.5.h),
            ),
            child: const Text(
              "LOG OUT",
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 50.sp,
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage(
                                'https://img.freepik.com/free-photo/close-up-young-successful-man-smiling-camera-standing-casual-outfit-against-blue-background_1258-66609.jpg?w=2000'),
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 13.sp,
                      backgroundColor: const Color.fromRGBO(255, 214, 214, 1),
                      child: Icon(
                        Icons.camera_alt,
                        color: const Color(0xffE20A13),
                        size: 15.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              'Your Photo',
              style: GoogleFonts.poppins(
                color: const Color(0xffE20A13),
                fontSize: 11.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 2.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.9.w),
              child: Column(
                children: [
                  TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                      hintText: 'Surajit Dutta',
                      hintStyle: GoogleFonts.poppins(
                        color: const Color.fromRGBO(97, 97, 97, 1),
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      prefixIcon: Icon(
                        Icons.person,
                        color: const Color(0xffE20A13),
                        size: 15.sp,
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xffCFCFCF),
                        ),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xffCFCFCF),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                      hintText: 'ayush.maji2001@gmail.com',
                      hintStyle: GoogleFonts.poppins(
                        color: const Color.fromRGBO(97, 97, 97, 1),
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: const Color(0xffE20A13),
                        size: 15.sp,
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xffCFCFCF),
                        ),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xffCFCFCF),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 2.h),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
