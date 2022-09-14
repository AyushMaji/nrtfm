import 'package:nrtfm/constant/color.dart';
import 'package:nrtfm/utils/barrel.dart';
import 'package:nrtfm/widget/bookmark_card/bookmark_card.dart';

class FavPage extends StatelessWidget {
  const FavPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Kcolor.bgColor,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              elevation: 0,
              leading: Visibility(
                visible: false,
                child: IconButton(
                  icon: const Icon(
                    Icons.music_note,
                    color: Color.fromARGB(199, 241, 8, 8),
                  ),
                  onPressed: () {},
                ),
              ),
              backgroundColor: Kcolor.bgColor,
              expandedHeight: 32.h,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  "Favourites",
                  style: GoogleFonts.hind(
                    color: Kcolor.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                background: Image.asset(
                  'assets/images/fabposter.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ];
        },
        body: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListView.builder(
              scrollDirection: Axis.vertical,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 20,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.only(bottom: 1.5.h),
                  child: const BookMarkCard(
                    imageUrl:
                        "https://img.freepik.com/free-photo/acoustic-guitar-close-up-beautiful-colored-background_169016-3530.jpg?w=900&t=st=1663069595~exp=1663070195~hmac=edb33da5fa3fb1daa4c8fcac815de2d1150dba4ee7dc639515dd4e5c9b64727f",
                    title: 'Acoustic Guitar Song',
                    views: '1.5k views | podcast',
                    catagory: 'podcast',
                  ),
                );
              },
            ),
          ],
        )),
      ),
    );
  }
}
