import 'package:cached_network_image/cached_network_image.dart';
import 'package:fastrepaire/net/manager/app_api.dart';
import 'package:fastrepaire/net/manager/result_data.dart';
import 'package:fastrepaire/net/model/banner_home_entity.dart';
import 'package:fastrepaire/net/model/comment_entity.dart';
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
import 'package:flutter_swiper/flutter_swiper.dart';

import 'package:fastrepaire/page/home/model/fake_home_data.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  FakeHomeData fakeHomeData;
  SwiperController bannerSwiperController;
  SwiperController commentSwiperController;

  @override
  void initState() {
    super.initState();
    _initFakeHomeData();
    bannerSwiperController = SwiperController();
    commentSwiperController = SwiperController();
    bannerSwiperController.startAutoplay();
    commentSwiperController.startAutoplay();
  }

  //初始化数据  联网之后  这里一般是异步获取了数据  直接setstate 刷新界面即可
  void _initFakeHomeData() {
    fakeHomeData = FakeHomeData();
    fakeHomeData.init();
    _fetchBannerData();
    _fetchCommentData();
  }

  Future<void> _refresh() async {
    _fetchBannerData();
    _fetchCommentData();
  }

  Future<void> _fetchBannerData() async {
    ResultData resultData = await AppApi.getInstance().getDataByGet(
      context,
      NetConstant.HOME_BANNER_URL,
    );
    if (resultData.isSuccess()) {
      setState(() {
        BannerHomeEntity entity =
            BannerHomeEntity.fromJson(resultData.response);
        fakeHomeData.convertBanner(entity.data);
      });
    }
  }

  Future<void> _fetchCommentData() async {
    ResultData resultData = await AppApi.getInstance().getDataByGet(
      context,
      NetConstant.COMMENT,
    );
    if (resultData.isSuccess()) {
      setState(() {
        CommentEntity entity = CommentEntity.fromJson(resultData.response);
        fakeHomeData.convertComment(entity.data);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: <Widget>[
        _renderTop(),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(ScreenUtil.getInstance().setWidth(10)),
            child: RefreshIndicator(
              child: CustomScrollView(
                physics: BouncingScrollPhysics(),
                slivers: <Widget>[
                  _renderBanner(),
                  // _renderSizedBox(),
                  _renderRepairItems(),
                  _renderAd(),
                  _renderComments(),
                ],
              ),
              onRefresh: _refresh,
            ),
          ),
        ),
      ],
    );
  }


  //评论区
  _renderComments() {
    return SliverToBoxAdapter(
      child: Container(
        height: ScreenUtil.getInstance().setWidth(170),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    child: Text(
                      AppStrings.userComment,
                      style: AppStyles.blackText16,
                    ),
                    padding: EdgeInsets.symmetric(
                        vertical: ScreenUtil.getInstance().setWidth(10)),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    AppRoutes.router
                        .navigateTo(context, Routes.homeAllComments);
                  },
                  child: Text(
                    AppStrings.commentMore,
                    style: AppStyles.greyText12,
                  ),
                ),
              ],
            ),
            Expanded(
              child: Swiper(
                itemBuilder: (BuildContext context, int index) {
                  Comment comment = fakeHomeData.commentItems[index];
                  return Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.white,
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.all(ScreenUtil.getInstance().setWidth(5)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        child: Text(
                                          comment.userName ?? "",
                                          style: AppStyles.blackText14,
                                        ),
                                        padding: EdgeInsets.only(
                                            bottom: ScreenUtil.getInstance()
                                                .setWidth(5)),
                                      ),
                                      MyRatingBar(
                                        starSize: ScreenUtil.getInstance()
                                            .setWidth(15),
                                        markedCount: comment.rate,
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  comment.date ?? "",
                                  style: AppStyles.greyText12,
                                ),
                              ],
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: ScreenUtil.getInstance().setWidth(5)),
                          ),
                          Expanded(
                            child: Text(
                              comment.content ?? "",
                              style: AppStyles.blackText12,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Image.asset(
                                "images/phone.png",
                                width: ScreenUtil.getInstance().setWidth(15),
                                height: ScreenUtil.getInstance().setWidth(15),
                              ),
                              Text(
                                comment.detail ?? "",
                                style: AppStyles.blackText12,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: fakeHomeData.commentItems.length,
                duration: AppStrings.commentDuration,
                pagination: null,
                scrollDirection: Axis.horizontal,
                autoplay: false,
                loop: false,
                controller: commentSwiperController,
              ),
            ),
          ],
        ),
      ),
    );
  }

  //广告位
  _renderAd() {
    return SliverToBoxAdapter(
      child: CommonUtils.isEmpty(fakeHomeData.adUrl)
          ? Image.asset(
              "images/default.png",
              fit: BoxFit.cover,
              height: ScreenUtil.getInstance().setWidth(120),
            )
          : CachedNetworkImage(
              imageUrl: fakeHomeData.adUrl,
              placeholder: (context, url) => Image.asset(
                "images/default.png",
                fit: BoxFit.contain,
                height: ScreenUtil.getInstance().setWidth(120),
              ),
              errorWidget: (context, url, error) => Image.asset(
                "images/default.png",
                fit: BoxFit.contain,
                height: ScreenUtil.getInstance().setWidth(120),
              ),
              fit: BoxFit.cover,
              height: ScreenUtil.getInstance().setWidth(120),
            ),
    );
  }

  //常见问题选择
  _renderRepairItems() {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          RepairItem repair = fakeHomeData.repairItems[index];
          return GestureDetector(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: CommonUtils.isEmpty(repair.itemUrl)
                      ? Image.asset(
                          "images/default.png",
                          fit: BoxFit.cover,
                          width: ScreenUtil.getInstance().setWidth(30),
                          height: ScreenUtil.getInstance().setWidth(50),
                        )
                      : Image.asset(
                          repair.itemUrl,
                          width: ScreenUtil.getInstance().setWidth(50)*2/3,
                          height: ScreenUtil.getInstance().setWidth(50)*2/3,
                        ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: ScreenUtil.getInstance().setWidth(5),
                  ),
                  child: Text(
                    repair.itemName ?? "",
                    style: AppStyles.blackText12,
                  ),
                ),
              ],
            ),
            onTap: () {
              AppRoutes.router.navigateTo(
                  context,
                  Routes.phoneSelect +
                      "?${AppStrings.repairItemId}=${repair.itemId ?? ""}&${AppStrings.repairItemName}=${Uri.encodeComponent(repair.itemName ?? "")}");
            },
          );
        },
        childCount: fakeHomeData.repairItems.length,
      ),
    );
  }

  //顶部轮播图
  _renderBanner() {
    return SliverToBoxAdapter(
      child: Container(
        height: ScreenUtil.getInstance().setWidth(150),
        child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CommonUtils.isEmpty(fakeHomeData.bannerPics[index])
                  ? Image.asset(
                      "images/default.png",
                      fit: BoxFit.cover,
                    )
                  : CachedNetworkImage(
                      imageUrl: fakeHomeData.bannerPics[index],
                      placeholder: (context, url) => Image.asset(
                        "images/default.png",
                        fit: BoxFit.contain,
                        height: ScreenUtil.getInstance().setWidth(120),
                      ),
                      errorWidget: (context, url, error) => Image.asset(
                        "images/default.png",
                        fit: BoxFit.contain,
                        height: ScreenUtil.getInstance().setWidth(120),
                      ),
                      fit: BoxFit.cover,
                    ),
            );
          },
          itemCount: fakeHomeData.bannerPics.length,
          duration: AppStrings.bannerDuration,
          pagination: new SwiperPagination(
              builder: DotSwiperPaginationBuilder(
            color: AppColors.grey,
            activeColor: AppColors.black,
          )),
          scrollDirection: Axis.horizontal,
          autoplay: false,
          loop: false,
          controller: bannerSwiperController,
        ),
      ),
    );
  }

  //头部appbar
  Widget _renderTop() {
    return Container(
      height: ScreenUtil.getInstance().setWidth(50) +
          MediaQuery.of(context).padding.top,
      color: AppColors.appDarkBlue,
      child: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
          left: ScreenUtil.getInstance().setWidth(10),
          right: ScreenUtil.getInstance().setWidth(10),
        ),
        child: Row(
          //中间空出来
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            GestureDetector(
              child: Text(
                AppStrings.cityName,
                style: AppStyles.whiteText14,
              ),
              onTap: () {
                AppRoutes.router
                    .navigateTo(context, Routes.citySelect)
                    .then((value) {
                  if (value is String && value != null && value != "") {
                    setState(() {
                      AppStrings.cityName = value;
                    });
                  }
                });
              },
            ),
            Icon(
              Icons.search,
              color: AppColors.white,
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true; //keep main page ,avoid rebuild

  @override
  void dispose() {
    super.dispose();
    bannerSwiperController.stopAutoplay();
    commentSwiperController.stopAutoplay();
    bannerSwiperController.dispose();
    commentSwiperController.dispose();
  }
}
