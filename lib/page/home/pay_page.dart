import 'package:fastrepaire/values/strings.dart';
import 'package:fastrepaire/widget/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../values/colors.dart';
import '../../values/styles.dart';
import 'model/fake_pay_data.dart';

//付款页面
class PayPage extends StatefulWidget {
  @override
  _PayPageState createState() => _PayPageState();
}

class _PayPageState extends State<PayPage> {
  FakePayData payData;

  @override
  void initState() {
    super.initState();
    payData = FakePayData();
    payData.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          CommonAppBar(AppStrings.pay),
          _renderPayInfo(),
          _renderPayButton(),
        ],
      ),
    );
  }

  //付款明细
  _renderPayInfo() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10),
        color: AppColors.white,
      ),
      width: double.infinity,
      margin: EdgeInsets.all(ScreenUtil.getInstance().setWidth(20)),
      padding: EdgeInsets.all(ScreenUtil.getInstance().setWidth(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            payData.payName ?? "",
            style: AppStyles.blackText14,
          ),
          Padding(
            child: Text(
              payData.payContent ?? "",
              style: AppStyles.greyText12,
            ),
            padding: EdgeInsets.symmetric(vertical: ScreenUtil.getInstance().setWidth(10)),
          ),
          Text(
            AppStrings.moneySymbol+" "+(payData.payAmount ?? "").toString(),
            style: AppStyles.blackText14,
          ),
        ],
      ),
    );
  }

  //付款按钮
  _renderPayButton() {
    return GestureDetector(
      child: Container(
        height: ScreenUtil.getInstance().setWidth(40),
        margin: EdgeInsets.all(ScreenUtil.getInstance().setWidth(30)),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
          color: AppColors.appBlue,
        ),
        child: Center(
          child: Text(
            AppStrings.payNow,
            style: AppStyles.whiteText14,
          ),
        ),
      ),
      onTap: () {},
    );
  }
}
