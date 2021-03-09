import 'package:ccc_app/constants/colors.dart';
import 'package:ccc_app/constants/constants.dart';
import 'package:ccc_app/utils/language.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'CustomText.dart';

class CustomTextField extends StatefulWidget {
  String str;
  bool translate;
  TextEditingController controller;
  FocusNode focusNode;
  FocusNode nextFocusNode;
  FocusNode previousFocusNode;
  String emptyError;
  String serverErrorMessage;
  int type;
  Function onDone;
  Function onFieldSubmitted;
  int lines;
  bool enableValidation;
  bool serverError;
  num errorColor;

  CustomTextField(this.str, this.controller, this.focusNode, this.nextFocusNode,
      this.type, this.emptyError,
      {this.serverErrorMessage,
      this.enableValidation = true,
      this.previousFocusNode,
      this.translate = true,
      this.lines = 1,
      this.onDone,
      this.onFieldSubmitted,
      this.serverError = false,
      this.errorColor = 0xffD32F2F});

  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;
  bool value = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(top: 12.h),
      child: Stack(
        alignment: AlignmentDirectional.centerStart,
        children: [
          TextFormField(
            onChanged: (value) {
              // print("onChanged = " + value);
              if (widget.type == CODE && value.isEmpty ||
                  value == "" ||
                  value.length == 0) {
                FocusScope.of(context).requestFocus(widget.previousFocusNode);
                return;
              }else if (widget.type == CODE && value.length == 4){
                widget.onDone(value);
              }
              if (value.length == 1 && value == "0" && widget.type == MOBILE) {
                widget.onDone(value);
                //todo //in implementation onDone function to remove zero in the first number
                // onDone: (value) {
                //   userMobile.text = value.substring(1);
                //   userMobile.selection =
                //       TextSelection.fromPosition(TextPosition(offset: 1));
                // },
              } else if (widget.type == SEARCH) {
                widget.onDone(value);
              }
              /* else if (widget.type == CODE && value.length >= 1) {
                FocusScope.of(context).requestFocus(widget.nextFocusNode);
              }*/
            },
            validator: (value) {
              if (value.isEmpty && widget.enableValidation) {
                setState(() {
                  this.value = true;
                });
                return getTranslated(context, widget.emptyError);
              } else if (value.length < 9 && widget.type == MOBILE) {
                setState(() {
                  this.value = true;
                });
                return getTranslated(context, "incorrectPhoneNum");
              } else if (widget.type == PROMO_CODE && widget.serverError) {
                setState(() {
                  this.value = true;
                });
                return widget.serverErrorMessage;
              }
              setState(() {
                this.value = false;
              });
              return null;
            },
            keyboardType: widget.type == EMAIL
                ? TextInputType.emailAddress
                : widget.type == MOBILE || widget.type == CODE
                    ? TextInputType.phone
                    : widget.type == PASSWORD
                        ? TextInputType.visiblePassword
                        : TextInputType.text,
            cursorColor: widget.type == SEARCH ? white : primaryColor,
            controller: widget.controller,
            focusNode: widget.focusNode,
            textAlign: widget.type == CODE || widget.type == PROMO_CODE
                ? TextAlign.center
                : TextAlign.start,
            obscureText:
                (_obscureText && widget.type == PASSWORD) ? true : false,
            maxLength: widget.type == MOBILE
                ? 9
                : widget.type == CODE
                    ? 4
                    : widget.type == PROMO_CODE
                        ? 8
                        : null,
            maxLines: widget.lines,
            style: TextStyle(
                color: widget.type == SEARCH ? textBlackLight : textBlackLight,
                fontFamily: widget.type == MOBILE ||
                        widget.type == CODE ||
                        widget.type == PROMO_CODE
                    ? PRIMARY_FONT_LIGHT
                    : PRIMARY_FONT_LIGHT,
                fontSize: 15.ssp),
            textInputAction: widget.type == CODE || widget.type == PROMO_CODE
                ? TextInputAction.send
                : (widget.focusNode != widget.nextFocusNode)
                    ? TextInputAction.next
                    : TextInputAction.done,
            decoration: InputDecoration(
              focusColor: white,
              hoverColor: white,
              filled: true,
              fillColor: white,
              counterText: "",
              errorStyle: TextStyle(
                  fontSize: 12.ssp,
                  fontFamily: widget.type == MOBILE ||
                          widget.type == CODE ||
                          widget.type == PROMO_CODE
                      ? PRIMARY_FONT_LIGHT
                      : PRIMARY_FONT_LIGHT,
                  color: Color(widget.errorColor)),
              contentPadding: EdgeInsetsDirectional.only(
                  top: widget.type == CODE || widget.type == PROMO_CODE
                      ? 0.h
                      : 5.h,
                  bottom: 0.h,
                  start: widget.type == CODE || widget.type == PROMO_CODE
                      ? 28.w
                      : 40.w),
              hintText: widget.translate
                  ? getTranslated(context, widget.str)
                  : widget.str,
              hintStyle: TextStyle(
                  color:
                      widget.type == SEARCH ? textBlackLight : textBlackLight,
                  fontFamily: widget.type == MOBILE ||
                          widget.type == CODE ||
                          widget.type == PROMO_CODE
                      ? PRIMARY_FONT_LIGHT
                      : PRIMARY_FONT_LIGHT,
                  fontSize: 14.ssp),
              border: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: grayBorder.withOpacity(0.2), width: 2.h)),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: grayBorder.withOpacity(0.2), width: 2.h)),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: grayBorder.withOpacity(0.2), width: 2.h)),
              focusedErrorBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Color(widget.errorColor), width: 2.h)),
              errorBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Color(widget.errorColor), width: 2.h)),
            ),
            onEditingComplete: () {
              print("onEditingComplete");
              setState(() {
                (widget.focusNode != widget.nextFocusNode)
                    ? FocusScope.of(context).requestFocus(widget.nextFocusNode)
                    : widget.focusNode.unfocus();
              });
            },
            onFieldSubmitted: (value) {
              print('kjsdhkj');
              if (widget.type == CODE || widget.type == PROMO_CODE) {
                widget.onFieldSubmitted(value);
              }
            },
          ),
          Padding(
            padding: EdgeInsetsDirectional.only(
                start: 0.w, end: 0.w, top: 0.h, bottom: ((value) ? 20.h : 0.h)),
            child: prefix(),
          ), // MobileCode(widget.type)
          if (widget.type == PASSWORD)
            PositionedDirectional(
                end: 0,
                child: Padding(
                  padding: EdgeInsetsDirectional.only(
                      start: 0.w,
                      end: 0.w,
                      top: 0.h,
                      bottom: ((value) ? 20.h : 0.h)),
                  child: suffix(),
                ))
        ],
      ),
    );
  }

  Widget suffix() {
    return Padding(
      padding: EdgeInsetsDirectional.only(end: 5.w),
      child: IconButton(
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
        icon: _obscureText
            ? Icon(
                Icons.visibility_off,
                color: obscureColor.withOpacity(0.3.sp),
                size: 20.w,
              )
            : Icon(
                Icons.visibility,
                color: obscureColor.withOpacity(0.3.sp),
                size: 20.w,
              ),
      ),
    );
  }

  Widget prefix() {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 5.w),
      child: SvgPicture.asset(
        ICONS +
            (widget.type == MOBILE
                ? "call.svg"
                : widget.type == FULL_NAME
                    ? "user_circle.svg"
                    : widget.type == EMAIL
                        ? "earth.svg"
                        : widget.type == CODE || widget.type == PROMO_CODE
                            ? "code.svg"
                            : "lock.svg"),
        color: secondaryColor,
      ),
    );
  }
}
