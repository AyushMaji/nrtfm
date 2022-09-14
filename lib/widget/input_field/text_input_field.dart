import 'package:nrtfm/constant/color.dart';
import 'package:nrtfm/utils/barrel.dart';

class TextInputField extends StatelessWidget {
  final String label;
  final int maxline;
  final TextEditingController controller;
  const TextInputField(
      {Key? key,
      required this.label,
      required this.maxline,
      required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: maxline,
      controller: controller,
      keyboardType: TextInputType.multiline,
      style: const TextStyle(fontSize: 20, color: Kcolor.white),
      decoration: InputDecoration(
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 28, 198, 181))),
        label: Text(
          label,
          style: TextStyle(
            color: Kcolor.txt1,
            fontSize: 15.sp,
          ),
        ),
        filled: true,
        fillColor: const Color.fromARGB(189, 20, 19, 19),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(width: 1, color: Kcolor.primaryColor),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(width: 1, color: Kcolor.primaryColor),
        ),
      ),
    );
  }
}
