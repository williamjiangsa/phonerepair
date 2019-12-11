import 'package:flutter/widgets.dart';
import 'package:fastrepaire/net/manager/result_data.dart';

import 'app_net_service.dart';

class AppApi extends AppNetService {
  AppApi._();

  static AppApi _instance;

  static AppApi getInstance() {
    if (_instance == null) {
      _instance = AppApi._();
    }
    return _instance;
  }

  Future<ResultData> getDataByGet(BuildContext context, String path,
      {Map<String, dynamic> params, bool showLoad = false}) async {
    Map<String, dynamic> param = {};
    ResultData resultData = await get(
      path,
      params: param,
      context: context,
      showLoad: showLoad,
    );
    resultData.toast();
    return resultData;
  }

  Future<ResultData> getDataByPost(BuildContext context, String path,
      {Map<String, dynamic> params, bool showLoad = false}) async {
    ResultData resultData = await post(
      path,
      params: params,
      context: context,
      showLoad: showLoad,
    );
    resultData.toast();
    return resultData;
  }
}
