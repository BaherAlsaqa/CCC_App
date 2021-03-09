import 'package:ccc_app/constants/colors.dart';
import 'package:ccc_app/constants/constants.dart';
import 'package:ccc_app/utils/language.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomButton extends StatefulWidget {
  Color color;
  double width;
  double height;
  String title;
  Function function;
  Color textColorValue;
  Color borderColor;
  double radius;
  double borderWidth;

  CustomButton({
    this.color = buttonColor,
    this.width = 141.0,
    this.height = 50.0,
    this.title = "",
    this.function,
    this.textColorValue = white,
    this.borderColor = buttonColor,
    this.radius = 15.0,
    this.borderWidth = 0.0,
  });

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        color: widget.color,
        focusColor: widget.color,
        disabledColor: widget.color,
        hoverColor: widget.color,
        elevation: 0,
        shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusDirectional.only(
                  topEnd: Radius.circular(widget.radius.w),
                  bottomEnd: Radius.circular(widget.radius.w),
                  topStart: Radius.circular(widget.radius.w),
                  bottomStart: Radius.circular(widget.radius.w)
                ),
        side: BorderSide(color: widget.borderColor, width: widget.borderWidth.w),),
        child: Container(
            width: widget.width.w,
            height: widget.height.h,
            alignment: AlignmentDirectional.center,
            padding: EdgeInsetsDirectional.only(
              start: 5.w, end: 5.w, top: 0.h, bottom: 0.h
            ),
            child: Text(
                getTranslated(context, widget.title),
              style: TextStyle(
                fontSize: 16.ssp,
                fontFamily: PRIMARY_FONT_MEDIUM,
                color: widget.textColorValue,
              ),
            )),
        onPressed: widget.function);
  }
}
