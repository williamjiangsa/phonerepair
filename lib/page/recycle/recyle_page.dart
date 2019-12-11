import 'package:cached_network_image/cached_network_image.dart';
import 'package:fastrepaire/routes/my_routes.dart';
import 'package:fastrepaire/routes/routes.dart';
import 'package:fastrepaire/utils/common_util.dart';
import 'package:fastrepaire/values/colors.dart';
import 'package:fastrepaire/values/strings.dart';
import 'package:fastrepaire/widget/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import '../../values/styles.dart';
import 'model/fake_recycle_data.dart';

//回收模块
class RecyclePage extends StatefulWidget {
  @override
  _RecyclePageState createState() => _RecyclePageState();
}

class _RecyclePageState extends State<RecyclePage>
    with AutomaticKeepAliveClientMixin {
  SwiperController bannerSwiperController;
  SwiperController commentSwiperController;

  FakeRecycleData recycleData;

  @override
  void initState() {
    super.initState();
    recycleData = FakeRecycleData();
    recycleData.init();
    bannerSwiperController = SwiperController();
    commentSwiperController = SwiperController();
    bannerSwiperController.startAutoplay();
    commentSwiperController.startAutoplay();
  }

  @override
  void dispose() {
    super.dispose();
    bannerSwiperController.stopAutoplay();
    commentSwiperController.stopAutoplay();
    bannerSwiperController.dispose();
    commentSwiperController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: <Widget>[
        _renderTop(),
        Expanded(
          child: ListView(
            padding: EdgeInsets.all(ScreenUtil.getInstance().setWidth(20)),
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              _renderBanner(),
              _renderProcess(),
              _renderPreButton(),
              _renderHotPhone(),
              _renderHotPad(),
              _renderServiceInfo(),
              _renderUserComment(),
            ],
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;

  //top appbar
  _renderTop() {
    return Container(
      height: ScreenUtil.getInstance().setWidth(50) +
          MediaQuery.of(context).padding.top,
      color: AppColors.appDarkBlue,
      child: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
          left: ScreenUtil.getInstance().setWidth(10),
          right: ScreenUtil.getInstance().setWidth(20),
        ),
        child: Row(
          textDirection: TextDirection.rtl,
          children: <Widget>[
            GestureDetector(
              child: Icon(
                Icons.shopping_cart,
                color: AppColors.white,
              ),
              onTap: () {},
            ),
            Padding(
              padding:
                  EdgeInsets.only(right: ScreenUtil.getInstance().setWidth(20)),
              child: Icon(
                Icons.search,
                color: AppColors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  //轮播
  _renderBanner() {
    return Container(
      height: ScreenUtil.getInstance().setWidth(150),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CommonUtils.isEmpty(recycleData.bannerPics[index])
                ? Image.asset(
                    "images/default.png",
                    fit: BoxFit.cover,
                  )
                : CachedNetworkImage(
                    imageUrl: recycleData.bannerPics[index],
                    placeholder: (context, url) => Image.asset(
                      "images/default.png",
                      fit: BoxFit.contain,
                    ),
                    errorWidget: (context, url, error) => Image.asset(
                      "images/default.png",
                      fit: BoxFit.contain,
                    ),
                    fit: BoxFit.cover,
                  ),
          );
        },
        itemCount: recycleData.bannerPics.length,
        duration: AppStrings.bannerDuration,
        pagination: SwiperPagination(
            builder: DotSwiperPaginationBuilder(
          color: AppColors.grey,
          activeColor: AppColors.black,
        )),
        scrollDirection: Axis.horizontal,
        autoplay: false,
        loop: false,
        controller: bannerSwiperController,
      ),
    );
  }

  //流程图
  _renderProcess() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10),
        color: AppColors.white,
      ),
      margin:
          EdgeInsets.symmetric(vertical: ScreenUtil.getInstance().setWidth(15)),
      padding:
          EdgeInsets.symmetric(vertical: ScreenUtil.getInstance().setWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _renderProcessItem(
              "images/calculator.png", AppStrings.expressEstimate),
          _renderProcessItem("images/home.png", AppStrings.recycleHome),
          _renderProcessItem("images/fund.png", AppStrings.fastPaid),
        ],
      ),
    );
  }

  _renderProcessItem(String imgUrl, String text) {
    return Column(
      children: <Widget>[
        Image.asset(
          imgUrl,
          width: ScreenUtil.getInstance().setWidth(30),
          height: ScreenUtil.getInstance().setWidth(30),
        ),
        Padding(
          child: Text(
            text,
            style: AppStyles.greyText12,
          ),
          padding: EdgeInsets.only(top: ScreenUtil.getInstance().setWidth(10)),
        ),
      ],
    );
  }

  //估价按钮
  _renderPreButton() {
    return GestureDetector(
      child: Container(
        height: ScreenUtil.getInstance().setWidth(40),
        margin: EdgeInsets.symmetric(
            vertical: ScreenUtil.getInstance().setWidth(10)),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
          color: AppColors.appBlue,
        ),
        child: Center(
          child: Text(
            AppStrings.freeEstimate,
            style: AppStyles.whiteText14,
          ),
        ),
      ),
      onTap: () {
        toRecyclerPhoneListPage(0);
      },
    );
  }

  //热门手机
  _renderHotPhone() {
    return Column(
      children: <Widget>[
        _renderHotHeader(
          AppStrings.hotRecylePhone,
          () {
            toRecyclerPhoneListPage(0);
          },
        ),
        Container(
          margin: EdgeInsets.symmetric(
              vertical: ScreenUtil.getInstance().setWidth(10)),
          height: ScreenUtil.getInstance().setWidth(120),
          child: ListView.builder(
            padding: EdgeInsets.all(0),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return _renderHotPhoneItem(recycleData.hotPhones[index]);
            },
            itemCount: recycleData.hotPhones.length,
          ),
        ),
      ],
    );
  }

  _renderHotPhoneItem(HotDeviceInfo info) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10),
        color: AppColors.white,
      ),
      margin: EdgeInsets.symmetric(
          horizontal: ScreenUtil.getInstance().setWidth(10)),
      padding: EdgeInsets.all(ScreenUtil.getInstance().setWidth(10)),
      child: Column(
        children: <Widget>[
          Expanded(
            child: CommonUtils.isEmpty(info.devicePic)
                ? Image.asset(
                    "images/default.png",
                    fit: BoxFit.contain,
                  )
                : CachedNetworkImage(
                    imageUrl: info.devicePic,
                    placeholder: (context, url) => Image.asset(
                      "images/default.png",
                      width: ScreenUtil.getInstance().setWidth(30),
                      height: ScreenUtil.getInstance().setWidth(45),
                      fit: BoxFit.fill,
                    ),
                    errorWidget: (context, url, error) => Image.asset(
                      "images/default.png",
                      width: ScreenUtil.getInstance().setWidth(30),
                      height: ScreenUtil.getInstance().setWidth(45),
                      fit: BoxFit.fill,
                    ),
                    fit: BoxFit.contain,
                  ),
          ),
          Text(
            info.deviceName ?? "",
            style: AppStyles.blackText14,
          ),
          Padding(
            child: Row(
              children: <Widget>[
                Text(
                  AppStrings.mostRecycle,
                  style: AppStyles.blackText12,
                ),
                Text(
                  " " + AppStrings.moneySymbol + info.devicePrice.toString(),
                  style: AppStyles.blueText12,
                ),
              ],
            ),
            padding:
                EdgeInsets.only(top: ScreenUtil.getInstance().setWidth(10)),
          ),
        ],
      ),
    );
  }

  //热门平板
  _renderHotPad() {
    return Column(
      children: <Widget>[
        _renderHotHeader(
          AppStrings.hotRecylePad,
          () {
            toRecyclerPhoneListPage(1);
          },
        ),
        ListView.builder(
          padding: EdgeInsets.all(0),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return _renderHotPadItem(recycleData.hotPads[index]);
          },
          itemCount: recycleData.hotPads.length,
        ),
      ],
    );
  }

  _renderHotPadItem(HotDeviceInfo info) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10),
        color: AppColors.white,
      ),
      margin:
          EdgeInsets.symmetric(vertical: ScreenUtil.getInstance().setWidth(10)),
      padding: EdgeInsets.all(ScreenUtil.getInstance().setWidth(10)),
      child: Row(
        children: <Widget>[
          Expanded(
            child: CommonUtils.isEmpty(info.devicePic)
                ? Image.asset(
                    "images/default.png",
                    fit: BoxFit.contain,
                  )
                : CachedNetworkImage(
                    imageUrl: info.devicePic,
                    placeholder: (context, url) => Image.asset(
                      "images/default.png",
                      width: ScreenUtil.getInstance().setWidth(30),
                      fit: BoxFit.fill,
                    ),
                    errorWidget: (context, url, error) => Image.asset(
                      "images/default.png",
                      width: ScreenUtil.getInstance().setWidth(30),
                      fit: BoxFit.fill,
                    ),
                    fit: BoxFit.contain,
                  ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  info.deviceName ?? "",
                  style: AppStyles.blackText14,
                ),
                Padding(
                  child: Row(
                    children: <Widget>[
                      Text(
                        AppStrings.mostRecycle,
                        style: AppStyles.blackText12,
                      ),
                      Text(
                        " " +
                            AppStrings.moneySymbol +
                            info.devicePrice.toString(),
                        style: AppStyles.blueText12,
                      ),
                    ],
                  ),
                  padding: EdgeInsets.only(
                      top: ScreenUtil.getInstance().setWidth(10)),
                ),
              ],
            ),
            flex: 2,
          ),
          Expanded(
            child: Container(
              height: ScreenUtil.getInstance().setWidth(20),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(20),
                border: new Border.all(width: 1, color: AppColors.appBlue),
                color: AppColors.white,
              ),
              child: Center(
                child: Text(
                  AppStrings.recycleNow,
                  style: AppStyles.blueText12,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  //跳转回收机器列表页面 pos 0 手机 pos1 平板
  toRecyclerPhoneListPage(int pos) {
    AppRoutes.router
        .navigateTo(context, Routes.phoneList + "?${AppStrings.tabPos}=$pos");
  }

  //热门头header
  _renderHotHeader(String text, VoidCallback callback) {
    return Container(
      height: ScreenUtil.getInstance().setWidth(40),
      margin: EdgeInsets.only(top: ScreenUtil.getInstance().setWidth(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            text,
            style: AppStyles.blueText14,
          ),
          GestureDetector(
            child: Text(
              AppStrings.hotMore,
              style: AppStyles.greyText12,
            ),
            onTap: callback,
          ),
        ],
      ),
    );
  }

  //服务方式
  _renderServiceInfo() {
    return Column(
      children: <Widget>[
        _renderCommonHeader(AppStrings.serviceMethod),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(10),
            color: AppColors.white,
          ),
          padding: EdgeInsets.all(ScreenUtil.getInstance().setWidth(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Image.asset(
                      "images/input.png",
                      width: ScreenUtil.getInstance().setWidth(30),
                      height: ScreenUtil.getInstance().setWidth(30),
                    ),
                    Image.asset(
                      "images/store.png",
                      width: ScreenUtil.getInstance().setWidth(30),
                      height: ScreenUtil.getInstance().setWidth(30),
                    ),
                    Image.asset(
                      "images/express.png",
                      width: ScreenUtil.getInstance().setWidth(30),
                      height: ScreenUtil.getInstance().setWidth(30),
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(
                    vertical: ScreenUtil.getInstance().setWidth(10)),
              ),
              Container(
                height: ScreenUtil.getInstance().setWidth(30),
                child: Center(
                  child: Text(
                    AppStrings.recycleStore,
                    style: AppStyles.blueText14,
                  ),
                ),
              ),
              Text(
                AppStrings.recycleProcess,
                style: AppStyles.blackText12,
              ),
            ],
          ),
        ),
      ],
    );
  }

  //用户评论
  _renderUserComment() {
    return Column(
      children: <Widget>[
        _renderCommonHeader(AppStrings.userComment),
        Container(
          height: ScreenUtil.getInstance().setWidth(200),
          width: double.infinity,
          child: Swiper(
            itemBuilder: (BuildContext context, int index) {
              return Container(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.white,
                ),
                padding: EdgeInsets.all(ScreenUtil.getInstance().setWidth(10)),
                child: Column(
                  children: <Widget>[
                    _renderCommentItem(index, 0),
                    _renderCommentItem(index, 1),
                    _renderCommentItem(index, 2),
                  ],
                ),
              );
            },
            itemCount: (recycleData.commentItems.length / 3).ceil(),
            duration: AppStrings.commentDuration,
            scrollDirection: Axis.horizontal,
            autoplay: false,
            loop: false,
            controller: commentSwiperController,
          ),
        ),
      ],
    );
  }

  Widget _renderCommentItem(int page, int index) {
    int currentIndex = page * 3 + index;
    Comment comment = recycleData.commentItems[index];
    return Expanded(
      child: currentIndex < recycleData.commentItems.length
          ? Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      comment.userName ?? "",
                      style: AppStyles.blueText12,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: ScreenUtil.getInstance().setWidth(10)),
                        child: Text(
                          comment.userPhone ?? "",
                          style: AppStyles.blackText10,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                    ),
                    Text(
                      comment.detail ?? "",
                      style: AppStyles.greyText10,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                Text(
                  comment.content ?? "",
                  style: AppStyles.blackText12,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                index != 2 ? CommonDivider() : Container(),
              ],
            )
          : Container(),
    );
  }

  //热门头header
  _renderCommonHeader(String text) {
    return Container(
      height: ScreenUtil.getInstance().setWidth(40),
      margin: EdgeInsets.only(top: ScreenUtil.getInstance().setWidth(10)),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: AppStyles.blueText14,
        ),
      ),
    );
  }
}
