import 'package:nrtfm/constant/color.dart';
import 'package:nrtfm/utils/barrel.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Kcolor.bgColor,
        floatingActionButton: FloatingActionButton(
          onPressed: () async {},
          backgroundColor: Kcolor.primaryColor,
          child: const Icon(Icons.music_note),
        ),
        body: Container(),
      ),
    );
  }
}
