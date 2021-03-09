import 'dart:ui';

import 'package:ccc_app/constants/colors.dart';
import 'package:ccc_app/constants/constants.dart';
import 'package:ccc_app/custom_widgets/CustomAppBar.dart';
import 'package:ccc_app/custom_widgets/CustomText.dart';
import 'package:ccc_app/models/OrderModel.dart';
import 'package:ccc_app/models/WorkDescriptionItem.dart';
import 'package:ccc_app/singleton/dio.dart';
import 'package:ccc_app/utils/language.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'DescriptionPage.dart';
import 'HeaderPage.dart';

class OrderDetailsScreen extends StatefulWidget {
  OrderModel orderModel;
  String mobile;
  OrderDetailsScreen(this.orderModel, this.mobile);

  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen>
    with SingleTickerProviderStateMixin {
  List<Widget> tabTitle = [];
  List<String> listOfTabs = [];
  TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    prepareList();
    _tabController = new TabController(vsync: this, length: listOfTabs.length);
  }

  @override
  Widget build(BuildContext context) {
    systemChrome(
        darkMode: true, navBrightness: Brightness.light, navBarColor: white);
    return Container(
      color: primaryColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: white,
          appBar: CustomAppBar(
            primaryColor,
            back: true,
            title: 'orderDetails',
            tabController: _tabController,
            listOfTabs: listOfTabs,
            tabTitle: tabTitle,
            onBack: () {},
          ),
          body: TabBarView(controller: _tabController, children: [
            for (int i = 0; i < tabTitle.length; i++)
              i == 0 ? HeaderPage(widget.orderModel, widget.mobile) :
              DescriptionPage(widget.orderModel)
          ]),
        ),
      ),
    );
  }

  void prepareList() {
    listOfTabs.add('Header');
    listOfTabs.add('Description');

    prepareTabs();
  }

  void prepareTabs() {
    listOfTabs.forEach((element) {
      tabTitle.add(Text(
        element,
        textAlign: TextAlign.center,
      ));
    });
  }
}
