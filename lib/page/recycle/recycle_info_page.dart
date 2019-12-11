import 'package:fastrepaire/utils/common_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../values/colors.dart';
import '../../values/strings.dart';
import '../../values/styles.dart';
import '../../widget/common_widget.dart';
import 'model/fake_recycle_info_data.dart';

class RecycleInfoPage extends StatefulWidget {
  @override
  _RecycleInfoPageState createState() => _RecycleInfoPageState();
}

class _RecycleInfoPageState extends State<RecycleInfoPage> {
  FakeRecycleInfoData recycleInfoData;

  @override
  void initState() {
    super.initState();
    recycleInfoData = FakeRecycleInfoData();
    recycleInfoData.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          CommonAppBar(AppStrings.tabRecycle),
          Expanded(
            child: _renderRecyleDetail(),
          ),
          _renderSubmitButton(),
        ],
      ),
    );
  }

  _renderSubmitButton() {
    return GestureDetector(
      child: Container(
        color: AppColors.appBlue,
        height: ScreenUtil.getInstance().setWidth(50),
        child: Center(
          child: Text(
            AppStrings.confirmOrder,
            style: AppStyles.whiteText14,
          ),
        ),
      ),
      onTap: () {
        if (_checkCanSubmit()) {
          //跳转页面
        }
      },
    );
  }

  bool _checkCanSubmit() {
    bool canSubmit = true;
    for (int i = 0; i < recycleInfoData.recycleInfos.length; i++) {
      bool hasSubItemsChoosed = false;
      for (int j = 0;
          j < recycleInfoData.recycleInfos[i].recycleSubInfos.length;
          j++) {
        if (recycleInfoData.recycleInfos[i].recycleSubInfos[j].isChoosed) {
          hasSubItemsChoosed = true;
          break;
        }
      }
      if (!hasSubItemsChoosed) {
        canSubmit = false;
        CommonUtils.showToast(AppStrings.selectNotDoneTips);
        break;
      }
    }
    return canSubmit;
  }

  //回收内容list
  _renderRecyleDetail() {
    return ListView.builder(
      itemBuilder: (context, index) {
        return _renderListItem(index);
      },
      itemCount: recycleInfoData.recycleInfos.length,
      padding: EdgeInsets.all(ScreenUtil.getInstance().setWidth(20)),
    );
  }

  //回收单挑内容
  _renderListItem(int index) {
    RecycleInfo info = recycleInfoData.recycleInfos[index];
    return Column(
      children: <Widget>[
        GestureDetector(
          child: Padding(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  info.recycleName ?? "",
                  style: AppStyles.blackText14,
                ),
                Text(
                  _getSelectedItemNames(info),
                  style: AppStyles.blueText12,
                ),
              ],
            ),
            padding: EdgeInsets.symmetric(
                vertical: ScreenUtil.getInstance().setWidth(10)),
          ),
          onTap: () {
            setState(() {
              info.hasClickedToExpand = !info.hasClickedToExpand;
            });
          },
        ),
        Offstage(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return _renderSumItems(info, info.recycleSubInfos[index]);
            },
            itemCount: info.recycleSubInfos.length,
            padding: EdgeInsets.all(0),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
          ),
          offstage: _getOffstageState(info),
        ),
      ],
    );
  }

  //获取选择条目名字
  String _getSelectedItemNames(RecycleInfo info) {
    String selectedNames = "";
    info.recycleSubInfos.forEach((item) {
      if (item.isChoosed && info.isSingleChoice) {
        selectedNames += item.recycleName + " ";
      }
    });
    return selectedNames;
  }

  //是否应该显示
  bool _getOffstageState(RecycleInfo info) {
    bool shouldOffStage = false;
    for (int i = 0; i < info.recycleSubInfos.length; i++) {
      if (info.isSingleChoice && info.recycleSubInfos[i].isChoosed) {
        shouldOffStage = true;
        break;
      }
    }
    return info.hasClickedToExpand && shouldOffStage;
  }

  //真正选择的条目单选 反选
  _renderSumItems(RecycleInfo parent, RecycleInfo info) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
          color: AppColors.white,
        ),
        child: GestureDetector(
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  color: info.isChoosed ? AppColors.appBlue : AppColors.grey),
              color: info.isChoosed ? AppColors.appBlue : AppColors.white,
            ),
            child: Padding(
              padding: EdgeInsets.all(ScreenUtil.getInstance().setWidth(10)),
              child: Center(
                child: Text(
                  info.recycleName ?? "",
                ),
              ),
            ),
          ),
          onTap: () {
            debugPrint(info.recycleName ?? "");
            setState(() {
              if (parent.isSingleChoice) {
                parent.recycleSubInfos.forEach((single) {
                  single.isChoosed = false;
                });
                info.isChoosed = true;
                parent.hasClickedToExpand = true;
              } else {
                info.isChoosed = !info.isChoosed;
              }
            });
          },
        ),
        padding: EdgeInsets.all(ScreenUtil.getInstance().setWidth(10)),
      ),
    );
  }
}
