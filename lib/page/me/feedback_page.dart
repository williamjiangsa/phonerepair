import 'package:fastrepaire/values/strings.dart';
import 'package:fastrepaire/widget/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../values/colors.dart';
import '../../values/styles.dart';

//意见反馈页面
class FeedbackPage extends StatefulWidget {
  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          CommonAppBar(AppStrings.feedback),
          Expanded(
            child: ListView(
              children: <Widget>[
                _renderInputWidget(),
                _renderSubmitButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //提交按鈕
  _renderSubmitButton() {
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
            AppStrings.submit,
            style: AppStyles.whiteText14,
          ),
        ),
      ),
      onTap: () {},
    );
  }

  //输入框
  _renderInputWidget() {
    return Container(
      height: ScreenUtil.getInstance().setWidth(200),
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
        child: TextField(
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: AppStrings.feedbackHint,
            hintStyle: AppStyles.greyText12,
            contentPadding: EdgeInsets.symmetric(
              vertical: ScreenUtil.getInstance().setWidth(5),
            ),
          ),
          cursorColor: AppColors.black,
          maxLines: 10,
        ),
      ),
    );
  }
}
