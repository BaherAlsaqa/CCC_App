import 'package:ccc_app/constants/colors.dart';
import 'package:ccc_app/constants/constants.dart';
import 'package:ccc_app/utils/language.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomText extends StatelessWidget {
  String text;
  bool translate;
  double fontSize;
  String primaryFont;
  FontWeight fontWeight;
  Color textColor;
  int lines;
  TextAlign textAlign;
  bool paragraph;

  CustomText(this.text,
      {this.fontSize = 14,
      this.primaryFont = PRIMARY_FONT_LIGHT,
      this.fontWeight = FontWeight.normal,
      this.textColor = textBlackLight,
      this.translate = true,
      this.lines = 1,
      this.textAlign = TextAlign.start,
      this.paragraph = false});

  @override
  Widget build(BuildContext context) {
    return Text(
      translate? getTranslated(context, text): text,
      textAlign: textAlign,
      maxLines: paragraph? null: lines,
      style: TextStyle(
        fontSize: fontSize.ssp,
        fontFamily: primaryFont,
        fontWeight: fontWeight,
        color: textColor,
      ),
    );
  }
}
