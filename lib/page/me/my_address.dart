import 'dart:convert';

import 'package:fastrepaire/routes/my_routes.dart';
import 'package:fastrepaire/values/colors.dart';
import 'package:fastrepaire/values/strings.dart';
import 'package:fastrepaire/values/styles.dart';
import 'package:fastrepaire/widget/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fastrepaire/net/manager/app_api.dart';
import 'package:fastrepaire/net/manager/result_data.dart';
import 'package:fastrepaire/net/net_constant.dart';
import 'package:fastrepaire/routes/routes.dart';

import 'model/fake_address_list.dart';

class MyAddressPage extends StatefulWidget {
  //标记是否是选择地址  下单时候 传过来1 即是需要带回去的
  final String select;

  MyAddressPage({this.select});

  @override
  _MyAddressPageState createState() => _MyAddressPageState();
}

class _MyAddressPageState extends State<MyAddressPage> {
  FakeAddressList addressList;

  @override
  void initState() {
    super.initState();
    addressList = FakeAddressList();
    addressList.init();
//    _getAddressList();
  }

  //获取地址列表信息
  Future<void> _getAddressList() async {
    ResultData resultData = await AppApi.getInstance().getDataByGet(
      context,
      NetConstant.BASE_URL,
    );
    if (resultData.isSuccess()) {
//      addressList.convertAddress();
      setState(() {
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          CommonAppBar(AppStrings.myAddress),
          CommonDivider(),
          Expanded(
            child: _renderAddressList(),
          ),
          _renderAddAddressButton(),
        ],
      ),
    );
  }

  //添加地址按钮
  _renderAddAddressButton() {
    return GestureDetector(
      child: Container(
        height: ScreenUtil.getInstance().setWidth(40),
        margin: EdgeInsets.all(ScreenUtil.getInstance().setWidth(20)),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
          color: AppColors.appBlue,
        ),
        child: Center(
          child: Text(
            AppStrings.addNewAddress,
            style: AppStyles.whiteText14,
          ),
        ),
      ),
      onTap: () {
//        AppRoutes.router.navigateTo(context, Routes.addAddress).then((value) {
//          if (value == 0) {
//            _getAddressList();
//          }
//        });
      },
    );
  }

  //地址列表list
  _renderAddressList() {
    return ListView.builder(
      padding: EdgeInsets.all(ScreenUtil.getInstance().setWidth(20)),
      itemBuilder: (context, index) {
        Address address = addressList.addressList[index];
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
                              (address.receiverName ?? "") +
                                  " " +
                                  (address.receiverPhone ?? ""),
                              style: AppStyles.blackText12,
                            ),
                            Padding(
                              child: Text(
                                address.address ?? "",
                                style: AppStyles.greyText12,
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical:
                                      ScreenUtil.getInstance().setWidth(10)),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        child: Text(
                          "编辑",
                          style: AppStyles.greyText12,
                        ),
                        onTap: () {
//                        String jsonString = json.encode(address.toJson());
//                        var jsons =
//                            jsonEncode(Utf8Encoder().convert(jsonString));
//                        AppRoutes.router
//                            .navigateTo(context,
//                                Routes.edit_address + "?addressJson=$jsons")
//                            .then((value) {
//                          if (value == 0) {
//                            _getAddressList();
//                          }
//                        });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          onTap: () {
            //选择地址时候 回传回去 address对象
            if (widget.select == AppStrings.selectAddressValue) {
              Navigator.of(context).pop(address);
            }
          },
        );
      },
      itemCount: addressList.addressList.length,
    );
  }
}
