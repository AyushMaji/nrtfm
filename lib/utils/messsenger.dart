import 'package:nrtfm/utils/barrel.dart';

class Snackber {
  static successSnackbar(String title, String subtitle) => Get.snackbar(
        title,
        subtitle,
        icon: const Icon(
          Icons.error,
          color: Colors.white,
        ),
        backgroundColor: const Color.fromARGB(255, 9, 155, 4),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(10),
      );
  static errorSnackbar(String title, String subtitle) => Get.snackbar(
        title,
        subtitle,
        icon: const Icon(
          Icons.error,
          color: Colors.white,
        ),
        backgroundColor: const Color.fromARGB(255, 229, 7, 7),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(10),
      );
}
