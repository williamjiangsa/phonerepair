import 'package:fastrepaire/values/colors.dart';
import 'package:fastrepaire/values/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      color: AppColors.dividerBlack,
    );
  }
}

class CommonAppBar extends StatelessWidget {
  final String titleText;

  CommonAppBar(this.titleText);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).padding.top +
              ScreenUtil.getInstance().setWidth(44),
          color: AppColors.appDarkBlue,
          child: Padding(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: ScreenUtil.getInstance().setWidth(44),
              color: AppColors.appDarkBlue,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    child: Container(
                      width: ScreenUtil.getInstance().setWidth(30),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.arrow_back_ios,
                            color: AppColors.white,
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        titleText,
                        maxLines: 1,
                        style: AppStyles.whiteText14,
                      ),
                    ),
                  ),
                  Container(
                    width: ScreenUtil.getInstance().setWidth(30),
                  ),
                ],
              ),
            ),
            padding: EdgeInsets.only(
              left: ScreenUtil.getInstance().setWidth(10),
              right: ScreenUtil.getInstance().setWidth(10),
              top: MediaQuery.of(context).padding.top,
            ),
          ),
        ),
      ],
    );
  }
}

class MyRatingBar extends StatelessWidget {
  final int startCount;
  final int markedCount;
  final double starSize;
  final Color markedColor;
  final Color commonColor;

  MyRatingBar({
    this.startCount = 5,
    this.markedCount = 5,
    this.starSize = 15,
    this.markedColor = AppColors.appBlue,
    this.commonColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: _buildStarIcons(),
    );
  }

  _buildStarIcons() {
    List<Widget> children = [];
    for (int i = 0; i < markedCount; i++) {
//      if (i < markedCount) {
      children.add(Padding(
        padding: EdgeInsets.all(ScreenUtil.getInstance().setWidth(2)),
        child: Icon(
          Icons.star,
          color: markedColor,
          size: starSize,
        ),
      ));
//      }
//      else {
//        children.add(Icon(
//          Icons.star_border,
//          color: commonColor,
//          size: starSize,
//        ));
//      }
    }
    return children;
  }
}
