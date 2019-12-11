import 'package:fastrepaire/utils/common_util.dart';
import 'package:fastrepaire/values/strings.dart';
import 'package:fastrepaire/widget/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../routes/my_routes.dart';
import '../../routes/routes.dart';
import '../../values/colors.dart';
import '../../values/styles.dart';
import 'model/fake_user_data.dart';

//手机号登录页面
class PhoneLoginPage extends StatefulWidget {
  @override
  _PhoneLoginPageState createState() => _PhoneLoginPageState();
}

class _PhoneLoginPageState extends State<PhoneLoginPage> {

  //账号
  String account;

  //密码
  String pwd;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          CommonAppBar(AppStrings.phoneLogin),
          Expanded(
            child: ListView(
              children: <Widget>[
                _renderInputWidget(AppStrings.account, AppStrings.accountHint),
                _renderInputWidget(AppStrings.pwd, AppStrings.pwdHint,isPwd: true),
                _renderRegister(),
                _renderLoginButton(),
              ],
            ),
          )
        ],
      ),
    );
  }

  //注册
  _renderRegister() {
    return GestureDetector(
      child: Container(
        height: ScreenUtil.getInstance().setWidth(20),
        margin: EdgeInsets.only(right: ScreenUtil.getInstance().setWidth(30)),
        child: Align(
          child: Text(
            AppStrings.regiesterSuggest,
            style: AppStyles.blueText12,
          ),
          alignment: Alignment.centerRight,
        ),
      ),
      onTap: () {
        AppRoutes.router.navigateTo(context, Routes.register);
      },
    );
  }

  //登录
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
            AppStrings.login,
            style: AppStyles.whiteText14,
          ),
        ),
      ),
      onTap: () {
        if(CommonUtils.isEmpty(account)){
          Fluttertoast.showToast(msg: AppStrings.accountCannotNull);
          return;
        }
        if(CommonUtils.isEmpty(account)){
          Fluttertoast.showToast(msg: AppStrings.pwdCannotNull);
          return;
        }
        Navigator.pop(context,FakeUserData(account,account,null));
      },
    );
  }

  //输入框内容
  _renderInputWidget(String prefix, String hint,{bool isPwd=false}) {
    return Container(
      decoration: BoxDecoration(
        border: new Border.all(width: 1, color: AppColors.grey),
        color: AppColors.searchWhiteBg,
        borderRadius: new BorderRadius.all(
            new Radius.circular(ScreenUtil.getInstance().setWidth(8))),
      ),
      margin: EdgeInsets.all(
        ScreenUtil.getInstance().setWidth(30),
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
                onChanged: (content){
                  if(isPwd){
                    pwd=content;
                  }else{
                    account=content;
                  }
                },
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
