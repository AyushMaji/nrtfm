import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nrtfm/constant/color.dart';
import 'package:nrtfm/utils/barrel.dart';
import 'package:nrtfm/widget/input_field/text_input_field.dart';

class MusicUplode extends StatefulWidget {
  const MusicUplode({Key? key}) : super(key: key);
  @override
  State<MusicUplode> createState() => _MusicUplodeState();
}

class _MusicUplodeState extends State<MusicUplode> {
  File? _pickedImage1;
  File? _pickedImage2;
  PlatformFile? _pickedMusic;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Kcolor.bgColor,
      bottomNavigationBar: InkWell(
        onTap: () {
          Get.back();
        },
        child: Container(
          height: 7.h,
          color: const Color.fromARGB(255, 1, 196, 50),
          child: Center(
            child: Text(
              'UPLODE',
              style: TextStyle(
                color: Colors.white,
                fontSize: 2.5.h,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      appBar: AppBar(
        elevation: 1,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Kcolor.primaryColor,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Uplode Music',
            style: TextStyle(
              color: Kcolor.txt1,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            )),
        backgroundColor: Kcolor.bgColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextInputField(
                  label: 'Song Tittle',
                  maxline: 1,
                  controller: TextEditingController(),
                ),
                SizedBox(
                  height: 3.h,
                ),
                TextInputField(
                  label: 'description',
                  maxline: 5,
                  controller: TextEditingController(),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Kcolor.primaryColor,
                        ),
                        onPressed: () => _loadPicker1(),
                        child: const Text("Uplode Banner Picture")),
                    _pickedImage1 == null
                        ? const Icon(
                            Icons.photo_size_select_actual_rounded,
                            color: Kcolor.secondaryColor,
                          )
                        : const Icon(
                            Icons.check_circle,
                            color: Color.fromARGB(255, 13, 240, 5),
                          ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Kcolor.primaryColor,
                        ),
                        onPressed: () {
                          _loadPicker2();
                        },
                        child: const Text("Uplode  image")),
                    _pickedImage2 == null
                        ? const Icon(
                            Icons.remove_red_eye_outlined,
                            color: Kcolor.secondaryColor,
                          )
                        : const Icon(
                            Icons.check_circle,
                            color: Color.fromARGB(255, 13, 240, 5),
                          ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Kcolor.primaryColor,
                        ),
                        onPressed: () {
                          _loadMusicPicker();
                        },
                        child: const Text("uplode  Music")),
                    _pickedMusic == null
                        ? const Icon(
                            Icons.queue_music_sharp,
                            color: Kcolor.secondaryColor,
                          )
                        : const Icon(
                            Icons.check_circle,
                            color: Color.fromARGB(255, 13, 240, 5),
                          )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ////  Al uploding fuction (image and music )  ////
  _loadPicker1() async {
    final ImagePicker picker = ImagePicker();
    XFile? pickedFile = (await picker.pickImage(source: ImageSource.gallery));
    setState(() {
      if (pickedFile != null) {
        _cropImage1(File(pickedFile.path));
      } else {
        log('No image selected.');
      }
    });
  }

  _loadPicker2() async {
    final ImagePicker picker = ImagePicker();
    XFile? pickedFile = (await picker.pickImage(source: ImageSource.gallery));
    setState(() {
      if (pickedFile != null) {
        _cropImage2(File(pickedFile.path));
      } else {
        log('No image selected.');
      }
    });
  }

  _cropImage1(File picked) async {
    CroppedFile? cropped = await ImageCropper().cropImage(
      sourcePath: picked.path,
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
        WebUiSettings(
          context: context,
        ),
      ],
      aspectRatioPresets: [
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio16x9,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.ratio7x5,
      ],
      maxWidth: 800,
    );
    if (cropped != null) {
      setState(() {
        _pickedImage1 = File(cropped.path);
      });
    }
  }

  _cropImage2(File picked) async {
    CroppedFile? cropped = await ImageCropper().cropImage(
      sourcePath: picked.path,
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
        WebUiSettings(
          context: context,
        ),
      ],
      aspectRatioPresets: [
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio16x9,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.ratio7x5,
      ],
      maxWidth: 800,
    );
    if (cropped != null) {
      setState(() {
        _pickedImage2 = File(cropped.path);
      });
    }
  }

  _loadMusicPicker() async {
    final audioFile = await FilePicker.platform.pickFiles(
      type: FileType.audio,
      allowMultiple: false,
    );
    if (audioFile != null) {
      setState(() {
        _pickedMusic = audioFile.files.first;
      });
    } else {
      // User canceled the picker
    }
  }
}
