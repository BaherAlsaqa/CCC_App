import 'package:ccc_app/constants/colors.dart';
import 'package:ccc_app/constants/constants.dart';
import 'package:ccc_app/custom_widgets/CustomAppBar.dart';
import 'package:ccc_app/custom_widgets/CustomButton.dart';
import 'package:ccc_app/custom_widgets/CustomText.dart';
import 'package:ccc_app/custom_widgets/CustomTextField.dart';
import 'package:ccc_app/screens/home/HomeScreen.dart';
import 'package:ccc_app/singleton/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController userMobile = TextEditingController();
  TextEditingController password = TextEditingController();
  FocusNode focus1 = FocusNode();
  FocusNode focus2 = FocusNode();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    systemChrome(darkMode: true);
    return Container(
      color: primaryColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: white,
          appBar: CustomAppBar(
            primaryColor,
            showTitle: true,
            title: 'login',
          ),
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  SizedBox(height: 180.h,),
                  Container(
                    padding: EdgeInsetsDirectional.only(
                        start: 22.w, end: 22.w, top: 0.h, bottom: 0.h),
                    alignment: AlignmentDirectional.centerStart,
                    child: CustomText(
                      "welcome",
                      fontSize: 20,
                      primaryFont: PRIMARY_FONT_MEDIUM,
                      fontWeight: FontWeight.w500,
                      textColor: textBlackLight,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.only(
                        start: 22.w, end: 22.w, top: 0.h, bottom: 0.h),
                    child: CustomTextField(
                      "mobileNumber",
                      userMobile,
                      focus1,
                      focus2,
                      MOBILE,
                      "pleaseEnterMobile",
                      onDone: (value) {
                        userMobile.text = value.substring(1);
                        userMobile.selection =
                            TextSelection.fromPosition(TextPosition(offset: 1));
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.only(
                        start: 22.w, end: 22.w, top: 0.h, bottom: 0.h),
                    child: CustomTextField("password", password, focus2, focus2,
                        PASSWORD, "pleaseEnterPassword"),
                  ),
                  SizedBox(
                    height: 58.h,
                  ),
                  CustomButton(
                    color: buttonColor,
                    title: "loginButton",
                    function: () {
                      if (formKey.currentState.validate()) {
                        //todo // enter you code here
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(0, userMobile.text.toString()),
                          ),
                        );
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    userMobile.clear();
    password.clear();
  }
}
