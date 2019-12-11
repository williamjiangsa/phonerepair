library basicnetservice;


import 'package:fastrepaire/widget/dialog_param.dart';
import 'package:fastrepaire/widget/loading_dialog.dart';
import 'package:flutter/widgets.dart';

import '../net_constant.dart';
import 'net_config.dart';
import 'net_service.dart';

class AppNetService extends NetService {
  AppNetService();

  @override
  request(String url,
      {Method method,
      Map<String, dynamic> params,
      var file,
      String fileName,
      String fileSavePath,
      BuildContext context,
      bool showLoad = true}) async {
    /// 传参进行统一处理, 加上基本参数
    Map<String, dynamic> basicParam = await getBasicParam();
    if (params != null) {
      basicParam.addAll(params);
    }
    ShowParam showParam = new ShowParam(
        show: showLoad, barrierDismissible: false, showBackground: false);
    LoadingDialogUtil.showLoadingDialog(context, showParam);
    ResultData resultData = await super.request(url,
        method: method,
        params: basicParam,
        file: file,
        fileName: fileName,
        fileSavePath: fileSavePath);
    showParam.pop();

    if (NetConfig.CODE_NOT_LOGIN == resultData.code && context != null) {
    }

    return resultData;
  }

  @override
  getBasicUrl() {
    return NetConstant.BASE_URL;
  }

  @override
  getHeaders() async {
//    debugPrint(AppConstantCache.token);
    return null;
  }

  Future<Map<String, dynamic>> getBasicParam() async {
    Map<String, dynamic> basicParam = {};
    return basicParam;
  }
}
