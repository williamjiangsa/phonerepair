import 'dart:convert';

import 'package:fastrepaire/net/manager/app_api.dart';
import 'package:fastrepaire/net/manager/result_data.dart';
import 'package:fastrepaire/net/model/colors_and_repair_items_entity.dart';
import 'package:fastrepaire/net/model/comment_entity.dart';
import 'package:fastrepaire/net/model/problems_entity.dart';
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

import 'model/fake_phone_info.dart';

//机型信息页面
class PhoneInfoPage extends StatefulWidget {
  //首页页面选择的问题项目ID
  final String repairItemId;

  //首页页面选择的问题项目名字
  final String repairItemName;

  //机型选择页面 机型id
  final String phoneItemId;

  PhoneInfoPage(this.repairItemId, this.phoneItemId, this.repairItemName);

  @override
  _PhoneInfoPageState createState() => _PhoneInfoPageState();
}

class _PhoneInfoPageState extends State<PhoneInfoPage> {
  FakePhoneInfoData phoneInfoData = FakePhoneInfoData();
  List<ProblemsData> problemDatas = [];

  //问题是否展示 选其他的话 应该显示 其余不展示 等用户自己反选的时候 展示
  bool problemsVisible = false;

  //是否选了具体的维修条目
  bool hasSelectedRepairedItem = false;

  //是否選了顏色
  bool hasChoosedColor = false;

  //标记最终选择的维修条目
  RepairItem selectedRepairItem;

  //标记最终选择的颜色
  PhoneColor selectedColor;

  @override
  void initState() {
    super.initState();
    problemsVisible = AppStrings.otherId == widget.repairItemId;
    phoneInfoData.init();
    phoneInfoData.repairName = widget.repairItemName ?? "";
    _fetchProblemsData();
    _fetchColorsAndProblemItems(widget.phoneItemId, widget.repairItemId);
    _fetchCommentData();
  }

  Future<void> _fetchCommentData() async {
    ResultData resultData = await AppApi.getInstance().getDataByGet(
      context,
      NetConstant.COMMENT,
    );
    if (resultData.isSuccess()) {
      setState(() {
        CommentEntity entity = CommentEntity.fromJson(resultData.response);
        phoneInfoData.convertComment(entity.data);
      });
    }
  }

  Future<void> _fetchColorsAndProblemItems(
      String modelId, String problemId) async {
    // modelId = "1";
    // problemId = "1";
    ResultData resultData = await AppApi.getInstance().getDataByGet(
      context,
      NetConstant.COLORS_PROBLEMS + "MODEL=$modelId&PROCLASS=$problemId",
    );
    if (resultData.isSuccess()) {
      setState(() {
        ColorsAndRepairItemsEntity entity =
            ColorsAndRepairItemsEntity.fromJson(resultData.response);
        phoneInfoData.convertColorsAndRepairItems(entity.data);
      });
    }
  }

  Future<void> _fetchProblemsData() async {
    ResultData resultData = await AppApi.getInstance().getDataByGet(
      context,
      NetConstant.PROBLEM,
    );
    if (resultData.isSuccess()) {
      setState(() {
        ProblemsEntity entity = ProblemsEntity.fromJson(resultData.response);
        problemDatas.clear();
        problemDatas.addAll(entity.data);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(widget.repairItemId + "======" + widget.phoneItemId);
    return Scaffold(
      body: Column(
        children: <Widget>[
          CommonAppBar(AppStrings.phoneInfoTitle),
          Expanded(
            child: _renderContent(),
          ),
          _renderBottom(),
        ],
      ),
    );
  }

  //内容区域
  _renderContent() {
    return SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      child: Column(
        children: <Widget>[
          Image.asset(
            "images/repair_bg.png",
            height: ScreenUtil.getInstance().setWidth(150),
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: _renderPhoneInfo(),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10),
              color: AppColors.white,
            ),
          ),
          _renderComment(),
        ],
      ),
    );
  }

  //评价
  _renderComment() {
    return Column(
      children: <Widget>[
        Container(
          height: ScreenUtil.getInstance().setWidth(5),
          color: AppColors.grey,
          margin: EdgeInsets.only(top: ScreenUtil.getInstance().setWidth(20)),
        ),
        Container(
          height: ScreenUtil.getInstance().setWidth(50),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil.getInstance().setWidth(20)),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    AppStrings.userComments +
                        " (${phoneInfoData.commentCountStr ?? ""})",
                    style: AppStyles.blackText14,
                  ),
                ),
                Text(
                  AppStrings.posRate + " ${phoneInfoData.posRate ?? ""}%",
                  style: AppStyles.greyText12,
                ),
              ],
            ),
          ),
        ),
//        CommonDivider(),
//        Wrap(
//          children: phoneInfoData.commentTags.map((item) {
//            return _renderCommentTagItem(item.tagName);
//          }).toList(),
//        ),
//        Container(
//          height: ScreenUtil.getInstance().setWidth(5),
//          color: AppColors.grey,
//        ),
        ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(
              horizontal: ScreenUtil.getInstance().setWidth(20)),
          itemBuilder: (context, index) {
            Comment comment = phoneInfoData.commentList[index];
            return Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10),
                color: AppColors.white,
              ),
              child: Padding(
                padding: EdgeInsets.all(ScreenUtil.getInstance().setWidth(5)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  child: ClipOval(
                                    child: CommonUtils.isEmpty(
                                            comment.commentUserAvatar)
                                        ? Image.asset(
                                            "images/default.png",
                                            fit: BoxFit.cover,
                                            width: ScreenUtil.getInstance()
                                                .setWidth(25),
                                            height: ScreenUtil.getInstance()
                                                .setWidth(25),
                                          )
                                        : FadeInImage.assetNetwork(
                                            placeholder: AppStrings.defaultPic,
                                            image: comment.commentUserAvatar,
                                            width: ScreenUtil.getInstance()
                                                .setWidth(25),
                                            height: ScreenUtil.getInstance()
                                                .setWidth(25),
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                  padding: EdgeInsets.all(
                                      ScreenUtil.getInstance().setWidth(5)),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        child: Text(
                                          comment.commentUserName ?? "",
                                          style: AppStyles.blackText14,
                                        ),
                                        padding: EdgeInsets.only(
                                            bottom: ScreenUtil.getInstance()
                                                .setWidth(5)),
                                      ),
                                      MyRatingBar(
                                        starSize: ScreenUtil.getInstance()
                                            .setWidth(15),
                                        markedCount: comment.rateStar,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            comment.commentDate ?? "",
                            style: AppStyles.greyText12,
                          ),
                        ],
                      ),
                      padding: EdgeInsets.symmetric(
                          vertical: ScreenUtil.getInstance().setWidth(5)),
                    ),
                    Padding(
                      child: Text(
                        comment.commentContent ?? "",
                        style: AppStyles.blackText12,
                      ),
                      padding:
                          EdgeInsets.all(ScreenUtil.getInstance().setWidth(10)),
                    ),
                    Row(
                      children: <Widget>[
                        Image.asset(
                          "images/phone.png",
                          width: ScreenUtil.getInstance().setWidth(15),
                          height: ScreenUtil.getInstance().setWidth(15),
                        ),
                        Expanded(
                          child: Text(
                            comment.commentDetail ?? "",
                            style: AppStyles.blackText12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return CommonDivider();
          },
          itemCount: phoneInfoData.commentList.length > 2
              ? 2
              : phoneInfoData.commentList.length,
        ),
        Container(
          margin: EdgeInsets.all(ScreenUtil.getInstance().setWidth(10)),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(20),
            border: new Border.all(width: 1, color: AppColors.grey),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ScreenUtil.getInstance().setWidth(25),
              vertical: ScreenUtil.getInstance().setWidth(5),
            ),
            child: GestureDetector(
              onTap: () {
                AppRoutes.router.navigateTo(context, Routes.homeAllComments);
              },
              child: Text(
                AppStrings.viewAllComents,
                style: AppStyles.greyText12,
              ),
            ),
          ),
        ),
      ],
    );
  }

  //流式布局 子widget
  Widget _renderCommentTagItem(String tagContent) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10),
        border: new Border.all(width: 1, color: AppColors.grey),
      ),
      margin: EdgeInsets.only(
        right: ScreenUtil.getInstance().setWidth(5),
        top: ScreenUtil.getInstance().setWidth(10),
        bottom: ScreenUtil.getInstance().setWidth(10),
      ),
      child: Padding(
        padding: EdgeInsets.all(ScreenUtil.getInstance().setWidth(5)),
        child: Text(
          tagContent ?? "",
          style: AppStyles.greyText12,
        ),
      ),
    );
  }

  //中间机型信息
  _renderPhoneInfo() {
    return Padding(
      padding: EdgeInsets.all(ScreenUtil.getInstance().setWidth(15)),
      child: Column(
        children: <Widget>[
          _renerPhoneBaseInfo(),
          CommonDivider(),
          _renderPhoneColorsInfo(),
          CommonDivider(),
          Offstage(
            child: Offstage(
              child: _renderPhoneProblem(),
              offstage: problemsVisible,
            ),
            offstage: hasSelectedRepairedItem,
          ),
          Offstage(
            child: Offstage(
              offstage: !problemsVisible && !hasSelectedRepairedItem,
              child: GridView.builder(
                  padding: EdgeInsets.all(0),
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: problemDatas.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    ProblemsData problemInfo = problemDatas[index];
                    return Container(
                      color: AppColors.white,
                      child: GestureDetector(
                        child: Center(
                          child: Text(
                            problemInfo.proclassName ?? "",
                            style: AppStyles.greyText12,
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            phoneInfoData.repairName = problemInfo.proclassName;
                            problemsVisible = false;
                          });
                        },
                      ),
                    );
                  }),
            ),
            offstage: hasSelectedRepairedItem,
          ),
          Offstage(
            child: _renderSeletedRepairItem(),
            offstage: !hasSelectedRepairedItem,
          ),
        ],
      ),
    );
  }

  //最終选择的维修条目
  _renderSeletedRepairItem() {
    if (selectedRepairItem == null) {
      return Container();
    }
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10),
        border: new Border.all(width: 1, color: AppColors.appBlue),
      ),
      margin:
          EdgeInsets.symmetric(vertical: ScreenUtil.getInstance().setWidth(8)),
      child: Padding(
        padding: EdgeInsets.all(ScreenUtil.getInstance().setWidth(10)),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                children: <Widget>[
                  Text(
                    selectedRepairItem.repairName ?? "",
                    style: TextStyle(
                      fontSize: ScreenUtil.getInstance().setSp(12),
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                  ),
                  Padding(
                    child: Text(selectedRepairItem.repairDesc ?? ""),
                    padding: EdgeInsets.symmetric(
                        vertical: ScreenUtil.getInstance().setWidth(5)),
                  ),
                  Text(selectedRepairItem.period ?? ""),
                ],
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
            ),
            Column(
              children: <Widget>[
                IconButton(
                  icon: Image.asset(
                    "images/remove.png",
                    width: ScreenUtil.getInstance().setWidth(15),
                    height: ScreenUtil.getInstance().setWidth(15),
                  ),
                  onPressed: () {
                    setState(() {
                      selectedColor = null;
                      hasChoosedColor = false;
                      selectedRepairItem = null;
                      hasSelectedRepairedItem = false;
                    });
                  },
                ),
                Text(AppStrings.moneySymbol + selectedRepairItem.price),
              ],
            ),
          ],
        ),
      ),
    );
  }

  //手机基本信息
  _renerPhoneBaseInfo() {
    return Container(
      height: ScreenUtil.getInstance().setWidth(50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            phoneInfoData.phoneName ?? "",
            style: AppStyles.blackText14,
          ),
          GestureDetector(
            child: Icon(
              Icons.navigate_next,
              color: AppColors.appBlue,
            ),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  //手机颜色信息
  _renderPhoneColorsInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Padding(
              child: Text(
                AppStrings.colorSelect,
                style: AppStyles.greyText12,
              ),
              padding: EdgeInsets.symmetric(
                  vertical: ScreenUtil.getInstance().setWidth(20)),
            ),
            Expanded(
              child: Offstage(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil.getInstance().setWidth(10)),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          selectedColor == null
                              ? ""
                              : selectedColor.colorName ?? "",
                          style: AppStyles.greyText12,
                        ),
                      ),
                      GestureDetector(
                        child: Text(
                          selectedColor == null ? "" : "Change",
                          style: AppStyles.blueText12,
                        ),
                        onTap: () {
                          setState(() {
                            hasChoosedColor = false;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                offstage: !hasChoosedColor,
              ),
            )
          ],
        ),
        Offstage(
          child: GridView.builder(
            padding:
                EdgeInsets.only(bottom: ScreenUtil.getInstance().setWidth(10)),
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: phoneInfoData.phoneColors.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemBuilder: (BuildContext context, int index) {
              PhoneColor phoneColor = phoneInfoData.phoneColors[index];
              return Column(
                children: <Widget>[
                  Expanded(
                    child: GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(width: 1, color: AppColors.grey),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(
                              ScreenUtil.getInstance().setWidth(3)),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: phoneColor.color ?? AppColors.transparent,
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          selectedColor = phoneColor;
                          hasChoosedColor = true;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        phoneColor.colorName ?? "",
                        style: AppStyles.blackText12,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          offstage: hasChoosedColor,
        ),
      ],
    );
  }

  //手机问题
  _renderPhoneProblem() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          child: GestureDetector(
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.arrow_back,
                  color: AppColors.appBlue,
                ),
                Text(
                  phoneInfoData.repairName ?? "",
                  style: AppStyles.blueText12,
                ),
              ],
            ),
            onTap: () {
              setState(() {
                selectedRepairItem = null;
                problemsVisible = true;
              });
            },
          ),
          padding: EdgeInsets.symmetric(
              vertical: ScreenUtil.getInstance().setWidth(10)),
        ),
        Offstage(
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.all(0),
            itemBuilder: (context, index) {
              RepairItem repairItem = phoneInfoData.repairItems[index];
              return GestureDetector(
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10),
                    border: new Border.all(width: 1, color: AppColors.appBlue),
                  ),
                  margin: EdgeInsets.symmetric(
                      vertical: ScreenUtil.getInstance().setWidth(8)),
                  child: Padding(
                    padding:
                        EdgeInsets.all(ScreenUtil.getInstance().setWidth(10)),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Text(
                                repairItem.repairName ?? "",
                                style: TextStyle(
                                  fontSize: ScreenUtil.getInstance().setSp(12),
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.black,
                                ),
                              ),
                              Padding(
                                child: Text(repairItem.repairDesc ?? ""),
                                padding: EdgeInsets.symmetric(
                                    vertical:
                                        ScreenUtil.getInstance().setWidth(5)),
                              ),
                            ],
                            crossAxisAlignment: CrossAxisAlignment.start,
                          ),
                        ),
                        Column(
                          children: <Widget>[
                            Text(AppStrings.moneySymbol + repairItem.price),
                            Text(repairItem.period ?? ""),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                onTap: () {
                  setState(() {
                    selectedRepairItem = repairItem;
                    hasSelectedRepairedItem = true;
                  });
                },
              );
            },
            itemCount: phoneInfoData.repairItems.length,
          ),
          offstage: problemsVisible,
        ),
      ],
    );
  }

  //底部合计信息
  _renderBottom() {
    return Container(
      height: ScreenUtil.getInstance().setWidth(50),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      child: Text(
                        AppStrings.preFee +
                            " " +
                            AppStrings.moneySymbol +
                            (selectedRepairItem == null
                                ? "0"
                                : selectedRepairItem.price ?? ""),
                        style: AppStyles.blueText12,
                      ),
                      padding: EdgeInsets.only(
                          left: ScreenUtil.getInstance().setWidth(10)),
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          AppStrings.marketPrice + " ",
                          style: AppStyles.greyText10,
                        ),
                        Text(
                          AppStrings.moneySymbol +
                              (selectedRepairItem == null
                                  ? "0"
                                  : selectedRepairItem.yPrice ?? ""),
                          style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            decorationColor: AppColors.grey,
                            fontSize: ScreenUtil.getInstance().setSp(10),
                            color: AppColors.grey,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Text(
                  AppStrings.includingGST,
                  style: AppStyles.blueText12,
                ),
              ],
            )),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: AppColors.appDarkBlue,
              child: GestureDetector(
                child: Center(
                  child: Text(
                    AppStrings.submitOrder,
                    style: AppStyles.whiteText14,
                  ),
                ),
                onTap: () {
                  _toConfirmOrderPage();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  _toConfirmOrderPage() {
    if (selectedColor == null) {
      CommonUtils.showToast(AppStrings.confirmColors);
      return;
    }
    if (selectedRepairItem == null) {
      CommonUtils.showToast(AppStrings.confirmRepairs);
      return;
    }
    String jsonString = json.encode(selectedRepairItem.toJson());
    var jsons = jsonEncode(Utf8Encoder().convert(jsonString));
    AppRoutes.router.navigateTo(
        context, Routes.orderConfirm + "?${AppStrings.repairJson}=$jsons");
  }
}
