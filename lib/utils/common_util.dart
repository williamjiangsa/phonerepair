import 'package:fluttertoast/fluttertoast.dart';

class CommonUtils {
  //吐司  默认中心
  static void showToast(String msg,
      {ToastGravity gravity = ToastGravity.CENTER}) {
    if (msg != null && msg != "") {
      Fluttertoast.showToast(msg: msg, gravity: gravity);
    }
  }

  //判断为空
  static bool isEmpty(String text) {
    return text == null || text == "";
  }
}
