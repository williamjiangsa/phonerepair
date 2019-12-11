import 'package:fastrepaire/page/recycle/recyle_page.dart';
import 'package:fastrepaire/values/colors.dart';
import 'package:fastrepaire/values/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'home/home_page.dart';
import 'me/me_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => new _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex;
  List<BottomNavigationBarItem> bottomNavigationBarItems;

  PageController _pageViewController;

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
    _initBottomNavigationBarItems();
    _pageViewController = new PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    super.dispose();
    _pageViewController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 320, height: 640)..init(context);
    return Scaffold(
      body: PageView(
        controller: _pageViewController,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          HomePage(),
          RecyclePage(),
          // Container(
          //   color: Colors.orange,
          // ),
          MyPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: bottomNavigationBarItems,
        type: BottomNavigationBarType.fixed,
        fixedColor: AppColors.appBlue,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            _pageViewController.jumpToPage(_currentIndex);
          });
        },
      ),
    );
  }

  //创建底部导航切换
  void _initBottomNavigationBarItems() {
    bottomNavigationBarItems = [
      _buildBottomBarItemView("images/repair.png", "images/repair_select.png",
          AppStrings.tabRepair, 20, 20),
      _buildBottomBarItemView("images/phone.png", "images/phone_select.png",
          AppStrings.tabRecycle, 20, 20),
      // _buildBottomBarItemView("images/community.png",
      //     "images/community_select.png", AppStrings.tabCommunity, 20, 20),
      _buildBottomBarItemView(
          "images/me.png", "images/me_select.png", AppStrings.tabMime, 20, 20),
    ];
  }

  _buildBottomBarItemView(String iconUrl, String selectedIconUrl, String text,
      double width, double height) {
    return BottomNavigationBarItem(
        icon: Image.asset(
          iconUrl,
          width: width,
          height: height,
        ),
        title: Text(text),
        activeIcon: Image.asset(
          selectedIconUrl,
          width: width,
          height: height,
        ));
  }
}
