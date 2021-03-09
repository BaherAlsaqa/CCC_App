import 'package:ccc_app/constants/colors.dart';
import 'package:ccc_app/constants/constants.dart';
import 'package:ccc_app/singleton/dio.dart';
import 'package:ccc_app/utils/language.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  bool back;
  String title;
  Color backColor;
  bool showTitle;
  bool customTitle;
  bool home;
  Function onBack;
  TabController tabController;
  List<String> listOfTabs;
  List<Widget> tabTitle;

  CustomAppBar(this.backColor,
      {this.back = false,
      this.title,
      this.showTitle = true,
      this.customTitle = false,
      this.home = false,
      this.onBack,
      this.tabController,
      this.listOfTabs,
      this.tabTitle});

  double toolBarHeight = 150;

  @override
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(tabController!=null? !home? toolBarHeight-50.h: toolBarHeight.h: kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {

  @override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return AppBar(
          title: Text(
            widget.showTitle
                ? widget.customTitle
                    ? widget.title
                    : getTranslated(context, widget.title)
                : "",
            style: TextStyle(
                color: white,
                fontSize: 22.ssp,
                fontFamily: PRIMARY_FONT_MEDIUM),
          ),
          leading: widget.home
              ? IconButton(
                  icon: SvgPicture.asset(ICONS + "menu_ic.svg", color: white,
                  width: 22.w,),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  })
              : widget.back
                  ? Container(
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: IconButton(
                            onPressed: () {
                              systemChrome(darkMode: true, navBrightness: Brightness.dark,
                                  navBarColor: primaryColor);
                              widget.onBack();
                              Navigator.pop(context);
                            },
                            icon: SvgPicture.asset(
                              ICONS + "back_arrow.svg",
                              matchTextDirection: false,
                              color: white,
                              width: 10.w,
                            )),
                      ),
                    )
                  : Container(
                      width: 0.0.w,
                      height: 0.0.h,
                    ),
          automaticallyImplyLeading: false,
          centerTitle: true,
          actions: [
            if (widget.home)
              IconButton(
                  onPressed: () {
                    //todo //enter code here
                    showAlertString(
                        context,
                        SUCCESS,
                        'dataHasBeenUploaded',
                        3, fromSearch: true, onDone: (){

                    });
                  },
                  icon: SvgPicture.asset(ICONS + "upload.svg", color: white, width: 24.w,)),
          ],
          backgroundColor: widget.backColor,
          elevation: 0,
          bottom: widget.tabController!=null? AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Padding(
              padding: EdgeInsetsDirectional.only(
                start: 0.w, end: 0.w, top: 10.h, bottom: 0.h
              ),
              child: TabBar(
                // physics: BouncingScrollPhysics(),
                // indicatorSize: TabBarIndicatorSize.label,
                labelPadding: EdgeInsetsDirectional.zero,
                isScrollable: true,
                labelStyle: TextStyle(
                  fontSize: 16.0.ssp,
                  fontFamily: PRIMARY_FONT_LIGHT,
                  color: white,
                ),
                unselectedLabelColor: white,
                unselectedLabelStyle: TextStyle(
                  fontSize: 16.0.ssp,
                  fontFamily: PRIMARY_FONT_LIGHT,
                  color: white,
                ),
                indicatorColor: Colors.transparent,
                indicator: BoxDecoration(
                    color: primaryColor,
                    border: Border.all(color: Colors.transparent, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(14.0.w))),
                controller: widget.tabController,
                labelColor: secondaryColor,
                tabs: [
                  for (int i = 0; i < widget.tabTitle.length; i++)
                    Container(
                      width: 0.5.sw,
                      height: 37.h,
                      child: Tab(
                        child: widget.tabTitle[i],
                      ),
                    ),
                ],
              ),
            ),
          ): null
        );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // widget.tabController.dispose();
  }
}
