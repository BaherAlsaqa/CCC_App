import 'package:ccc_app/constants/constants.dart';
import 'package:ccc_app/utils/language.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomErrorText extends StatelessWidget {
  bool isEmpty;
  CustomErrorText({this.isEmpty = false});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isEmpty,
      child: Container(
          alignment: AlignmentDirectional.centerStart,
          margin: EdgeInsetsDirectional.only(start: 15.w, top: 8.h),
          child: Text(
            getTranslated(context, "pleaseChooseCity"),
            style: TextStyle(
                fontSize: 12.ssp,
                fontFamily: PRIMARY_FONT_LIGHT,
                color: Colors.red.shade700),
          )),
    );
  }
}
