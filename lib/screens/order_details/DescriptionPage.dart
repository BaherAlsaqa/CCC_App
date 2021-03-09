import 'package:ccc_app/constants/colors.dart';
import 'package:ccc_app/constants/constants.dart';
import 'package:ccc_app/custom_widgets/CustomText.dart';
import 'package:ccc_app/models/OrderModel.dart';
import 'package:ccc_app/models/WorkDescriptionItem.dart';
import 'package:ccc_app/singleton/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class DescriptionPage extends StatefulWidget {
  OrderModel orderModel;
  DescriptionPage(this.orderModel);
  @override
  _DescriptionPageState createState() => _DescriptionPageState();
}

class _DescriptionPageState extends State<DescriptionPage> {
  List<WorkDescriptionItem> workDescLists = List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    workDescLists.add(WorkDescriptionItem('putFormWork', 0.0));
    workDescLists.add(WorkDescriptionItem('rebar', 50.0));
    workDescLists.add(WorkDescriptionItem('castConcrete', 30.0));
    workDescLists.add(WorkDescriptionItem('curing', 90.0));
    workDescLists.add(WorkDescriptionItem('removeFormWork', 70.0));
  }

  @override
  Widget build(BuildContext context) {
    systemChrome(
        darkMode: true, navBrightness: Brightness.light, navBarColor: white);
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsetsDirectional.only(
            start: 20.w, end: 0.w, top: 20.h, bottom: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.only(
                start: 0.w, end: 20.w, top: 0.h, bottom: 0.h
              ),
              child: Container(
                height: 120.h,
                width: 1.0.sw,
                child: Stack(
                  alignment: AlignmentDirectional.centerStart,
                  children: [
                    CustomText(
                      'workDescription:',
                      textColor: primaryColor,
                      primaryFont: PRIMARY_FONT_BOLD,
                      fontSize: 18,
                    ),
                    itemRowOrderProgress()
                  ],
                ),
              ),
            ),
            // SizedBox(height: 100.h,),
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: workDescLists.length,
                itemBuilder: (context, index) {
                  return itemRowWorkProgress(
                      workDescLists[index],
                      workDescLists[index].title,
                      workDescLists[index].value / 100, (_value) {
                    setState(() {
                      workDescLists[index].value = _value * 100;
                    });
                  });
                })
          ],
        ),
      ),
    );
  }

  Widget itemRowWorkProgress(WorkDescriptionItem workDescriptionItem,
      String title, dynamic value, Function result) {
    return Row(
      children: [
        Container(
          width: 110.w,
          child: CustomText(
            title,
            textColor: primaryColor,
            primaryFont: PRIMARY_FONT_MEDIUM,
            fontSize: 15,
          ),
        ),
        Expanded(
          child: Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: [
              SliderTheme(
                data: SliderThemeData(
                  thumbColor: primaryColor,
                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8.sp),
                  trackHeight: 2.h,
                ),
                child: Slider(
                    value: value,
                    onChanged: (_value) {
                      print('onChange = ' + _value.toString());
                      result(_value);
                      // workDescriptionItem.value = _value;
                      // setState(() {});
                    }),
              ),
              PositionedDirectional(
                end: 25.w,
                child: CustomText(
                  (value*100).toString().split('.')[0]+
                      '.'+(value*100).toString().split('.')[1].substring(0, 1)+
                      ' %',
                  translate: false,
                  textColor: primaryColor,
                  primaryFont: PRIMARY_FONT_LIGHT,
                  fontSize: 11,
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget itemRowOrderProgress() {
    return PositionedDirectional(
        top: 2.h,
        end: 2.w,
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Container(
              width: 100.w,
              height: 100.w,
              child: CircularProgressIndicator(
                value: ((workDescLists[0].value+
                    workDescLists[1].value+
                    workDescLists[2].value+
                    workDescLists[3].value+
                    workDescLists[4].value)/5) / 100,
                valueColor: AlwaysStoppedAnimation(secondaryColor),
                backgroundColor: gray0,
                strokeWidth: 4.w,
                // backgroundColor: Colors.grey.shade400,
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(
                  start: 0.w, end: 0.w, top: 3.h, bottom: 0.h),
              child: Row(
                children: [
                  CustomText(
                    (((workDescLists[0].value+
                        workDescLists[1].value+
                        workDescLists[2].value+
                        workDescLists[3].value+
                        workDescLists[4].value)/5)).toString().split('.')[0]
                        +'.'+(((workDescLists[0].value+
                        workDescLists[1].value+
                        workDescLists[2].value+
                        workDescLists[3].value+
                        workDescLists[4].value)/5)).toString().split('.')[1].substring(0, 1),
                    translate: false,
                    textColor: secondaryColor,
                    primaryFont: PRIMARY_FONT_MEDIUM,
                    fontSize: 18,
                  ),
                  SizedBox(
                    width: 1.w,
                  ),
                  CustomText(
                    '%',
                    translate: false,
                    textColor: secondaryColor,
                    primaryFont: PRIMARY_FONT_MEDIUM,
                    fontSize: 14,
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
