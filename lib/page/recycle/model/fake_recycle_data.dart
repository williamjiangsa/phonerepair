//首页内容本地数据对象
const String banner1 =
    "https://source1.suddenfix.com/banner/19qx/banner-app.jpg";

const String banner2 =
    "https://source1.suddenfix.com/miniprogram/banner_sendrepair.png";

const String banner3 =
    "https://source1.suddenfix.com/miniprogram/indexBanner0004.png";

const String commentContent1 =
    "维修了挺多家的，没有一家真正把我手机修好了，抱着最后的希望给闪电修的工程师维修，就给修好了，这技术和质量不错哦!";
const String commentUserName1 = "许*";
const String commentUserPhone1 = "150****8899";
const String commentDetail1 = "华为Mate9 · 更换屏幕";

const String commentContent2 =
    "手机扩容到128G，也不卡了，很流畅！还能用两年再考虑换新机了，服务很好，顺丰包邮。以后有机会推荐给朋友！非常满意！";
const String commentUserName2 = "李*";
const String commentUserPhone2 = "138****8855";
const String commentDetail2 = "iPhone 7 · 内存升级";

class FakeRecycleData {
  //轮播图
  List<String> bannerPics = [];

  //评论内容
  List<Comment> commentItems = [];

  //热门手机
  List<HotDeviceInfo> hotPhones = [];

  //热门平板
  List<HotDeviceInfo> hotPads = [];

  void init() {
    _initbanner();
    _initCommentItems();
    _initHotPhones();
    _initHotPads();
  }

  void _initHotPhones() {
    hotPhones.add(HotDeviceInfo("1", "荣耀v10", "https://ss1.baidu.com/6ONXsjip0QIZ8tyhnq/it/u=4142856127,1227397880&fm=58", 699.0));
    hotPhones.add(HotDeviceInfo("2", "OPPO RENO", "https://ss1.baidu.com/6ONXsjip0QIZ8tyhnq/it/u=4142856127,1227397880&fm=58", 1699.0));
    hotPhones.add(HotDeviceInfo("3", "小米9", "https://ss1.baidu.com/6ONXsjip0QIZ8tyhnq/it/u=4142856127,1227397880&fm=58", 1699.0));
    hotPhones.add(HotDeviceInfo("4", "IPHONE 7", "https://ss1.baidu.com/6ONXsjip0QIZ8tyhnq/it/u=4142856127,1227397880&fm=58", 999.0));
  }

  void _initHotPads() {
    hotPads.add(HotDeviceInfo("21", "ipad2", "https://ss0.baidu.com/73F1bjeh1BF3odCf/it/u=2101442991,2499765582&fm=85&s=03B0E922CD35329A4BB1D911030070E3", 699.0));
    hotPads.add(HotDeviceInfo("22", "MI PAD", "https://ss0.baidu.com/73F1bjeh1BF3odCf/it/u=2101442991,2499765582&fm=85&s=03B0E922CD35329A4BB1D911030070E3", 1699.0));
    hotPads.add(HotDeviceInfo("23", "HUAWEI M5", "https://ss0.baidu.com/73F1bjeh1BF3odCf/it/u=2101442991,2499765582&fm=85&s=03B0E922CD35329A4BB1D911030070E3", 1699.0));
  }

  void _initbanner() {
    bannerPics.add(banner1);
    bannerPics.add(banner2);
    bannerPics.add(banner3);
  }

  void _initCommentItems() {
    commentItems.add(Comment(
        commentUserName1, commentUserPhone1, commentContent1, commentDetail1));
    commentItems.add(Comment(
        commentUserName2,commentUserPhone2, commentContent2, commentDetail2));
    commentItems.add(Comment(
        commentUserName1, commentUserPhone1, commentContent1, commentDetail1));
    commentItems.add(Comment(
        commentUserName2,commentUserPhone2, commentContent2, commentDetail2));
    commentItems.add(Comment(
        commentUserName1, commentUserPhone1, commentContent1, commentDetail1));
    commentItems.add(Comment(
        commentUserName2,commentUserPhone2, commentContent2, commentDetail2));
    commentItems.add(Comment(
        commentUserName1, commentUserPhone1, commentContent1, commentDetail1));
    commentItems.add(Comment(
        commentUserName2,commentUserPhone2, commentContent2, commentDetail2));
  }
}

class HotDeviceInfo {
  //唯一标识id
  String id;

  //热门机器名字
  String deviceName;

  //机器图片
  String devicePic;

  //回收价格
  double devicePrice;

  HotDeviceInfo(this.id, this.deviceName, this.devicePic, this.devicePrice);
}

class Comment {
  //comment user name
  String userName;


  //comment phone
  String userPhone;

  //comment content
  String content;

  //content detail (mobile type ,repaird item included)
  String detail;

  Comment(this.userName, this.userPhone, this.content, this.detail);
}
