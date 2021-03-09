import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:ccc_app/constants/colors.dart';
import 'package:ccc_app/constants/constants.dart';
import 'package:ccc_app/custom_widgets/CustomText.dart';
import 'package:ccc_app/provider/LanguageProvider.dart';
import 'package:ccc_app/utils/language.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'AppSharedPreference.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  getIt.registerLazySingleton<AppSharedPreferences>(
          () => AppSharedPreferences(sharedPreferences: getIt()));

  getIt.registerLazySingleton<LanguagesProvider>(
          () => LanguagesProvider(sharedPreferences: getIt()));

  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  Dio client = Dio(
    BaseOptions(
      headers: {
        'Accept-Language': 'ar',
        'Accept': 'application/json'
      },
    ),
  );

  getIt.registerLazySingleton<Dio>(() => client);
  getIt.registerLazySingleton(() => http.Client());

  getIt.registerLazySingleton(() async => await SharedPreferences.getInstance());

}

systemChrome({bool darkMode, Color navBarColor = white,
  Brightness navBrightness = Brightness.light}){
  if(darkMode)
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: navBrightness,
        systemNavigationBarDividerColor: navBrightness == Brightness.dark?
        white: black,
        systemNavigationBarColor: navBarColor));
  else
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: white,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: navBarColor));
}

showAlertString(BuildContext context, String title, String error, int type,
    {bool translate = true, bool fromSearch = false, Function onDone}) {
  Alert(
    style: AlertStyle(
      animationType: AnimationType.shrink,
      isCloseButton: false,
      isOverlayTapDismiss: !fromSearch,
      descStyle:
      TextStyle(color: black, fontSize: 16.ssp, fontFamily: PRIMARY_FONT_LIGHT),
      animationDuration: Duration(milliseconds: 300),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.sp),
        side: BorderSide(
          color: gray,
        ),
      ),
      titleStyle: TextStyle(
          color: type == 1? Colors.red: type == 2?
          Colors.blue: type == 3? Colors.green: Colors.red,
          fontSize: 18.ssp, fontFamily: PRIMARY_FONT_LIGHT),
    ),
    type: type == 1? AlertType.error:
    type == 2? AlertType.info:
    type == 3? AlertType.success:
    AlertType.error,
    context: context,
    title: getTranslated(context, title),
    desc: translate? getTranslated(context, error): error,
    buttons: [
      DialogButton(
        child: CustomText(
          'ok',
          textColor: white,
          primaryFont: PRIMARY_FONT_MEDIUM,
          fontSize: 18,
        ),
        onPressed: () {
          Navigator.pop(context, true);
          if(fromSearch)
            onDone();
        },
        color: primaryColor,
        radius: BorderRadius.circular(15.sp),
      ),
    ],)
      .show();
}

Future<File> getImageCrop() async {
  final imagePicker = ImagePicker();
  PickedFile image = await imagePicker.getImage(source: ImageSource.gallery);
  File imageFile = File(image.path);
  var i = await imageFile.readAsBytes();
  print('Select image readAsBytes = ' + i.length.toString());
  return _cropImage(imageFile);
}

Future<File> _cropImage(File imageFile) async {
  File croppedFile = await ImageCropper.cropImage(
      sourcePath: imageFile.path,
      maxWidth: 1200,
      maxHeight: 1200,
      compressQuality: 50,
      aspectRatioPresets: Platform.isAndroid
          ? [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ]
          : [
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio5x3,
        CropAspectRatioPreset.ratio5x4,
        CropAspectRatioPreset.ratio7x5,
        CropAspectRatioPreset.ratio16x9
      ],
      androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: primaryColor,
          toolbarWidgetColor: white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
      iosUiSettings: IOSUiSettings(
        title: 'Cropper',
      ));
  if (croppedFile != null) {
    imageFile = croppedFile;
    var c = await imageFile.readAsBytes();
    print("Select image after cropp = "+c.length.toString());
    return imageFile;
  }
}

