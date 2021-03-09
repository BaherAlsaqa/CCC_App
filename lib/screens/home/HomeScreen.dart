import 'package:ccc_app/constants/colors.dart';
import 'package:ccc_app/constants/constants.dart';
import 'package:ccc_app/custom_widgets/CustomAppBar.dart';
import 'package:ccc_app/custom_widgets/CustomText.dart';
import 'package:ccc_app/screens/home/pages/AllOrdersTab.dart';
import 'package:ccc_app/screens/home/pages/CompleteOrdersTab.dart';
import 'package:ccc_app/singleton/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'DrawerMenu.dart';

class HomeScreen extends StatefulWidget {
  int index;
  String mobile;

  HomeScreen(this.index, this.mobile);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  List<Widget> children;
  List<Widget> iconsTabs;
  List<Widget> selectedIconsTabs;
  List<String> iconsName;
  List<String> titles;
  int _cIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    iconsName = [
      "assets/icons/orders.svg",
      "assets/icons/orders.svg",
    ];

    titles = [
      "allOrders",
      "completedOrders",
    ];

    iconsTabs = [
      for(int i=0; i<iconsName.length; i++)
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(iconsName[i], color: white, width: 24.w, height: 24.w,),
          SizedBox(width: 5.w,),
          Padding(
            padding: EdgeInsetsDirectional.only(
              start: 0.w, end: 0.w, top: 5.h, bottom: 0.h
            ),
            child: CustomText(
              titles[i],
              textColor: textWhite,
              primaryFont: PRIMARY_FONT_LIGHT,
              fontSize: 14,
            ),
          )
        ],
      ),
    ];
    selectedIconsTabs = [
      for(int i=0; i<iconsName.length; i++)
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(iconsName[i], color: secondaryColor, width: 24.w, height: 24.w,),
          SizedBox(width: 5.w,),
          Padding(
            padding: EdgeInsetsDirectional.only(
              start: 0.w, end: 0.w, top: 5.h, bottom: 0.h
            ),
            child: CustomText(
              titles[i],
              textColor: secondaryColor,
              primaryFont: PRIMARY_FONT_LIGHT,
              fontSize: 14,
            ),
          )
        ],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    systemChrome(darkMode: true, navBrightness: Brightness.dark,
        navBarColor: primaryColor);

    children = [
      AllOrdersTab(widget.mobile),
      CompleteOrdersTab(widget.mobile),
    ];

    return WillPopScope(
        onWillPop: onBack,
        child: Container(
          color: primaryColor,
          child: SafeArea(
            child: Scaffold(
              backgroundColor: white,
              appBar: CustomAppBar(
                primaryColor,
                home: true,
                title: 'CCC',
                showTitle: true,
                customTitle: true,
              ),
              drawer: DrawerMenu(),
              body: children[widget.index],
              bottomNavigationBar: myCustomBottomNavigation(),
              ),
            ),
          ),
        );
  }
  void onTabTapped(int index) {
    setState(() {
      widget.index = index;
    });
  }
  Widget myCustomBottomNavigation() {
    return Container(
      padding: EdgeInsets.only(left: 0.02.sw, right: 0.02.sw,top: 2.h),
      height: 55.h,
      width: 1.sw,
      decoration: BoxDecoration(
        color: primaryColor,
      ),
      child: BottomNavigationBar(
        selectedFontSize: 0,
        onTap: onTabTapped,
        elevation: 0,
        currentIndex: widget.index,
        backgroundColor: primaryColor,
        // type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
            icon: iconsTabs[0],
            label: 'All orders',
            activeIcon: myActiveIcon(selectedIconsTabs[0]),
          ),
          BottomNavigationBarItem(
            icon: iconsTabs[1],
            label: 'Complete orders',
            activeIcon: myActiveIcon(selectedIconsTabs[1]),
          ),
        ],
      ),
    );
  }
  Widget myActiveIcon(Widget iconTap) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 11.5.h,),
        iconTap,
        SizedBox(height: 12.0.h,),
        Container(
          width: 50.w,
          height: 3.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadiusDirectional.only(
              topStart: Radius.circular(25.sp),
              topEnd: Radius.circular(25.sp),
              bottomStart: Radius.circular(0.sp),
              bottomEnd: Radius.circular(0.sp)
           ),
            color: secondaryColor,
          ),
        )
      ],
    );
  }

  void _incrementTab(index) {
    setState(() {
      _cIndex = index;
    });
  }
  Future<bool> onBack() {
    return widget.index > 0
        ? Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (_) => HomeScreen(0, widget.mobile),
            )) ??
        false
        : SystemNavigator.pop();
  }

}


