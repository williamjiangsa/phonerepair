//首页内容本地数据对象
import 'package:fastrepaire/net/model/banner_home_entity.dart';
import 'package:fastrepaire/net/model/comment_entity.dart';

// const String banner1 =
//     "https://source1.suddenfix.com/banner/19qx/banner-app.jpg";

// const String banner2 =
//     "https://source1.suddenfix.com/miniprogram/banner_sendrepair.png";

// const String banner3 =
//     "https://source1.suddenfix.com/miniprogram/indexBanner0004.png";

// const String banner4 =
//     "https://source1.suddenfix.com/miniprogram/indexBanner01.png";

// const String banner5 =
//     "https://source1.suddenfix.com/miniprogram/indexBanner02.png";

// const String banner6 =
//     "https://source1.suddenfix.com/miniprogram/indexBanner003.png";

const String repairName1 = "Screen";
const String repairName2 = "Back Cover";
const String repairName3 = "Battery";
const String repairName4 = "Sound";
const String repairName5 = "Button";
const String repairName6 = "Signal";
const String repairName7 = "Sensor";
const String repairName8 = "Other";

const String repairUrl1 = "images/iconScreen.png";
const String repairUrl2 = "images/iconBackCover.png";

const String repairUrl3 = "images/iconBattery.png";

const String repairUrl4 = "images/iconSound.png";

const String repairUrl5 = "images/iconKey.png";

const String repairUrl6 = "images/iconSignal.png";

const String repairUrl7 = "images/iconSensor.png";

const String repairUrl8 = "images/iconOther.png";

const String commentContent1 =
    "维修了挺多家的，没有一家真正把我手机修好了，抱着最后的希望给闪电修的工程师维修，就给修好了，这技术和质量不错哦!";
const String commentUserName1 = "许*";
const String commentDate1 = "2019-08-10";
const String commentDetail1 = "华为Mate9 · 更换屏幕";

const String commentContent2 =
    "手机扩容到128G，也不卡了，很流畅！还能用两年再考虑换新机了，服务很好，顺丰包邮。以后有机会推荐给朋友！非常满意！";
const String commentUserName2 = "李*";
const String commentDate2 = "2019-07-19";
const String commentDetail2 = "iPhone 7 · 内存升级";
const String homeAdUrl =
    "https://source1.suddenfix.com/miniprogram/advantage1.png";

class FakeHomeData {
  //轮播图
  List<String> bannerPics = [];

  //问题项目
  List<RepairItem> repairItems = [];

  //广告位置
  String adUrl = "";

  //评论内容
  List<Comment> commentItems = [];

  void init() {
//    _initbanner();
    _initRepairItems();
    adUrl = homeAdUrl;
//    _initCommentItems();
  }

  // void _initbanner() {
  //   bannerPics.add(banner1);
  //   bannerPics.add(banner2);
  //   bannerPics.add(banner3);
  //   bannerPics.add(banner4);
  //   bannerPics.add(banner5);
  //   bannerPics.add(banner6);
  // }

  void _initRepairItems() {
    repairItems.add(RepairItem("1", repairUrl1, repairName1));
    repairItems.add(RepairItem("3", repairUrl2, repairName2));
    repairItems.add(RepairItem("2", repairUrl3, repairName3));
    repairItems.add(RepairItem("4", repairUrl4, repairName4));
    repairItems.add(RepairItem("5", repairUrl5, repairName5));
    repairItems.add(RepairItem("6", repairUrl6, repairName6));
    repairItems.add(RepairItem("7", repairUrl7, repairName7));
    repairItems.add(RepairItem("*", repairUrl8, repairName8));
  }

  void _initCommentItems() {
    commentItems.add(Comment(
        commentUserName1, 0, commentDate1, commentContent1, commentDetail1));
    commentItems.add(Comment(
        commentUserName2, 0, commentDate2, commentContent2, commentDetail2));
  }

  void convertBanner(List<BannerHomeData> data) {
    bannerPics.clear();
    if (data != null) {
      data.forEach((banner) {
        bannerPics.add(banner.adPic);
      });
    }
  }

  void convertComment(List<CommentData> data) {
    commentItems.clear();
    if (data != null) {
      data.forEach((item) {
        int score = 5;
        try {
          score = int.parse(item.commentScore);
        } catch (e) {}
        commentItems.add(Comment(
            item.commentUsername ?? "",
            score,
            item.commentTime ?? "",
            item.commentDetail ?? "",
            (item.commentPhone ?? "") + " " + (item.commentProname ?? "")));
      });
    }
  }
}

class RepairItem {
  //问题id
  String itemId;

  //问题 图片
  String itemUrl;

  //问题 名字
  String itemName;

  RepairItem(this.itemId, this.itemUrl, this.itemName);
}

class Comment {
  //comment user name
  String userName;

  //comment rate star
  int rate;

  //comment date
  String date;

  //comment content
  String content;

  //content detail (mobile type ,repaird item included)
  String detail;

  Comment(this.userName, this.rate, this.date, this.content, this.detail);
}
