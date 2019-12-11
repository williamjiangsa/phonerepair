//选择城市本地数据

String cityNameItems1 = "深圳市";
String cityNameItems2 = "广州市";
String cityNameItems3 = "杭州市";
String cityNameItems4 = "北京市";
String cityNameItems5 = "上海市";
String cityNameItems6 = "各大城市";

class FakeCitySelectData {
  //城市
  List<String> cityLists = [];

  void init() {
    cityLists.add(cityNameItems1);
    cityLists.add(cityNameItems2);
    cityLists.add(cityNameItems3);
    cityLists.add(cityNameItems4);
    cityLists.add(cityNameItems5);
    cityLists.add(cityNameItems6);
  }
}
