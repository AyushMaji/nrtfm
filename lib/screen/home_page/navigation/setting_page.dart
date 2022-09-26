import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nrtfm/constant/color.dart';
import 'package:nrtfm/controller/login/login_bloc.dart';
import 'package:nrtfm/screen/home_page/others/about_page.dart';
import 'package:nrtfm/screen/home_page/others/account_info_page.dart';
import 'package:nrtfm/screen/home_page/others/developer_page.dart';
import 'package:nrtfm/screen/home_page/others/uplode_music.dart';
import 'package:nrtfm/screen/home_page/others/your_collection.dart';
import 'package:nrtfm/utils/barrel.dart';
import 'package:nrtfm/widget/banner/custom_banner.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({
    super.key,
  });

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Kcolor.bgColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 0.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 0.w),
              child: Center(
                child: CustomPic(
                    imageUrl:
                        'https://img.freepik.com/free-vector/music-speaker-with-wave-equalizer-frequency-background_1017-32308.jpg?w=1380&t=st=1663054503~exp=1663055103~hmac=8683ee170f495ea0c86b61e638444b1cddaad74c6d825543cb2be7a19d899307',
                    height: 150.h,
                    width: double.infinity),
              ),
            ),
            SizedBox(height: 5.h),
            ListTile(
              title: Text('Account Info',
                  style: GoogleFonts.poppins(
                    fontSize: 13.5.sp,
                    color: Kcolor.txt2,
                  )),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 15.sp,
                color: Kcolor.txt2,
              ),
              onTap: () {
                Get.to(() => const AccountInfoPage());
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: const Divider(
                color: Kcolor.txt1,
                thickness: 1,
              ),
            ),
            ListTile(
              title: Text('About Us',
                  style: GoogleFonts.poppins(
                    fontSize: 13.5.sp,
                    color: Kcolor.txt2,
                  )),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 15.sp,
                color: Kcolor.txt2,
              ),
              onTap: () {
                Get.to(() => const AboutPage());
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: const Divider(
                color: Kcolor.txt1,
                thickness: 1,
              ),
            ),
            StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection("Users").snapshots(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 30.h),
                        child: const CircularProgressIndicator(),
                      ),
                    );
                  }
                  return snapshot.data!.docs[0]['admin'] == true
                      ? Column(
                          children: [
                            ListTile(
                              title: Text('Uplode audio',
                                  style: GoogleFonts.poppins(
                                    fontSize: 13.5.sp,
                                    color: Kcolor.txt2,
                                  )),
                              trailing: Icon(
                                Icons.arrow_forward_ios,
                                size: 15.sp,
                                color: Kcolor.txt2,
                              ),
                              onTap: () {
                                Get.to(() => const MusicUplode());
                              },
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: const Divider(
                                color: Kcolor.txt1,
                                thickness: 1,
                              ),
                            ),
                            ListTile(
                              title: Text('Your collection',
                                  style: GoogleFonts.poppins(
                                    fontSize: 13.5.sp,
                                    color: Kcolor.txt2,
                                  )),
                              trailing: Icon(
                                Icons.arrow_forward_ios,
                                size: 15.sp,
                                color: Kcolor.txt2,
                              ),
                              onTap: () {
                                Get.to(() => const YourCollection());
                              },
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: const Divider(
                                color: Kcolor.txt1,
                                thickness: 1,
                              ),
                            ),
                          ],
                        )
                      : const SizedBox();
                }),
            ListTile(
              title: Text('Developer info',
                  style: GoogleFonts.poppins(
                    fontSize: 13.5.sp,
                    color: Kcolor.txt2,
                  )),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 15.sp,
                color: Kcolor.txt2,
              ),
              onTap: () {
                Get.to(() => const DeveloperPage());
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: const Divider(
                color: Kcolor.txt1,
                thickness: 1,
              ),
            ),
            ListTile(
              title: Text('log out',
                  style: GoogleFonts.poppins(
                    fontSize: 13.5.sp,
                    color: Kcolor.txt2,
                  )),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 15.sp,
                color: Kcolor.txt2,
              ),
              onTap: () {
                BlocProvider.of<LoginBloc>(context).add(const Logout());
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: const Divider(
                color: Kcolor.txt1,
                thickness: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
