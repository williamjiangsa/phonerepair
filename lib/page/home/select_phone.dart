import 'package:fastrepaire/net/manager/app_api.dart';
import 'package:fastrepaire/net/manager/result_data.dart';
import 'package:fastrepaire/net/model/phone_list_entity.dart';
import 'package:fastrepaire/net/net_constant.dart';
import 'package:fastrepaire/routes/my_routes.dart';
import 'package:fastrepaire/routes/routes.dart';
import 'package:fastrepaire/utils/common_util.dart';
import 'package:fastrepaire/values/colors.dart';
import 'package:fastrepaire/values/strings.dart';
import 'package:fastrepaire/values/styles.dart';
import 'package:fastrepaire/widget/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//选择机型页面
class SelectPhonePage extends StatefulWidget {
  //上一页面选择的问题项目ID 要继续回传到下一个页面 接口预计要用到
  final String repairItemId;

  //上一页面选择的问题项目名字 要继续回传到下一个页面 接口预计要用到
  final String repairItemName;

  SelectPhonePage(this.repairItemId, this.repairItemName);

  @override
  _SelectPhonePageState createState() => _SelectPhonePageState();
}

class _SelectPhonePageState extends State<SelectPhonePage> {
  //机器 数据源
  List<PhoneListData> phoneDatas = [];

  //右边的数据源
  List<PhoneListDataBrandClassClas> rightDatas = [];

  //一级分类选择位置
  int leftSelectedPos = 0;

  TextEditingController _textEditingController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchPhoneList();
  }

  Future<void> _fetchPhoneList() async {
    ResultData resultData = await AppApi.getInstance().getDataByGet(
      context,
      NetConstant.PHONE_LIST,
    );
    if (resultData.isSuccess()) {
      setState(() {
        PhoneListEntity entity = PhoneListEntity.fromJson(resultData.response);
        phoneDatas.clear();
        phoneDatas.addAll(entity.data ?? []);
        if (phoneDatas.length > leftSelectedPos &&
            phoneDatas[leftSelectedPos] != null &&
            phoneDatas[leftSelectedPos].brandClass != null &&
            phoneDatas[leftSelectedPos].brandClass.xClass != null) {
          rightDatas.addAll(phoneDatas[leftSelectedPos].brandClass.xClass);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          CommonAppBar(AppStrings.phoneSelectTitle),
          renderTopSearch(),
          CommonDivider(),
          Expanded(
            child: _renderContent(),
          )
        ],
      ),
    );
  }

  //顶部搜索栏
  renderTopSearch() {
    return Container(
      color: AppColors.white,
      height: ScreenUtil.getInstance().setWidth(50),
      child: Padding(
        padding: EdgeInsets.all(ScreenUtil.getInstance().setWidth(10)),
        child: Container(
          decoration: BoxDecoration(
            border: new Border.all(width: 1, color: AppColors.grey),
            color: AppColors.searchWhiteBg,
            borderRadius: new BorderRadius.all(
                new Radius.circular(ScreenUtil.getInstance().setWidth(8))),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil.getInstance().setWidth(15)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.search,
                  color: AppColors.grey,
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: AppStrings.searchHint,
                      hintStyle: AppStyles.greyText12,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: ScreenUtil.getInstance().setWidth(5),
                      ),
                    ),
                    cursorColor: AppColors.black,
                    onSubmitted: (searchData) {
                      _getSearchResult(searchData);
                    },
                    textInputAction: TextInputAction.search,
                    controller: _textEditingController,
                  ),
                ),
              ],
            ),
          ),
          height: ScreenUtil.getInstance().setWidth(30),
        ),
      ),
    );
  }

  //根据接口返回的 自己匹配 含有搜索词汇的  展示出来
  _getSearchResult(String searchData) {
    if (!CommonUtils.isEmpty(searchData)) {
      rightDatas.clear();
      _textEditingController.clear();
      for (int j = 0; j < phoneDatas.length; j++) {
        if (phoneDatas[j] != null &&
            phoneDatas[j].brandClass != null &&
            phoneDatas[j].brandClass.xClass != null) {
          List<PhoneListDataBrandClassClas> subItems =
              phoneDatas[j].brandClass.xClass;
          for (int k = 0; k < subItems.length; k++) {
            PhoneListDataBrandClassClas subItem = subItems[k];
            PhoneListDataBrandClassClas searchResultItem =
                PhoneListDataBrandClassClas();
            searchResultItem.className = subItem.className;
            searchResultItem.classId = subItem.classId;
            searchResultItem.models = PhoneListDataBrandClassClassModels();
            searchResultItem.models.model = [];
            if (subItem != null &&
                subItem.models != null &&
                subItem.models.model != null) {
              for (int i = 0; i < subItem.models.model.length; i++) {
                if (subItem.models.model[i].phoneName.toUpperCase().contains(searchData.toUpperCase())) {
                  searchResultItem.models.model.add(subItem.models.model[i]);
                }
              }
              if (searchResultItem.models.model.length > 0) {
                rightDatas.add(searchResultItem);
                leftSelectedPos = j;
              }
            }
          }
        }

        setState(() {});
      }
    }
  }

  //内容区域 左右 分类
  _renderContent() {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: _renderCategory(),
        ),
        VerticalDivider(
          width: 1,
          color: AppColors.dividerBlack,
        ),
        Expanded(
          flex: 4,
          child: _renderSubItmes(),
        ),
      ],
    );
  }

  //左边一级分类
  _renderCategory() {
    return ListView.builder(
      padding: EdgeInsets.all(0),
      itemBuilder: (context, index) {
        PhoneListData item = phoneDatas[index];
        return GestureDetector(
          child: Container(
            color: AppColors.white,
            height: ScreenUtil.getInstance().setWidth(50),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Center(
                    child: Text(
                      item.brandName ?? "",
                      style: TextStyle(
                        fontSize: ScreenUtil.getInstance().setSp(12),
                        color: leftSelectedPos == index
                            ? AppColors.appBlue
                            : AppColors.grey,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 2,
                  width: ScreenUtil.getInstance().setWidth(20),
                  color: leftSelectedPos == index
                      ? AppColors.appBlue
                      : AppColors.transparent,
                )
              ],
            ),
          ),
          onTap: () {
            if (leftSelectedPos == index) {
              return;
            }
            setState(() {
              leftSelectedPos = index;
              if (phoneDatas.length > leftSelectedPos &&
                  phoneDatas[leftSelectedPos] != null &&
                  phoneDatas[leftSelectedPos].brandClass != null &&
                  phoneDatas[leftSelectedPos].brandClass.xClass != null) {
                rightDatas.clear();
                rightDatas
                    .addAll(phoneDatas[leftSelectedPos].brandClass.xClass);
              }
            });
          },
        );
      },
      itemCount: phoneDatas.length,
    );
  }

  //右边二级分类
  _renderSubItmes() {
    return Container(
      color: AppColors.white,
      child: ListView.builder(
        padding: EdgeInsets.all(0),
        itemBuilder: (context, index) {
          PhoneListDataBrandClassClas subItem = rightDatas[index];
          //二级分类里包含三级分类
          return Column(
            children: <Widget>[
              Offstage(
                offstage: !(subItem.models != null &&
                    subItem.models.model != null &&
                    subItem.models.model.length > 0),
                child: Container(
                  child: Padding(
                    child: Center(
                      child: Text(
                        subItem.className ?? "",
                        style: AppStyles.greyText12,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                        vertical: ScreenUtil.getInstance().setWidth(15)),
                  ),
                  color: AppColors.white,
                  width: double.infinity,
                ),
              ),
              GridView.builder(
                padding: EdgeInsets.all(0),
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: (subItem != null &&
                        subItem.models != null &&
                        subItem.models.model != null)
                    ? subItem.models.model.length
                    : 0,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3,
                ),
                itemBuilder: (BuildContext context, int index) {
                  PhoneListDataBrandClassClassModelsModel subItemInfo =
                      subItem.models.model[index];
                  return Container(
                    color: AppColors.white,
                    child: GestureDetector(
                      child: Center(
                        child: Text(
                          subItemInfo.phoneName ?? "",
                          style: AppStyles.greyText12,
                        ),
                      ),
                      onTap: () {
                        AppRoutes.router.navigateTo(
                            context,
                            Routes.phoneInfo +
                                "?${AppStrings.repairItemId}=${widget.repairItemId}&${AppStrings.phoneItemId}=${subItemInfo.phoneId ?? ""}&${AppStrings.repairItemName}=${Uri.encodeComponent(widget.repairItemName ?? "")}");
                      },
                    ),
                  );
                },
              ),
            ],
          );
        },
        itemCount:
//        (phoneDatas.length > leftSelectedPos &&
//                phoneDatas[leftSelectedPos] != null &&
//                phoneDatas[leftSelectedPos].brandClass != null &&
//                phoneDatas[leftSelectedPos].brandClass != null &&
//                phoneDatas[leftSelectedPos].brandClass.xClass != null)
//            ? phoneDatas[leftSelectedPos].brandClass.xClass.length
//            : 0
            rightDatas.length,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
  }
}
