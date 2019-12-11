import 'package:fastrepaire/page/home/comment_list_page.dart';
import 'package:fastrepaire/page/home/confirm_page.dart';
import 'package:fastrepaire/page/home/pay_page.dart';
import 'package:fastrepaire/page/home/phone_info.dart';
import 'package:fastrepaire/page/home/select_city.dart';
import 'package:fastrepaire/page/home/select_phone.dart';
import 'package:fastrepaire/page/mainPage.dart';
import 'package:fastrepaire/page/me/feedback_page.dart';
import 'package:fastrepaire/page/me/login_page.dart';
import 'package:fastrepaire/page/me/my_address.dart';
import 'package:fastrepaire/page/me/recycle_orderlist.dart';
import 'package:fastrepaire/page/me/regiest_page.dart';
import 'package:fastrepaire/page/me/repair_orderlist.dart';
import 'package:fastrepaire/page/recycle/recycle_info_page.dart';
import 'package:fastrepaire/page/recycle/recyle_phonelist_page.dart';
import 'package:fastrepaire/values/strings.dart';
import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';

Handler rootHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return MainPage();
});
Handler citySelectHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return SelectCityPage();
});

Handler phoneSelectHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String repairItemId = params[AppStrings.repairItemId]?.first;
  String repairItemName = params[AppStrings.repairItemName]?.first;
  return SelectPhonePage(repairItemId, repairItemName);
});

Handler phoneInfoHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String repairItemId = params[AppStrings.repairItemId]?.first;
  String repairItemName = params[AppStrings.repairItemName]?.first;
  String phoneItemId = params[AppStrings.phoneItemId]?.first;
  return PhoneInfoPage(repairItemId, phoneItemId, repairItemName);
});

Handler phoneListHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String tabPosStr = params[AppStrings.tabPos]?.first;
  int tabPos = 0;
  try {
    tabPos = int.parse(tabPosStr);
  } catch (e) {}
  return RecyclePhoneListPage(
    tabPos: tabPos,
  );
});
Handler confirmOrderHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String repairJson = params[AppStrings.repairJson]?.first;
  return ConfirmOrderPage(repairJson);
});
Handler homeAllCommentsHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return CommonListPage();
});
Handler phoneLoginHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return PhoneLoginPage();
});
Handler regiesterHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return RegisterPage();
});
Handler payHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return PayPage();
});
Handler addressListHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String addressSelect = params[AppStrings.selectAddressTag]?.first;
  return MyAddressPage(select: addressSelect,);
});
Handler repairOrderHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return RepairOrderList();
});
Handler recycleOrderHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return RecycleOrderList();
});
Handler feedBackHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return FeedbackPage();
});
Handler recycleInfoHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return RecycleInfoPage();
});
