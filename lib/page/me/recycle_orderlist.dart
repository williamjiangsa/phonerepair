import 'package:fastrepaire/values/colors.dart';
import 'package:fastrepaire/values/strings.dart';
import 'package:fastrepaire/values/styles.dart';
import 'package:fastrepaire/widget/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'model/fake_order_list.dart';

//回收订单列表
class RecycleOrderList extends StatefulWidget {
  @override
  _RecycleOrderListState createState() => _RecycleOrderListState();
}

class _RecycleOrderListState extends State<RecycleOrderList> {
  //回收订单data
  FakeOrderList recycleData;

  @override
  void initState() {
    super.initState();
    recycleData = FakeOrderList();
    recycleData.initRecycles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          CommonAppBar(AppStrings.orderRecycle),
          Expanded(
            child: _renderOrderList(),
          ),
        ],
      ),
    );
  }

  //订单list
  _renderOrderList() {
    return ListView.builder(
      padding: EdgeInsets.all(ScreenUtil.getInstance().setWidth(20)),
      itemBuilder: (context, index) {
        Order order = recycleData.orderList[index];
        return GestureDetector(
          child: Container(
            margin: EdgeInsets.symmetric(
                vertical: ScreenUtil.getInstance().setWidth(15)),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10),
              color: AppColors.white,
            ),
            child: Column(
              children: <Widget>[
                Padding(
                  padding:
                      EdgeInsets.all(ScreenUtil.getInstance().setWidth(10)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              AppStrings.orderNoTag + order.orderNo ?? "",
                              style: AppStyles.blackText12,
                            ),
                            Padding(
                              child: Text(
                                (order.orderPhoneName ?? "") +
                                    " " +
                                    (order.orderContent ?? ""),
                                style: AppStyles.greyText12,
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical:
                                      ScreenUtil.getInstance().setWidth(10)),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  AppStrings.moneySymbol + order.orderAmount ??
                                      "",
                                  style: AppStyles.blueText14,
                                ),
                                Text(
                                  order.orderDate ?? "",
                                  style: AppStyles.greyText12,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          onTap: () {},
        );
      },
      itemCount: recycleData.orderList.length,
    );
  }
}
