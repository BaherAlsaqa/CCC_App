import 'package:ccc_app/constants/colors.dart';
import 'package:ccc_app/constants/constants.dart';
import 'package:ccc_app/custom_widgets/CustomText.dart';
import 'package:ccc_app/models/OrderModel.dart';
import 'package:ccc_app/screens/order_details/OrderDetailsScreen.dart';
import 'package:ccc_app/singleton/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderCell extends StatelessWidget {
  OrderModel orderModel;
  String mobile;
  OrderCell(this.mobile, {this.orderModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        systemChrome(darkMode: true, navBrightness: Brightness.light,
            navBarColor: white);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OrderDetailsScreen(orderModel, mobile),
          ),
        );
      },
      child: Container(
        height: 110.h,
        width: 1.0.sw,
        margin: EdgeInsetsDirectional.only(
          start: 0.w, end: 0.w, top: 0.h, bottom: 15.h
        ),
        padding: EdgeInsetsDirectional.only(
          start: 15.w, end: 15.w, top: 15.h, bottom: 15.h
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.only(
              topStart: Radius.circular(15.sp),
              topEnd: Radius.circular(15.sp),
              bottomStart: Radius.circular(15.sp),
              bottomEnd: Radius.circular(15.sp)),
          color: white,
          boxShadow: [
            BoxShadow(
              color: shadowColor.withOpacity(0.3.sp),
              blurRadius: 5.0.sp, // soften the shadow
              spreadRadius: 0.0.sp, //extend the shadow
              offset: Offset(
                0.0.sp, // Move to right 10  horizontally
                0.0.sp, // Move to bottom 10 Vertically
              ),
            )
          ],
        ),
        child: Stack(
          children: [
            PositionedDirectional(
              top: 0.h,
              end: 0.w,
              child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                CircularProgressIndicator(
                  value: double.parse(orderModel.progress)/100,
                  valueColor: AlwaysStoppedAnimation(secondaryColor),
                  backgroundColor: gray0,
                  strokeWidth: 3.w,
                  // backgroundColor: Colors.grey.shade400,
                ),
                Padding(
                  padding: EdgeInsetsDirectional.only(
                    start: 0.w, end: 0.w, top: 3.h, bottom: 0.h
                  ),
                  child: Row(
                    children: [
                      CustomText(
                        orderModel.progress,
                        translate: false,
                        textColor: secondaryColor,
                        primaryFont: PRIMARY_FONT_MEDIUM,
                        fontSize: 13,
                      ),
                      SizedBox(width: 1.w,),
                      CustomText(
                        '%',
                        translate: false,
                        textColor: secondaryColor,
                        primaryFont: PRIMARY_FONT_MEDIUM,
                        fontSize: 10,
                      )
                    ],
                  ),
                ),
              ],
            ),),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CustomText(
                          'id:',
                          textColor: primaryColor,
                          primaryFont: PRIMARY_FONT_MEDIUM,
                          fontSize: 15,
                        ),
                        CustomText(
                          orderModel.id,
                          translate: false,
                          textColor: primaryColor,
                          primaryFont: PRIMARY_FONT_LIGHT,
                          fontSize: 14,
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CustomText(
                          'startDate:',
                          textColor: primaryColor,
                          primaryFont: PRIMARY_FONT_MEDIUM,
                          fontSize: 15,
                        ),
                        CustomText(
                          orderModel.startDate,
                          translate: false,
                          textColor: primaryColor,
                          primaryFont: PRIMARY_FONT_LIGHT,
                          fontSize: 14,
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CustomText(
                          'endDate:',
                          textColor: primaryColor,
                          primaryFont: PRIMARY_FONT_MEDIUM,
                          fontSize: 15,
                        ),
                        SizedBox(width: 3.w,),
                        CustomText(
                          orderModel.endDate,
                          translate: false,
                          textColor: primaryColor,
                          primaryFont: PRIMARY_FONT_LIGHT,
                          fontSize: 14,
                        )
                      ],
                    ),
                    Row(
                      children: [
                        CustomText(
                          'region:',
                          textColor: primaryColor,
                          primaryFont: PRIMARY_FONT_MEDIUM,
                          fontSize: 15,
                        ),
                        SizedBox(width: 3.w,),
                        CustomText(
                          orderModel.region,
                          translate: false,
                          textColor: primaryColor,
                          primaryFont: PRIMARY_FONT_LIGHT,
                          fontSize: 14,
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
