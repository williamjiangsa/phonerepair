import 'package:fastrepaire/routes/my_routes.dart';
import 'package:fastrepaire/values/colors.dart';
import 'package:fastrepaire/values/strings.dart';
import 'package:fastrepaire/values/styles.dart';
import 'package:fastrepaire/widget/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'model/fake_city_select_data.dart';

class SelectCityPage extends StatefulWidget {
  @override
  _SelectCityPageState createState() => _SelectCityPageState();
}

class _SelectCityPageState extends State<SelectCityPage> {
  FakeCitySelectData fakeCitySelectData;

  @override
  void initState() {
    super.initState();
    fakeCitySelectData = FakeCitySelectData();
    fakeCitySelectData.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          CommonAppBar(AppStrings.citySelectTitle),
          renderTop(),
          Expanded(
            child: _renderList(),
          )
        ],
      ),
    );
  }

  renderTop() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(ScreenUtil.getInstance().setWidth(10)),
          child: Text(
            AppStrings.cityCurrent,
            style: AppStyles.greyText12,
          ),
        ),
        CommonDivider(),
        Container(
          child: Padding(
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.location_on,
                  color: AppColors.appBlue,
                ),
                Expanded(
                  child: Text(
                    AppStrings.cityName,
                    style: AppStyles.blackText12,
                  ),
                )
              ],
            ),
            padding: EdgeInsets.all(ScreenUtil.getInstance().setWidth(10)),
          ),
          color: AppColors.white,
        ),
        CommonDivider(),
        Padding(
          padding: EdgeInsets.all(ScreenUtil.getInstance().setWidth(10)),
          child: Text(
            AppStrings.cityRepairTips,
            style: AppStyles.greyText10,
          ),
        ),
      ],
    );
  }

  _renderList() {
    return ListView.separated(
      padding: EdgeInsets.all(0),
      itemBuilder: (context, index) {
        return GestureDetector(
          child: Container(
            child: Padding(
              child: Text(
                fakeCitySelectData.cityLists[index]??"",
                style: AppStyles.blackText12,
              ),
              padding: EdgeInsets.symmetric(
                vertical: ScreenUtil.getInstance().setWidth(8),
                horizontal: ScreenUtil.getInstance().setWidth(10),
              ),
            ),
            color: AppColors.white,
          ),
          onTap: () {
            Navigator.pop(context, fakeCitySelectData.cityLists[index]);
          },
        );
      },
      separatorBuilder: (context, index) {
        return Padding(
          child: CommonDivider(),
          padding: EdgeInsets.symmetric(
            horizontal: ScreenUtil.getInstance().setWidth(10),
          ),
        );
      },
      itemCount: fakeCitySelectData.cityLists.length,
    );
  }
}
