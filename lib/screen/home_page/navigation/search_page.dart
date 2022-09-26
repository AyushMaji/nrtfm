import 'package:nrtfm/constant/color.dart';
import 'package:nrtfm/screen/home_page/others/music_list.dart';
import 'package:nrtfm/utils/barrel.dart';
import 'package:nrtfm/widget/search_card/search_card.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Kcolor.bgColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 20.w),
            //   child: GestureDetector(
            //     onTap: () {},
            //     child: Container(
            //       height: 37.h,
            //       margin: EdgeInsets.symmetric(horizontal: 2.h),
            //       decoration: BoxDecoration(
            //         color: const Color.fromARGB(255, 69, 67, 67),
            //         borderRadius: BorderRadius.circular(6.sp),
            //       ),
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           Padding(
            //             padding: EdgeInsets.only(left: 15.w),
            //             child: Text(
            //               'Search',
            //               style: GoogleFonts.poppins(
            //                 fontSize: 13.5.sp,
            //                 color: const Color.fromARGB(255, 205, 205, 205),
            //                 fontWeight: FontWeight.w500,
            //               ),
            //             ),
            //           ),
            //           Padding(
            //             padding: EdgeInsets.only(right: 10.w),
            //             child: const Icon(
            //               Icons.search,
            //               color: Colors.grey,
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            SizedBox(
              height: 20.h,
            ),
            SizedBox(height: 19.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    Get.to(() => const MusicList(
                          catagory: 'stories',
                        ));
                  },
                  child: const SearchCard(
                    url: 'stories',
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => const MusicList(
                          catagory: 'script',
                        ));
                  },
                  child: const SearchCard(
                    url: 'script',
                  ),
                )
              ],
            ),
            SizedBox(height: 19.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    Get.to(() => const MusicList(
                          catagory: 'music',
                        ));
                  },
                  child: const SearchCard(
                    url: 'conversation',
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => const MusicList(
                          catagory: 'recitation',
                        ));
                  },
                  child: const SearchCard(
                    url: 'recitation',
                  ),
                ),
              ],
            ),
            SizedBox(height: 19.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    Get.to(() => const MusicList(
                          catagory: 'conversation',
                        ));
                  },
                  child: const SearchCard(
                    url: 'conversation',
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => const MusicList(
                          catagory: 'others',
                        ));
                  },
                  child: const SearchCard(
                    url: 'others',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
