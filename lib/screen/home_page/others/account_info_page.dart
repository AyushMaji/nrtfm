import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nrtfm/constant/color.dart';
import 'package:nrtfm/controller/login/login_bloc.dart';
import 'package:nrtfm/provider/userdata.dart';
import 'package:nrtfm/utils/barrel.dart';

class AccountInfoPage extends StatefulWidget {
  const AccountInfoPage({
    super.key,
  });
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
                icon:
                    const Icon(Icons.search, color: Color.fromRGBO(0, 0, 0, 1)),
                onPressed: () {},
              ),
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 19.h),
          child: SizedBox(
            height: 40.h,
            child: ElevatedButton(
              onPressed: () {
                BlocProvider.of<LoginBloc>(context).add(const Logout());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffE20A13),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.sp),
                ),
                padding: EdgeInsets.symmetric(vertical: 1.5.h),
              ),
              child: Text(
                "LOG OUT",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13.5.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("Users")
                    .where("id",
                        isEqualTo:
                            Provider.of<UserDataProvider>(context, listen: true)
                                .getUid)
                    .snapshots(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 30.h),
                        child: const CircularProgressIndicator(),
                      ),
                    );
                  }
                  return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: Stack(
                            children: [
                              CircleAvatar(
                                radius: 55.sp,
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            snapshot.data.docs[0]['picture']),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: CircleAvatar(
                                  radius: 15.sp,
                                  backgroundColor:
                                      const Color.fromRGBO(255, 214, 214, 1),
                                  child: Icon(
                                    Icons.camera_alt,
                                    color: const Color(0xffE20A13),
                                    size: 17.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 15.h),
                        Text(
                          'Your Photo',
                          style: GoogleFonts.poppins(
                            color: const Color(0xffE20A13),
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 13.w),
                            child: Column(
                              children: [
                                TextField(
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    hintText: snapshot.data.docs[0]['name'],
                                    hintStyle: GoogleFonts.poppins(
                                      color:
                                          const Color.fromRGBO(97, 97, 97, 1),
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    prefixIcon: Icon(
                                      Icons.person,
                                      color: const Color(0xffE20A13),
                                      size: 22.sp,
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
                                SizedBox(height: 14.h),
                                TextField(
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    hintText: snapshot.data.docs[0]['email'],
                                    hintStyle: GoogleFonts.poppins(
                                      color:
                                          const Color.fromRGBO(97, 97, 97, 1),
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    prefixIcon: Icon(
                                      Icons.email_outlined,
                                      color: const Color(0xffE20A13),
                                      size: 22.sp,
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
                            ))
                      ]);
                })));
  }
}
