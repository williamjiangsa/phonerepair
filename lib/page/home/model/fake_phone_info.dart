import 'package:fastrepaire/net/model/colors_and_repair_items_entity.dart';
import 'package:fastrepaire/net/model/comment_entity.dart';
import 'package:fastrepaire/values/colors.dart';
import 'package:fastrepaire/values/strings.dart';
import 'package:flutter/material.dart';

//机型信息页面本地数据
class FakePhoneInfoData {
  //机型
  String phoneName;

  //颜色
  List<PhoneColor> phoneColors = [];

  //修理问题
  String repairName;

  //可选修理项目
  List<RepairItem> repairItems = [];

  //好评数量
  String commentCountStr;

  //好评率
  String posRate;

  //好评标签
  List<CommentTag> commentTags = [];

  //好评列表

  List<Comment> commentList = [];

  //价格
  double price;

  //市场价
  double marketPrice;

  void init() {
    phoneName = "";
//    phoneColors.add(PhoneColor("1", "金色", Colors.orangeAccent));
//    phoneColors.add(PhoneColor("2", "银色", Colors.grey));
//    phoneColors.add(PhoneColor("3", "黑色", Colors.black));
//    phoneColors.add(PhoneColor("4", "红色", Colors.red));
//    phoneColors.add(PhoneColor("5", "灰色", Colors.blueGrey));
    repairName = "屏幕问题";
//    repairItems.add(
//        RepairItem("1", "折价换屏（官方品质）", "适用于外屏破碎显示或触摸正常", 299.0, "保修期:180天"));
//    repairItems.add(
//        RepairItem("2", "更换全屏（官方品质）", "适用于内屏破碎显示或触摸不正常", 399.0, "保修期:180天"));
//    repairItems.add(
//        RepairItem("3", "折价换屏（官方品质）1", "适用于外屏破碎显示或触摸正常", 299.0, "保修期:180天"));
//    repairItems.add(
//        RepairItem("4", "更换全屏（官方品质）1", "适用于内屏破碎显示或触摸不正常", 399.0, "保修期:180天"));
//    commentCountStr = "33W";
//    posRate = 99.5;
    commentTags.add(CommentTag("1", "工程师傅热情"));
    commentTags.add(CommentTag("2", "性价比高"));
    commentTags.add(CommentTag("3", "响应快"));
    commentTags.add(CommentTag("4", "准时上门"));
    commentTags.add(CommentTag("5", "着装整齐"));
    commentTags.add(CommentTag("6", "有礼貌"));
    commentTags.add(CommentTag("7", "工程技术棒"));
    commentTags.add(CommentTag("8", "价格合理"));
    commentTags.add(CommentTag("9", "免费贴膜"));
//    commentList.add(Comment(
//        "1",
//        "小白",
//        5,
//        "http://b-ssl.duitang.com/uploads/item/201805/13/20180513224039_tgfwu.png",
//        "老哥技术很棒！！！",
//        "苹果 iphone7 屏幕问题",
//        "2019-08-10"));
//    commentList.add(Comment(
//        "2",
//        "小红",
//        5,
//        "http://b-ssl.duitang.com/uploads/item/201805/13/20180513224039_tgfwu.png",
//        "师傅热情专业度很高！！！",
//        "苹果 iphone8 电池问题",
//        "2019-07-10"));
//    price = 299.0;
//    marketPrice = 369.0;
  }

  void convertColorsAndRepairItems(ColorsAndRepairItemsData data) {
    phoneColors.clear();
    if (data.color != null) {
      data.color.forEach((color) {
        Color currentColor = AppColors.transparent;
        try {
          currentColor = Color(int.parse(color.colorHex));
        } catch (e) {}
        phoneColors.add(PhoneColor(
            color.colorId ?? "", color.colorName ?? "", currentColor));
      });
    }
    repairItems.clear();
    if (data.solution != null) {
      data.solution.forEach((solution) {
        phoneName = solution.phoneName;
        posRate = solution.problemRate;
        commentCountStr = solution.problemateTimes;
        repairItems.add(RepairItem(
            solution.problemId ?? "",
            solution.problemName ?? "",
            solution.problemExplain ?? "",
            solution.problemPrice ?? "",
            solution.problemYPrice ?? "",
            "${AppStrings.protectPeriod}${solution.problemBaoxiu ?? ""}"));
      });
    }
  }

  void convertComment(List<CommentData> data) {
    commentList.clear();
    if (data != null) {
      data.forEach((item) {
//        this.commentId,
//        this.commentUserName,
//        this.rateStar,
//        this.commentUserAvatar,
//        this.commentContent,
//        this.commentDetail,
//        this.commentDate);
        int score = 5;
        try {
          score = int.parse(item.commentScore);
        } catch (e) {}
        commentList.add(Comment(
          item.commentId,
          item.commentUsername ?? "",
          score,
          "http://b-ssl.duitang.com/uploads/item/201805/13/20180513224039_tgfwu.png",
          item.commentDetail ?? "",
          (item.commentPhone ?? "") + " " + (item.commentProname ?? ""),
          item.commentTime ?? "",
        ));
      });
    }
  }
}

class Comment {
  //唯一id
  String commentId;

  //评价人
  String commentUserName;

  //好评星星
  int rateStar;

  //评价人头像
  String commentUserAvatar;

  //评价内容
  String commentContent;

  //细节 问题
  String commentDetail;

  //评价日期
  String commentDate;

  Comment(
      this.commentId,
      this.commentUserName,
      this.rateStar,
      this.commentUserAvatar,
      this.commentContent,
      this.commentDetail,
      this.commentDate);
}

class CommentTag {
  //唯一id
  String tagId;

  //名字
  String tagName;

  CommentTag(this.tagId, this.tagName);
}

class RepairItem {
  //唯一id
  String repairId;

  //名字
  String repairName;

  //描述
  String repairDesc;

  //价格
  String price;

  //原价 市场价
  String yPrice;

  //保修时间
  String period;


  RepairItem(this.repairId, this.repairName, this.repairDesc, this.price,
      this.yPrice, this.period);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['repairId'] = this.repairId;
    data['repairName'] = this.repairName;
    data['repairDesc'] = this.repairDesc;
    data['price'] = this.price;
    data['yPrice'] = this.yPrice;
    data['period'] = this.period;
    return data;
  }

  RepairItem.fromJson(Map<String, dynamic> json) {
    repairId = json['repairId'];
    repairName = json['repairName'];
    repairDesc = json['repairDesc'];
    price = json['price'];
    yPrice = json['yPrice'];
    period = json['period'];
  }
}

class PhoneColor {
  //唯一id
  String colorId;

  //名字
  String colorName;

  //颜色
  Color color;

  PhoneColor(this.colorId, this.colorName, this.color);
}
