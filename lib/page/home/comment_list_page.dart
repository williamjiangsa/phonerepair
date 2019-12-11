import 'package:fastrepaire/net/manager/app_api.dart';
import 'package:fastrepaire/net/manager/result_data.dart';
import 'package:fastrepaire/net/model/comment_entity.dart';
import 'package:fastrepaire/net/net_constant.dart';
import 'package:fastrepaire/values/colors.dart';
import 'package:fastrepaire/values/strings.dart';
import 'package:fastrepaire/values/styles.dart';
import 'package:fastrepaire/widget/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//首页所有用户评论页面
class CommonListPage extends StatefulWidget {
  @override
  _CommonListPageState createState() => _CommonListPageState();
}

class _CommonListPageState extends State<CommonListPage> {
  List<CommentData> commentsData = [];

  @override
  void initState() {
    super.initState();
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
        commentsData.clear();
        commentsData.addAll(entity.data ?? []);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          CommonAppBar(AppStrings.userComment),
          Expanded(
            child: _renderList(),
          ),
        ],
      ),
    );
  }

  _renderList() {
    return ListView.builder(
      padding: EdgeInsets.all(0),
      itemBuilder: (context, index) {
        CommentData comment = commentsData[index];
        int score = 5;
        try {
          score = int.parse(comment.commentScore);
        } catch (e) {}
        return Container(
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(10),
            color: AppColors.white,
          ),
          margin: EdgeInsets.symmetric(
              horizontal: ScreenUtil.getInstance().setWidth(15),
              vertical: ScreenUtil.getInstance().setWidth(10)),
          child: Padding(
            padding: EdgeInsets.all(ScreenUtil.getInstance().setWidth(5)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              child: Text(
                                comment.commentUsername ?? "",
                                style: AppStyles.blackText14,
                              ),
                              padding: EdgeInsets.only(
                                  bottom: ScreenUtil.getInstance().setWidth(5)),
                            ),
                            MyRatingBar(
                              starSize: ScreenUtil.getInstance().setWidth(15),
                              markedCount: score,
                            ),
                          ],
                        ),
                      ),
                      Text(
                        comment.commentTime ?? "",
                        style: AppStyles.greyText12,
                      ),
                    ],
                  ),
                  padding: EdgeInsets.symmetric(
                      vertical: ScreenUtil.getInstance().setWidth(5)),
                ),
                Text(
                  comment.commentDetail ?? "",
                  style: AppStyles.blackText12,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: ScreenUtil.getInstance().setWidth(5)),
                  child: CommonDivider(),
                ),
                Row(
                  children: <Widget>[
                    Image.asset(
                      "images/phone.png",
                      width: ScreenUtil.getInstance().setWidth(15),
                      height: ScreenUtil.getInstance().setWidth(15),
                    ),
                    Text(
                      (comment.commentPhone ?? "") +
                          " " +
                          (comment.commentProname ?? ""),
                      style: AppStyles.blackText12,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
      itemCount: commentsData.length,
    );
  }
}
