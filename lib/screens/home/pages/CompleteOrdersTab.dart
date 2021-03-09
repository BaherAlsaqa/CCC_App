import 'package:ccc_app/cells/OrderCell.dart';
import 'package:ccc_app/constants/colors.dart';
import 'package:ccc_app/constants/constants.dart';
import 'package:ccc_app/models/OrderModel.dart';
import 'package:ccc_app/utils/language.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CompleteOrdersTab extends StatefulWidget {
  String mobile;
  CompleteOrdersTab(this.mobile);

  @override
  _CompleteOrdersTabState createState() => _CompleteOrdersTabState();
}

class _CompleteOrdersTabState extends State<CompleteOrdersTab> {
  TextEditingController searchController = TextEditingController();
  List<OrderModel> ordersList = [];
  int index;
  int _cIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (int i = 0; i < 7; i++) {
      ordersList.add(OrderModel(
          id: "WO111" + i.toString(),
          progress: "100",
          region: "C" + i.toString(),
          startDate: (i+1).toString()+"/"+(i+2).toString()+"/2021",
          endDate: (i+2).toString()+"/"+(i+4).toString()+"/2021",
          details:
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: white,
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomPadding: false,
          backgroundColor: white,
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsetsDirectional.only(start: 14.0.w, end: 14.0.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 10.0.w,
                  ),
                  ListView.builder(
                      padding: EdgeInsetsDirectional.only(bottom: 20.0.h),
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: ordersList.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return OrderCell(
                          widget.mobile,
                          orderModel: ordersList[index],
                        );
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
