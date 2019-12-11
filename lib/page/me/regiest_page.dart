import 'package:fastrepaire/values/strings.dart';
import 'package:fastrepaire/widget/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../values/colors.dart';
import '../../values/styles.dart';

//注册页面
class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          CommonAppBar(AppStrings.register),
          Expanded(
            child: ListView(
              children: <Widget>[
                _renderInputWidget(AppStrings.account, AppStrings.accountHint),
                _renderInputWidget(AppStrings.pwd, AppStrings.pwdHint,
                    isPwd: true),
                _renderInputWidget(
                    AppStrings.confirmPwd, AppStrings.confirmPwdHint,
                    isPwd: true),
                _renderLoginButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //注册
  _renderLoginButton() {
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
            AppStrings.register,
            style: AppStyles.whiteText14,
          ),
        ),
      ),
      onTap: () {},
    );
  }

  //输入框内容
  _renderInputWidget(String prefix, String hint, {bool isPwd = false}) {
    return Container(
      decoration: BoxDecoration(
        border: new Border.all(width: 1, color: AppColors.grey),
        color: AppColors.searchWhiteBg,
        borderRadius: new BorderRadius.all(
            new Radius.circular(ScreenUtil.getInstance().setWidth(8))),
      ),
      margin: EdgeInsets.symmetric(
        horizontal: ScreenUtil.getInstance().setWidth(30),
        vertical: ScreenUtil.getInstance().setWidth(15),
      ),
      child: Padding(
        padding: EdgeInsets.all(ScreenUtil.getInstance().setWidth(10)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              prefix,
              style: AppStyles.blackText12,
            ),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: hint,
                  hintStyle: AppStyles.greyText12,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: ScreenUtil.getInstance().setWidth(5),
                  ),
                ),
                cursorColor: AppColors.black,
                obscureText: isPwd,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
