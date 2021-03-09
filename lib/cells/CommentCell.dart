import 'package:ccc_app/constants/colors.dart';
import 'package:ccc_app/constants/constants.dart';
import 'package:ccc_app/custom_widgets/CustomText.dart';
import 'package:ccc_app/models/CommentItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class CommentCell extends StatelessWidget {
  CommentItem commentItem;
  CommentCell(this.commentItem);
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        width: 1.0.sw,
        margin: EdgeInsetsDirectional.only(
          start: 0.w, end: 0.w, top: 0.h, bottom: 5.h
        ),
        padding: EdgeInsetsDirectional.only(
          start: 15.w, end: 15.w, top: 15.h, bottom: 15.h
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.only(
            topStart: Radius.circular(15.sp),
            topEnd: Radius.circular(15.sp),
            bottomStart: Radius.circular(15.sp),
            bottomEnd: Radius.circular(15.sp)
         ),
          color: typeMessageColor.withOpacity(0.5.sp),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              commentItem.name,
              translate: false,
              textColor: primaryColor,
              primaryFont: PRIMARY_FONT_MEDIUM,
              fontSize: 16,
            ),
            SizedBox(height: 5.h,),
            CustomText(
              commentItem.content,
              translate: false,
              textColor: textGray,
              primaryFont: PRIMARY_FONT_LIGHT,
              fontSize: 14,
              paragraph: true,
            ),
            if(commentItem.image.isNotEmpty)
              SizedBox(height: 5.h,),
            if(commentItem.image.isNotEmpty)
              Image.asset(IMAGES+commentItem.image, width: 100.w, height: 100.h,),
            if(commentItem.imageGallery!=null)
              Image.file(commentItem.imageGallery, width: 100.w, height: 100.h,),
          ],
        ),
      ),
    );
  }
}
