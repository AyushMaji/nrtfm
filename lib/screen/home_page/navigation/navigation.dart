import 'package:bottom_bar/bottom_bar.dart';
import 'package:nrtfm/constant/color.dart';
import 'package:nrtfm/screen/home_page/navigation/fav_page.dart';
import 'package:nrtfm/screen/home_page/navigation/home_page.dart';
import 'package:nrtfm/screen/home_page/navigation/search_page.dart';
import 'package:nrtfm/screen/home_page/navigation/setting_page.dart';
import 'package:nrtfm/utils/barrel.dart';

class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int currentPage = 0;
  final PageController _pageController = PageController();
  List<Widget> page = const [
    HomePage(),
    SearchPage(),
    FavPage(),
    SettingPage(),
  ];
  List<BottomBarItem> icon = const <BottomBarItem>[
    BottomBarItem(
      icon: Icon(Icons.home),
      title: Text('Home'),
      activeColor: Kcolor.primaryColor,
      activeTitleColor: Kcolor.white,
      activeIconColor: Kcolor.white,
      inactiveColor: Kcolor.primaryColor,
      backgroundColorOpacity: 1,
    ),
    BottomBarItem(
      icon: Icon(Icons.search),
      title: Text('Search'),
      activeColor: Kcolor.primaryColor,
      activeTitleColor: Kcolor.white,
      activeIconColor: Kcolor.white,
      inactiveColor: Kcolor.primaryColor,
      backgroundColorOpacity: 1,
    ),
    BottomBarItem(
      icon: Icon(Icons.favorite),
      title: Text('Favorite'),
      activeColor: Kcolor.primaryColor,
      activeTitleColor: Kcolor.white,
      activeIconColor: Kcolor.white,
      inactiveColor: Kcolor.primaryColor,
      backgroundColorOpacity: 1,
    ),
    BottomBarItem(
      icon: Icon(Icons.settings),
      title: Text('Settings'),
      activeColor: Kcolor.primaryColor,
      activeTitleColor: Kcolor.white,
      activeIconColor: Kcolor.white,
      inactiveColor: Kcolor.primaryColor,
      backgroundColorOpacity: 1,
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Kcolor.bgColor,
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(0, 43, 43, 43),
                Color.fromARGB(185, 0, 0, 0)
              ]),
        ),
        child: BottomBar(
          backgroundColor: Colors.transparent,
          onTap: (index) {
            setState(() {
              currentPage = index;
            });
            _pageController.jumpToPage(index);
          },
          selectedIndex: currentPage,
          items: icon,
        ),
      ),
      body: PageView(
        controller: _pageController,
        children: page,
        onPageChanged: (index) {
          setState(() => currentPage = index);
        },
      ),
    );
  }
}
