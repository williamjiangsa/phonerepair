import 'package:cached_network_image/cached_network_image.dart';
import 'package:fastrepaire/net/manager/app_api.dart';
import 'package:fastrepaire/net/manager/result_data.dart';
import 'package:fastrepaire/net/model/recycle_list_entity.dart';
import 'package:fastrepaire/net/net_constant.dart';
import 'package:fastrepaire/utils/common_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../routes/my_routes.dart';
import '../../routes/routes.dart';
import '../../values/colors.dart';
import '../../values/strings.dart';
import '../../values/styles.dart';
import '../../widget/common_widget.dart';

//回收机型页面 切换 手机/平板
class RecyclePhoneListPage extends StatefulWidget {
  //0是手机 1是pad
  final int tabPos;

  RecyclePhoneListPage({this.tabPos = 0});

  @override
  _RecyclePhoneListPageState createState() => _RecyclePhoneListPageState();
}

class _RecyclePhoneListPageState extends State<RecyclePhoneListPage> {
  bool isPhone = true;
  int selectPos = 0;

  List<RecycleListData> data = [];
  List<RecycleListDataBrandClassClas> items = [];

  @override
  void initState() {
    super.initState();
    isPhone = widget.tabPos == 0;
    _fetchPhoneList();
  }

  Future<void> _fetchPhoneList() async {
    ResultData resultData = await AppApi.getInstance().getDataByGet(
      context,
      NetConstant.PHONE_LIST_RECYCLE,
    );
    if (resultData.isSuccess()) {
      setState(() {
        RecycleListEntity entity =
            RecycleListEntity.fromJson(resultData.response);
        data.clear();
        data.addAll(entity.data ?? []);
        _initSecondItems();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          _renderTopSearch(),
//          _renderTopTab(),
          _renderContent(),
        ],
      ),
    );
  }

  //顶部搜索
  _renderTopSearch() {
    return Container(
      height: ScreenUtil.getInstance().setWidth(50) +
          MediaQuery.of(context).padding.top,
      color: AppColors.appDarkBlue,
      child: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
          left: ScreenUtil.getInstance().setWidth(10),
          right: ScreenUtil.getInstance().setWidth(10),
          bottom: ScreenUtil.getInstance().setWidth(10),
        ),
        child: Row(
          //中间空出来
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            GestureDetector(
              child: Icon(
                Icons.arrow_back,
                color: AppColors.white,
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.white,
                ),
                child: Align(
                  child: Text(
                    AppStrings.recycleSearchHint,
                    style: AppStyles.greyText12,
                  ),
                  alignment: Alignment.centerLeft,
                ),
                height: double.infinity,
                margin: EdgeInsets.all(ScreenUtil.getInstance().setWidth(5)),
                padding: EdgeInsets.all(ScreenUtil.getInstance().setWidth(5)),
              ),
            ),
            Text(
              AppStrings.search,
              style: AppStyles.whiteText14,
            ),
          ],
        ),
      ),
    );
  }

  //tab切换
  _renderTopTab() {
    return Container(
      height: ScreenUtil.getInstance().setWidth(45),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    child: Center(
                      child: Text(
                        AppStrings.phone,
                        style: isPhone
                            ? AppStyles.blueText14
                            : AppStyles.blackText14,
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        isPhone = true;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    child: Center(
                      child: Text(
                        AppStrings.pad,
                        style: !isPhone
                            ? AppStyles.blueText14
                            : AppStyles.blackText14,
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        isPhone = false;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          CommonDivider(),
        ],
      ),
    );
  }

  //内容区域
  _renderContent() {
    return Expanded(
      child: Row(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return GestureDetector(
                  child: Container(
                    height: ScreenUtil.getInstance().setWidth(40),
                    child: Center(
                      child: Text(
                        data[index].brandName,
                        style: selectPos == index
                            ? AppStyles.blueText12
                            : AppStyles.greyText12,
                      ),
                    ),
                    color: selectPos == index
                        ? AppColors.white
                        : AppColors.lightGrey,
                  ),
                  onTap: () {
                    if (selectPos != index) {
                      setState(() {
                        selectPos = index;
                        _initSecondItems();
                      });
                    }
                  },
                );
              },
              itemCount: data.length,
              padding: EdgeInsets.all(0),
            ),
            flex: 2,
          ),
          Expanded(
            child: Container(
              color: AppColors.white,
              child: ListView.builder(
                padding: EdgeInsets.all(0),
                itemBuilder: (context, index) {
                  RecycleListDataBrandClassClas secondItem = items[index];
                  return Container(
                    child: Column(
                      children: <Widget>[
                        Text(
                          secondItem.className ?? "",
                          style: AppStyles.blackText12,
                        ),
                        GridView.builder(
                          padding: EdgeInsets.all(0),
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: secondItem.models != null &&
                                  secondItem.models.model != null
                              ? secondItem.models.model.length
                              : 0,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            RecycleListDataBrandClassClassModelsModel
                                subItemInfo = secondItem.models.model[index];
                            return Container(
                              color: AppColors.white,
                              padding: EdgeInsets.all(
                                  ScreenUtil.getInstance().setWidth(10)),
                              child: GestureDetector(
                                child: Column(
                                  children: <Widget>[
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.all(
                                            ScreenUtil.getInstance()
                                                .setWidth(10)),
                                        child: CommonUtils.isEmpty(
                                                subItemInfo.phonePic)
                                            ? Image.asset(
                                                "images/default.png",
                                                fit: BoxFit.fill,
                                                width: ScreenUtil.getInstance()
                                                    .setWidth(30),
                                              )
                                            : CachedNetworkImage(
                                                imageUrl: subItemInfo.phonePic,
                                                placeholder: (context, url) =>
                                                    Image.asset(
                                                  "images/default.png",
                                                  width:
                                                      ScreenUtil.getInstance()
                                                          .setWidth(30),
                                                  fit: BoxFit.fill,
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Image.asset(
                                                  "images/default.png",
                                                  width:
                                                      ScreenUtil.getInstance()
                                                          .setWidth(30),
                                                  fit: BoxFit.fill,
                                                ),
                                                fit: BoxFit.contain,
                                              ),
                                      ),
                                    ),
                                    Text(
                                      subItemInfo.phoneName ?? "",
                                      style: AppStyles.greyText12,
                                    ),
                                  ],
                                ),
                                onTap: () {
                                  AppRoutes.router
                                      .navigateTo(context, Routes.recycleInfo);
                                },
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  );
                },
                itemCount: items.length,
              ),
            ),
            flex: 7,
          ),
        ],
      ),
    );
  }

  void _initSecondItems() {
    items = data[selectPos] != null &&
            data[selectPos].brandClass != null &&
            data[selectPos].brandClass.xClass != null
        ? data[selectPos].brandClass.xClass
        : [];
    for (int i = 0; i < items.length; i++) {
      if (items[i].models == null ||
          items[i].models.model == null ||
          items[i].models.model.length == 0) {
        items.removeAt(i);
        i--;
      }
    }
  }
}
