import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dialog_param.dart';

// ignore: must_be_immutable
class LoadingDialog extends Dialog {
  BuildContext context;
  ShowParam showParam;

  LoadingDialog({Key key, this.showParam}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    this.context = context;
    this.showParam.context = context;
    return new Material(
      //创建透明层
      type: MaterialType.transparency, //透明类型
      child: new Center(
        //保证控件居中效果
        child: new SizedBox(
          width: 100.0,
          height: 100.0,
          child: new Container(
            decoration: ShapeDecoration(
              color: showParam.showBackground
                  ? Color(0xffffffff)
                  : Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
              ),
            ),
            child: CupertinoActivityIndicator(
              radius: 15,
            ),
          ),
        ),
      ),
    );
  }

  static Future<void> showLoadingDialog(BuildContext context, ShowParam param) {
    bool show = param?.show;
    if (show == null || !show) return Future.value();
    return showDialog<Null>(
        context: context, //BuildContext对象
        barrierDismissible: param.barrierDismissible,
        builder: (BuildContext context) {
          LoadingDialog dialog = new LoadingDialog(
            showParam: param,
          );
          return WillPopScope(
            child: dialog,
            onWillPop: () async {
              if (param.barrierDismissible) {
                param.dispose = true;
              }
              return Future.value(param.barrierDismissible);
            },
          );
        });
  }
}

class LoadingTextDialog extends Dialog {
  final String text;
  final ShowParam showParam;

  LoadingTextDialog({Key key, this.text, this.showParam})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    this.showParam.context = context;
    return new Material(
      //创建透明层
      type: MaterialType.transparency, //透明类型
      child: new Center(
        //保证控件居中效果
        child: new SizedBox(
          width: 120.0,
          height: 120.0,
          child: new Container(
            decoration: ShapeDecoration(
              color: Color(0xffffffff),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
              ),
            ),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CupertinoActivityIndicator(
                  radius: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20.0,
                  ),
                  child: new Text(
                    text,
                    style: new TextStyle(fontSize: 12.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Future<void> showLoadingDialog(BuildContext context, ShowParam param) {
    if (param.show == null) return null;
    if (!param.show) return null;
    return showDialog<Null>(
        context: context, //BuildContext对象
        barrierDismissible: param.barrierDismissible,
        builder: (BuildContext context) {
          LoadingTextDialog dialog = new LoadingTextDialog(
            //调用对话框
            text: param.text ?? '加载中...',
            showParam: param,
          );
          return WillPopScope(
            child: dialog,
            onWillPop: () async {
              if (param.barrierDismissible == true) {
                param.dispose = true;
              }
              return Future.value(param.barrierDismissible);
            },
          );
        });
  }
}

class LoadingDialogUtil {
  static Future<void> showLoadingDialog(BuildContext context, ShowParam param) {
    bool show = param?.show;
    if (show == null || !show) return Future.value();
    return showDialog<Null>(
        context: context, //BuildContext对象
        barrierDismissible: param.barrierDismissible,
        builder: (BuildContext context) {
          LoadingDialog dialog = new LoadingDialog(
            showParam: param,
          );
          return WillPopScope(
            child: dialog,
            onWillPop: () async {
              if (param.barrierDismissible) {
                param.dispose = true;
              }
              return Future.value(param.barrierDismissible);
            },
          );
        });
  }

  static Future<void> showTextLoadingDialog(
      BuildContext context, ShowParam param) {
    if (param.show == null) return null;
    if (!param.show) return null;
    return showDialog<Null>(
        context: context, //BuildContext对象
        barrierDismissible: param.barrierDismissible,
        builder: (BuildContext context) {
          LoadingTextDialog dialog = new LoadingTextDialog(
            text: param.text ?? '加载中...',
            showParam: param,
          );
          return WillPopScope(
            child: dialog,
            onWillPop: () async {
              if (param.barrierDismissible == true) {
                param.dispose = true;
              }
              return Future.value(param.barrierDismissible);
            },
          );
        });
  }
}
