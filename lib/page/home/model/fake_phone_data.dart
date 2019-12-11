//选择机型本地数据

class FakePhoneSelectData {
  //所有机型一级列表
  List<PhoneItem> phoneItems = [];

  //二级列表（含三级）
  List<PhoneItem> phonesubItems = [];

  void init() {
    List<PhoneItem> subItems = [];
    phoneItems.add(PhoneItem("1", "苹果", true, false, subItems));
    phoneItems.add(PhoneItem("2", "三星", false, false, subItems));
    phoneItems.add(PhoneItem("3", "小米", false, false, subItems));
    phoneItems.add(PhoneItem("4", "华为", false, false, subItems));
    phoneItems.add(PhoneItem("5", "OPPO", false, false, subItems));
    phoneItems.add(PhoneItem("6", "vivo", false, false, subItems));
    phoneItems.add(PhoneItem("7", "乐视", false, false, subItems));
    phoneItems.add(PhoneItem("8", "魅族", false, false, subItems));
    initSubItemsById("1");
  }

  void initSubItemsById(String parentId) {
    phonesubItems.clear();
    PhoneItem selectPhoneItem;
    phoneItems.forEach((item) {
      if (item.phoneItemId == parentId) {
        selectPhoneItem = item;
      }
    });
    for (int i = 1; i < 3; i++) {
      List<PhoneItem> subItems = [];
      for (int j = 1; j < 11; j++) {
        subItems.add(PhoneItem(
            selectPhoneItem.phoneItemId + i.toString() + j.toString(),
            selectPhoneItem.itemName + "系列-$i" + "-$j",
            false,
            false, []));
      }
      phonesubItems.add(PhoneItem(selectPhoneItem.phoneItemId + i.toString(),
          selectPhoneItem.itemName + "系列$i", false, true, subItems));
    }
  }
}

class PhoneItem {
  //机型唯一标识id
  String phoneItemId;

  //机型 名字
  String itemName;

  //标记是否选择
  bool isSelected;

  //标记是否是子分类的头部  即 系列名字
  bool isSubGroup;

  List<PhoneItem> subItems = [];

  PhoneItem(this.phoneItemId, this.itemName, this.isSelected, this.isSubGroup,
      this.subItems);
}
