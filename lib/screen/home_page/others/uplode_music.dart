import 'dart:developer';
import 'dart:io';

import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nrtfm/constant/color.dart';
import 'package:nrtfm/provider/userdata.dart';
import 'package:nrtfm/utils/barrel.dart';
import 'package:nrtfm/utils/messsenger.dart';
import 'package:nrtfm/widget/input_field/text_input_field.dart';

class MusicUplode extends StatefulWidget {
  const MusicUplode({Key? key}) : super(key: key);
  @override
  State<MusicUplode> createState() => _MusicUplodeState();
}

class _MusicUplodeState extends State<MusicUplode> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  File? _pickedImage1;
  File? _pickedImage2;
  PlatformFile? _pickedMusic;
  String iteamData = "Select Catagory";
  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    final List<String> items = [
      'stories',
      'script',
      'conversation',
      'recitation',
      'music',
      'other'
    ];

    return Scaffold(
      backgroundColor: Kcolor.bgColor,
      bottomNavigationBar: Provider.of<UserDataProvider>(context, listen: true)
                  .getIsuplode ==
              false
          ? InkWell(
              onTap: () {
                if (_titleController.text.isNotEmpty &&
                    _descriptionController.text.isNotEmpty &&
                    _pickedImage1 != null &&
                    _pickedImage2 != null &&
                    _pickedMusic != null &&
                    iteamData != "Select Catagory") {
                  Provider.of<UserDataProvider>(context, listen: false)
                      .uplodeSong(
                          _pickedImage1!,
                          _pickedImage2!,
                          _titleController.text,
                          _descriptionController.text,
                          _pickedMusic!,
                          selectedValue!,
                          Provider.of<UserDataProvider>(context, listen: false)
                                  .getUid ??
                              "NRT FM",
                          Provider.of<UserDataProvider>(context, listen: false)
                                  .getName ??
                              "NRT FM")
                      .whenComplete(() => {Get.back()});
                } else {
                  Snackber.errorSnackbar(
                      'Uplode failed', 'Please fill all the fields');
                }
              },
              child: Container(
                height: 43.h,
                color: const Color.fromARGB(255, 1, 196, 50),
                child: Center(
                  child: Text(
                    Provider.of<UserDataProvider>(context, listen: true)
                                .getIsuplode ==
                            false
                        ? 'Uplode'
                        : 'Uploding...',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.5.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            )
          : const Center(child: CircularProgressIndicator()),
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Kcolor.bgColor,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Kcolor.primaryColor,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Uplode Music',
            style: TextStyle(
              color: Kcolor.txt2,
              fontSize: 17.sp,
              fontWeight: FontWeight.bold,
            )),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 25.h),
              TextInputField(
                label: 'Song Tittle',
                maxline: 1,
                controller: _titleController,
              ),
              SizedBox(
                height: 20.h,
              ),
              TextInputField(
                label: 'description',
                maxline: 3,
                controller: _descriptionController,
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Kcolor.primaryColor,
                      ),
                      onPressed: () => _loadPicker1(),
                      child: Text("Uplode Banner Picture",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
                          ))),
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
                      child: Text("Uplode  image",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
                          ))),
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
                      child: Text("uplode  Music",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
                          ))),
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
              SizedBox(
                height: 20.h,
              ),
              CustomDropdownButton2(
                buttonWidth: double.infinity,
                buttonHeight: 45.h,
                dropdownWidth: 300.w,
                buttonDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  border: Border.all(
                    color: const Color.fromARGB(121, 240, 0, 0),
                    width: 2,
                  ),
                  color: const Color.fromARGB(81, 159, 158, 158),
                ),
                hint: iteamData,
                dropdownItems: items,
                value: selectedValue,
                onChanged: (value) {
                  setState(() {
                    selectedValue = value;
                    iteamData = value!;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///  Al uploding fuction (image and music )  ///
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
