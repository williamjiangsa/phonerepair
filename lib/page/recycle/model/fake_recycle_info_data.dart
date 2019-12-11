//回收详情页面本地数据
class FakeRecycleInfoData {
  List<RecycleInfo> recycleInfos = [];

  void init() {
    for (int i = 0; i < 5; i++) {
      List<RecycleInfo> recycleSubInfos = [];
      for(int j=0;j<3;j++){
        recycleSubInfos.add(RecycleInfo(j.toString(), "子项目$i--$j", []));
      }
      recycleInfos.add(RecycleInfo(i.toString(), "选择项目$i", recycleSubInfos,
          isSingleChoice: i != 4));
    }
  }
}

//属性选择
class RecycleInfo {
  //唯一id
  String recycleId;

  //显示名字
  String recycleName;

  //是否是单选
  bool isSingleChoice;

  //是否选择了
  bool isChoosed;

  //点击打开子面板
  bool hasClickedToExpand;

  //选项
  List<RecycleInfo> recycleSubInfos = [];

  RecycleInfo(
    this.recycleId,
    this.recycleName,
    this.recycleSubInfos, {
    this.isSingleChoice = true,
    this.isChoosed = false,
    this.hasClickedToExpand = false,
  });
}
