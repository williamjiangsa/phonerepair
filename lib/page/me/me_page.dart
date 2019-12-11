import 'package:fastrepaire/routes/my_routes.dart';
import 'package:fastrepaire/routes/routes.dart';
import 'package:fastrepaire/values/colors.dart';
import 'package:fastrepaire/values/strings.dart';
import 'package:fastrepaire/values/styles.dart';
import 'package:fastrepaire/widget/common_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'model/fake_user_data.dart';

//个人中心模块
class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> with AutomaticKeepAliveClientMixin {
  FakeUserData userData;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Column(
        children: <Widget>[
          _renderHeader(),
          _rendeCommonItem("images/order.png", AppStrings.order, () {
            _toNextPage(Routes.repairOrder);
          }),
          _rendeCommonItem("images/recycle.png", AppStrings.orderRecycle, () {
            _toNextPage(Routes.recycleOrder);
          }),
          _rendeCommonItem("images/address.png", AppStrings.address, () {
            _toNextPage(Routes.address);
          }),
          _rendeCommonItem("images/feedback.png", AppStrings.feedback, () {
            _toNextPage(Routes.feedback);
          }),
          _rendeCommonItem("images/feedback.png", AppStrings.feedback, () {
            _toNextPage(Routes.feedback);
          }),
          _rendeCommonItem("images/setting.png", AppStrings.settings, null),
          Offstage(
            child: _rendeCommonItem("images/logout.png", AppStrings.logout, () {
              _showLogoutDialog();
            }),
            offstage: userData == null,
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog() {
    showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(AppStrings.logout),
            content: Text(AppStrings.logoutConfirmTips),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text(AppStrings.cancel),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              CupertinoDialogAction(
                child: Text(AppStrings.confirm),
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    userData = null;
                  });
                },
              ),
            ],
          );
        });
  }

  void _toNextPage(String page, {bool isReplace = false}) {
    AppRoutes.router.navigateTo(context, page, replace: isReplace);
  }

  //头部 头像 昵称 等
  _renderHeader() {
    return Container(
      height: ScreenUtil.getInstance().setWidth(200),
      color: AppColors.appDarkBlue,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Row(
          children: <Widget>[
            Padding(
              child: ClipOval(
                child: FadeInImage.assetNetwork(
                  placeholder: AppStrings.defaultPic,
                  image: (userData == null || userData.userAvatar == null)
                      ? AppStrings.demoAvatar
                      : userData.userAvatar ?? "",
                  fit: BoxFit.cover,
                  width: ScreenUtil.getInstance().setWidth(60),
                  height: ScreenUtil.getInstance().setWidth(60),
                ),
              ),
              padding: EdgeInsets.all(ScreenUtil.getInstance().setWidth(20)),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        userData == null
                            ? AppStrings.userName
                            : userData.userName ?? "",
                        style: AppStyles.whiteText14,
                      ),
                      Offstage(
                        child: GestureDetector(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    ScreenUtil.getInstance().setWidth(5)),
                            child: Image.asset(
                              "images/modify.png",
                              width: ScreenUtil.getInstance().setWidth(15),
                              height: ScreenUtil.getInstance().setWidth(15),
                            ),
                          ),
                          onTap: () {
                            _toModifyPage();
                          },
                        ),
                        offstage: userData == null,
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: ScreenUtil.getInstance().setWidth(10)),
                    child: Text(
                      userData == null
                          ? AppStrings.userPhone
                          : userData.userPhone ?? "",
                      style: AppStyles.whiteText12,
                    ),
                  ),
                ],
              ),
            ),
            Offstage(
              offstage: userData != null,
              child: Container(
                margin: EdgeInsets.all(ScreenUtil.getInstance().setWidth(10)),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(
                      ScreenUtil.getInstance().setWidth(25)),
                  border: Border.all(width: 1, color: AppColors.white),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil.getInstance().setWidth(25),
                    vertical: ScreenUtil.getInstance().setWidth(5),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      AppRoutes.router
                          .navigateTo(context, Routes.phoneLogin)
                          .then((user) {
                        if (user != null && user is FakeUserData) {
                          setState(() {
                            userData = user;
                          });
                        }
                      });
                    },
                    child: Text(
                      AppStrings.login,
                      style: AppStyles.whiteText12,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //订单 地址 反馈 个人资料 设置
  _rendeCommonItem(String imgUrl, String text, VoidCallback callback) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: ScreenUtil.getInstance().setWidth(20)),
      child: Column(
        children: <Widget>[
          GestureDetector(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: ScreenUtil.getInstance().setWidth(8)),
              child: Row(
                children: <Widget>[
                  Image.asset(
                    imgUrl,
                    width: ScreenUtil.getInstance().setWidth(20),
                    height: ScreenUtil.getInstance().setWidth(20),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil.getInstance().setWidth(10)),
                      child: Text(
                        text,
                        style: AppStyles.blackText12,
                      ),
                    ),
                  ),
                  Icon(Icons.navigate_next),
                ],
              ),
            ),
            onTap: callback,
          ),
          CommonDivider(),
        ],
      ),
    );
  }

  //去修改頁面
  void _toModifyPage() {}

  @override
  bool get wantKeepAlive => true;
}
