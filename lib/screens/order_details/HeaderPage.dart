import 'dart:io';

import 'package:ccc_app/cells/CommentCell.dart';
import 'package:ccc_app/constants/colors.dart';
import 'package:ccc_app/constants/constants.dart';
import 'package:ccc_app/custom_widgets/CustomText.dart';
import 'package:ccc_app/models/CommentItem.dart';
import 'package:ccc_app/models/OrderModel.dart';
import 'package:ccc_app/singleton/dio.dart';
import 'package:ccc_app/utils/language.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
class HeaderPage extends StatefulWidget {
  OrderModel orderModel;
  String mobile;
  HeaderPage(this.orderModel, this.mobile);
  @override
  _HeaderPageState createState() => _HeaderPageState();
}

class _HeaderPageState extends State<HeaderPage> {
  TextEditingController messageController = TextEditingController();
  List<CommentItem> commentsList = List();
  ScrollController _scrollController = ScrollController();
  File fileImage;
  bool viewBoxImage = false;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    commentsList.add(CommentItem('Murad', 'Example comment for testing'*3, 'image1.jpg', null));
    commentsList.add(CommentItem('Baher Alsaqa', 'Example comment for testing'*3, 'image2.jpg', null));

  }
  
  @override
  Widget build(BuildContext context) {
    systemChrome(
        darkMode: true, navBrightness: Brightness.light, navBarColor: white);
    return Scaffold(
      bottomNavigationBar: typeComment(),
      // resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Padding(
          padding: EdgeInsetsDirectional.only(
              start: 15.w, end: 15.w, top: 20.h, bottom: 15.h),
          child: Stack(
            children: [
              itemRowOrderProgress(),
              Column(
                children: [
                  itemRowData('id:', widget.orderModel.id),
                  SizedBox(
                    height: 20.h,
                  ),
                  itemRowData('startDate:', widget.orderModel.startDate),
                  SizedBox(
                    height: 20.h,
                  ),
                  itemRowData('endDate:', widget.orderModel.endDate),
                  SizedBox(
                    height: 20.h,
                  ),
                  itemRowData('region:', widget.orderModel.region),
                  SizedBox(
                    height: 20.h,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        'details:',
                        textColor: primaryColor,
                        primaryFont: PRIMARY_FONT_BOLD,
                        fontSize: 16,
                      ),
                      CustomText(
                        widget.orderModel.details,
                        translate: false,
                        textColor: primaryColor,
                        primaryFont: PRIMARY_FONT_MEDIUM,
                        fontSize: 14,
                        paragraph: true,
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h,),
                  Divider(
                    height: 1.h,
                    color: gray,
                  ),
                  SizedBox(height: 10.h,),
                  CustomText(
                    'comments',
                    textColor: primaryColor,
                    primaryFont: PRIMARY_FONT_BOLD,
                    fontSize: 18,
                  ),
                  SizedBox(height: 5.h,),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: commentsList.length,
                      itemBuilder: (context, index){
                      return CommentCell(commentsList[index]);
                  })
                ],
              ),
            ],
          ),
        ),
      ),
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
                value: double.parse(widget.orderModel.progress) / 100,
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
                    widget.orderModel.progress,
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

  Widget itemRowData(String title, String value) {
    return Row(
      children: [
        CustomText(
          title,
          textColor: primaryColor,
          primaryFont: PRIMARY_FONT_BOLD,
          fontSize: 16,
        ),
        CustomText(
          value,
          translate: false,
          textColor: primaryColor,
          primaryFont: PRIMARY_FONT_MEDIUM,
          fontSize: 14,
        ),
      ],
    );
  }

  Widget typeComment() {
    return IntrinsicHeight(
      child: Container(
        width: 1.0.sw,
        // height: 150.h,
        child: Column(
          children: [
            if(viewBoxImage)
              IntrinsicHeight(
                child: Container(
                  width: 1.0.sw,
                  color: gray0,
                  child: Padding(
                    padding: EdgeInsetsDirectional.only(
                      start: 10.w, end: 10.w, top: 10.h, bottom: 0.h
                    ),
                    child: imageContainer(),
                  ),
                ),
              ),
            TextField(
              minLines: 1,
              maxLines: 4,
              style: TextStyle(
                fontFamily: PRIMARY_FONT_LIGHT,
                fontSize: 16.ssp,
              ),
              // onSubmitted: (value) => ,
              controller: messageController,
              cursorColor: primaryColor,
              onChanged: (value){
                setState(() {

                });
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsetsDirectional.only(
                    top: 10.h, bottom: 10.h, start: 15.w, end: 15.w),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.sp)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.sp),
                  borderSide: BorderSide(color: offWhite, width: 0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.sp),
                  borderSide: BorderSide(color: offWhite, width: 0),
                ),
                suffixIcon: InkWell(
                  onTap: messageController.text.isEmpty?
                    fileImage==null? null: (){
                    //todo enter code here
                    setState(() {
                      viewBoxImage = false;
                      commentsList.add(CommentItem(widget.mobile, messageController.text.toString(), '', fileImage));
                      messageController.clear();
                      _scrollController.animateTo(
                          _scrollController.position.maxScrollExtent+200,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.ease);
                      fileImage = null;
                    });
                  }: (){
                    //todo enter code here
                    setState(() {
                      viewBoxImage = false;
                      commentsList.add(CommentItem(widget.mobile, messageController.text.toString(), '', fileImage));
                      messageController.clear();
                      _scrollController.animateTo(
                          _scrollController.position.maxScrollExtent+200,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.ease);
                      fileImage = null;
                    });
                  },
                  child: Container(
                    margin: EdgeInsetsDirectional.only(
                      start: 10.w, end: 10.w, top: 10.h, bottom: 10.h
                    ),
                      width: 24.w,
                      height: 24.w,
                      child: SvgPicture.asset(ICONS+'send.svg',color: secondaryColor,)),
                ),
                prefixIcon: InkWell(
                  onTap: (){
                    //todo enter code here
                    _showPhotoLibrary();
                  },
                  child: Container(
                      margin: EdgeInsetsDirectional.only(
                          start: 10.w, end: 10.w, top: 10.h, bottom: 10.h
                      ),
                      width: 24.w,
                      height: 24.w,
                      child: SvgPicture.asset(ICONS+'image_gallery.svg',color: secondaryColor,)),
                ),
                filled: true,
                fillColor: typeMessageColor,
                hintText: getTranslated(context, "typeComment"),
                hintStyle: TextStyle(
                    fontFamily: PRIMARY_FONT_LIGHT,
                    fontSize: 16.ssp),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget imageContainer() {
    return GestureDetector(
      onTap: () {
        _showPhotoLibrary();
      },
      child: Stack(
        alignment: AlignmentDirectional.centerStart,
        children: [
          Container(
            width: 80.w,
            height: 80.w,
            margin: EdgeInsetsDirectional.only(bottom: 10.w),
            decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.all(Radius.circular(20.w)),
                image: DecorationImage(
                  image:  fileImage==null?
                  AssetImage("assets/images/color.png"):
                  FileImage(fileImage),
                  fit: BoxFit.fill,
                )),
            child: (fileImage == null)
                ? Icon(
              Icons.add,
              size: 30.w,
              color: secondaryColor,
            )
                : null,
          ),
          if (fileImage != null)
            PositionedDirectional(
              top: 0,
              start: 60,
              child: Container(
                width: 30.w,
                height: 30.w,
                decoration: BoxDecoration(color: secondaryColor, shape: BoxShape.circle),
                child: Icon(
                  Icons.mode_edit,
                  size: 15.w,
                  color: white,
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _showPhotoLibrary() async {
    getImageCrop().then((_imageFile) {
      print("getImageCrop");
        setState(() {
          if(_imageFile == null){
            viewBoxImage = false;
          }else{
            viewBoxImage = true;
          }
          fileImage = _imageFile;
        });
    });
  }
}
