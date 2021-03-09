import 'package:ccc_app/constants/colors.dart';
import 'package:ccc_app/constants/constants.dart';
import 'package:ccc_app/custom_widgets/CustomText.dart';
import 'package:ccc_app/models/DrawerItem.dart';
import 'package:ccc_app/provider/LanguageProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DrawerMenu extends StatelessWidget {
  List<DrawerItem> drawerContentList = List<DrawerItem>();
  String language;

  @override
  Widget build(BuildContext context) {
    init(context);
    return Container(
      width: 300.w,
      child: Drawer(
        child: Container(
          color: primaryColor,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              SizedBox(height: 213.h,),
              for (int x = 0; x < drawerContentList.length; x++)
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                    darwerNavigate(x, context);
                  },
                  child: Padding(
                    padding: EdgeInsetsDirectional.only(
                        start: 40.w, top: 37.h, bottom: 0.0, end: 40.w),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          drawerContentList[x].icon,
                          color: iconWhite,
                          width: 20.w,
                        ),
                        SizedBox(
                          width: 16.w,
                        ),
                        CustomText(
                          drawerContentList[x].title,
                          translate: drawerContentList[x].icon!=
                              ICONS + "translate.svg",
                          fontSize: 14,
                          primaryFont: PRIMARY_FONT_MEDIUM,
                          textColor: textWhite,
                          fontWeight: FontWeight.w500,
                        )
                      ],
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }

  void init(BuildContext _context) {
    language = Provider.of<LanguagesProvider>(_context, listen: false)
        .appLocal == Locale('ar')? "ar": "en";
    drawerContentList = [
      DrawerItem(ICONS + "translate.svg", language == "ar"? "English": "العربية")
    ];
  }

  void darwerNavigate(int index, BuildContext _context) {
    switch(index){
      case 0:
        String changeLang = language == 'ar'? 'en': 'ar';
        Provider.of<LanguagesProvider>(_context, listen: false)
            .changeLanguage(_context, Locale(changeLang), changeLang, () {
          print("app language ar successfully");
          language = language == 'ar'? 'en': 'ar';
          (_context as Element).markNeedsBuild();
        });
        break;
    }
  }
}
