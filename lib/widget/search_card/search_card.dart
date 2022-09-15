import 'package:nrtfm/utils/barrel.dart';

class SearchCard extends StatelessWidget {
  final String url;
  const SearchCard({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.h,
      width: 140.w,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/$url.png'),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
