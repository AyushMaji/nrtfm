import 'package:nrtfm/utils/barrel.dart';

class Header extends StatelessWidget {
  final String url;
  final bool isShow;
  final Icon icon;
  const Header(
      {Key? key, required this.url, required this.icon, required this.isShow})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(
          url,
          width: 90.w,
        ),
        isShow ? icon : const SizedBox(),
      ],
    );
  }
}
