import 'dart:convert';

import 'package:fastrepaire/values/colors.dart';
import 'package:fastrepaire/values/strings.dart';
import 'package:fastrepaire/values/styles.dart';
import 'package:fastrepaire/widget/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../routes/my_routes.dart';
import '../../routes/routes.dart';
import 'model/fake_phone_info.dart';

//确认订单页面
class ConfirmOrderPage extends StatefulWidget {
  //上页面传递过来的维修信息
  String repairJson;

  ConfirmOrderPage(this.repairJson);

  @override
  _ConfirmOrderPageState createState() => _ConfirmOrderPageState();
}

class _ConfirmOrderPageState extends State<ConfirmOrderPage> {
  //标记切换那个类型
  //第一是邮寄维修，第二个是上门维修，第三个是到店维修。
  int tabPos = 0;
  RepairItem repairItem;

  @override
  void initState() {
    super.initState();
    var list = List<int>();
    jsonDecode(widget.repairJson).forEach(list.add);
    final String value = Utf8Decoder().convert(list);
    debugPrint(value);
    var mapValue = json.decode(value);
    repairItem = RepairItem.fromJson(mapValue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          CommonAppBar(AppStrings.confirmOrder),
          _renderHeaderTab(),
          Expanded(
            child: _renderContent(),
          ),
          _renderBottomButton(),
        ],
      ),
    );
  }

  //顶部tab切换
  _renderHeaderTab() {
    return Container(
      height: ScreenUtil.getInstance().setWidth(30),
      margin: EdgeInsets.symmetric(
          horizontal: ScreenUtil.getInstance().setWidth(20),
          vertical: ScreenUtil.getInstance().setWidth(10)),
      child: Row(
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                          ScreenUtil.getInstance().setWidth(20)),
                      bottomLeft: Radius.circular(
                          ScreenUtil.getInstance().setWidth(20))),
                  border: Border.all(width: 1, color: AppColors.appBlue),
                  color: tabPos == 0 ? AppColors.appBlue : AppColors.white,
                ),
                child: Center(
                  child: Text(
                    AppStrings.orderType1,
                    style: tabPos == 0
                        ? AppStyles.whiteText12
                        : AppStyles.blueText12,
                  ),
                ),
              ),
              onTap: () {
                if (tabPos != 0) {
                  setState(() {
                    tabPos = 0;
                  });
                }
              },
            ),
          ),
          Expanded(
            child: GestureDetector(
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: Border(
                    top: BorderSide(
                      width: 1,
                      color: AppColors.appBlue,
                    ),
                    bottom: BorderSide(
                      width: 1,
                      color: AppColors.appBlue,
                    ),
                  ),
                  color: tabPos == 1 ? AppColors.appBlue : AppColors.white,
                ),
                child: Center(
                  child: Text(
                    AppStrings.orderType2,
                    style: tabPos == 1
                        ? AppStyles.whiteText12
                        : AppStyles.blueText12,
                  ),
                ),
              ),
              onTap: () {
                if (tabPos != 1) {
                  setState(() {
                    tabPos = 1;
                  });
                }
              },
            ),
          ),
          Expanded(
            child: GestureDetector(
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(
                          ScreenUtil.getInstance().setWidth(20)),
                      bottomRight: Radius.circular(
                          ScreenUtil.getInstance().setWidth(20))),
                  border: Border.all(width: 1, color: AppColors.appBlue),
                  color: tabPos == 2 ? AppColors.appBlue : AppColors.white,
                ),
                child: Center(
                  child: Text(
                    AppStrings.orderType3,
                    style: tabPos == 2
                        ? AppStyles.whiteText12
                        : AppStyles.blueText12,
                  ),
                ),
              ),
              onTap: () {
                if (tabPos != 2) {
                  setState(() {
                    tabPos = 2;
                  });
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  //内容
  _renderContent() {
    return ListView(
      padding: EdgeInsets.all(0),
      children: <Widget>[
        _renderContainerWidget(_renderAddressInfo()),
        _renderContainerWidget(_renderRepairInfo()),
        _renderContainerWidget(_renderServiceInfo()),
      ],
    );
  }

  //地址信息
  Widget _renderAddressInfo() {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Text(
                AppStrings.addressInfo,
                style: AppStyles.blackText14,
              ),
            ),
            GestureDetector(
              onTap: () {
                //选择地址 此处回传的value 就是选择的地址信息
                AppRoutes.router
                    .navigateTo(
                      context,
                      Routes.address +
                          "?${AppStrings.selectAddressTag}=${AppStrings.selectAddressValue}",
                    )
                    .then((value) {});
              },
              child: Row(
                children: <Widget>[
                  Text(
                    AppStrings.selectAddress,
                    style: AppStyles.greyText12,
                  ),
                  Icon(
                    Icons.navigate_next,
                    color: AppColors.appBlue,
                  ),
                ],
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: ScreenUtil.getInstance().setWidth(10)),
          child: CommonDivider(),
        ),
        Offstage(
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  AppStrings.arrangeTime,
                  style: AppStyles.blackText14,
                ),
              ),
              Text(
                AppStrings.selectTime,
                style: AppStyles.greyText12,
              ),
              Icon(
                Icons.navigate_next,
                color: AppColors.appBlue,
              ),
            ],
          ),
          offstage: tabPos == 0,
        ),
        Offstage(
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      AppStrings.sfExpress,
                      style: AppStyles.blackText14,
                    ),
                    Text(
                      AppStrings.sfExpressInfo,
                      style: AppStyles.greyText12,
                    )
                  ],
                ),
              ),
              Icon(
                Icons.remove_circle,
                color: AppColors.appBlue,
              ),
            ],
          ),
          offstage: tabPos != 0,
        ),
      ],
    );
  }

  //选择的维修条目
  _renderRepairInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          repairItem == null ? "" : repairItem.repairName ?? "",
          style: AppStyles.blackText14,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: ScreenUtil.getInstance().setWidth(10)),
          child: CommonDivider(),
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: Text(
                AppStrings.moneySymbol +
                    (repairItem == null ? "" : repairItem.price ?? ""),
                style: AppStyles.blueText14,
              ),
            ),
            Column(
              children: <Widget>[
                Text(
                  AppStrings.moneySymbol +
                      (repairItem == null ? "" : repairItem.yPrice ?? ""),
                  style: AppStyles.greyText12,
                ),
                Text(
                  repairItem == null ? "" : repairItem.period ?? "",
                  style: AppStyles.greyText12,
                ),
              ],
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: ScreenUtil.getInstance().setWidth(10)),
          child: CommonDivider(),
        ),
        Text(
          AppStrings.repairProcess,
          style: AppStyles.greyText9,
        ),
      ],
    );
  }

  //服务信息
  _renderServiceInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Offstage(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    AppStrings.repairOnTime,
                    style: AppStyles.blackText12,
                  ),
                  Text(
                    AppStrings.repairOnTimeDetail,
                    style: AppStyles.greyText10,
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: ScreenUtil.getInstance().setWidth(10)),
                child: CommonDivider(),
              ),
            ],
          ),
          offstage: tabPos != 1,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              AppStrings.infoProtected,
              style: AppStyles.blackText12,
            ),
            Text(
              AppStrings.infoProtected,
              style: AppStyles.greyText10,
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: ScreenUtil.getInstance().setWidth(10)),
          child: CommonDivider(),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              AppStrings.remark,
              style: AppStyles.blackText12,
            ),
            TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: AppStrings.remarkHint,
                hintStyle: AppStyles.greyText12,
                contentPadding: EdgeInsets.symmetric(
                  vertical: ScreenUtil.getInstance().setWidth(5),
                ),
              ),
              cursorColor: AppColors.black,
            ),
          ],
        ),
      ],
    );
  }

  _renderContainerWidget(Widget child) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10),
        color: AppColors.white,
      ),
      margin: EdgeInsets.symmetric(
        vertical: ScreenUtil.getInstance().setWidth(10),
        horizontal: ScreenUtil.getInstance().setWidth(10),
      ),
      padding: EdgeInsets.all(
        ScreenUtil.getInstance().setWidth(15),
      ),
      child: child,
    );
  }

  //底部确认
  _renderBottomButton() {
    return GestureDetector(
      child: Container(
        color: AppColors.appBlue,
        height: ScreenUtil.getInstance().setWidth(50),
        child: Center(
          child: Text(
            AppStrings.confirmOrder,
            style: AppStyles.whiteText14,
          ),
        ),
      ),
      onTap: () {
        AppRoutes.router.navigateTo(context, Routes.pay, replace: true);
      },
    );
  }
}
