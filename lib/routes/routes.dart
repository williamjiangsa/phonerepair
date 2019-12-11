import './routes_handler.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

class Routes {
  //主页面
  static String root = '/';

  //城市选择
  static String citySelect = '/city_select';

  //选择机型页面 由首页 维修项目跳转
  static String phoneSelect = '/phone_select';

  //设备信息 由首页--维修项目--跳转而来
  static String phoneInfo = '/phone_info';

  //机型页面 回收跳转 选择所有机型页面
  static String phoneList = '/phone_list';

  //确认订单页面
  static String orderConfirm = '/order_confirm';

  //首页所有评论
  static String homeAllComments = '/home_all_comments';

  //手机号登录
  static String phoneLogin = '/phone_login';

  //注册
  static String register = '/register';

  //付款页面
  static String pay = '/pay';

  //地址列表頁面
  static String address = '/address';

  //维修订单
  static String repairOrder = '/repair_order';

  //回收订单
  static String recycleOrder = '/recycle_order';

  //意見反饋
  static String feedback = '/feedback';

  //回收详情
  static String recycleInfo = '/recycleInfo';

  static void configureRoutes(Router router) {
    router.notFoundHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print("ROUTE WAS NOT FOUND !!!");
      return null;
    });

    router.define(
      root,
      handler: rootHandler,
      transitionType: TransitionType.inFromRight,
    );
    router.define(
      citySelect,
      handler: citySelectHandler,
      transitionType: TransitionType.inFromRight,
    );
    router.define(
      phoneSelect,
      handler: phoneSelectHandler,
      transitionType: TransitionType.inFromRight,
    );
    router.define(
      phoneInfo,
      handler: phoneInfoHandler,
      transitionType: TransitionType.inFromRight,
    );
    router.define(
      phoneList,
      handler: phoneListHandler,
      transitionType: TransitionType.inFromRight,
    );
    router.define(
      orderConfirm,
      handler: confirmOrderHandler,
      transitionType: TransitionType.inFromRight,
    );
    router.define(
      homeAllComments,
      handler: homeAllCommentsHandler,
      transitionType: TransitionType.inFromRight,
    );
    router.define(
      phoneLogin,
      handler: phoneLoginHandler,
      transitionType: TransitionType.inFromRight,
    );
    router.define(
      register,
      handler: regiesterHandler,
      transitionType: TransitionType.inFromRight,
    );
    router.define(
      pay,
      handler: payHandler,
      transitionType: TransitionType.inFromRight,
    );
    router.define(
      address,
      handler: addressListHandler,
      transitionType: TransitionType.inFromRight,
    );
    router.define(
      repairOrder,
      handler: repairOrderHandler,
      transitionType: TransitionType.inFromRight,
    );
    router.define(
      recycleOrder,
      handler: recycleOrderHandler,
      transitionType: TransitionType.inFromRight,
    );
    router.define(
      feedback,
      handler: feedBackHandler,
      transitionType: TransitionType.inFromRight,
    );
    router.define(
      recycleInfo,
      handler: recycleInfoHandler,
      transitionType: TransitionType.inFromRight,
    );
  }
}
