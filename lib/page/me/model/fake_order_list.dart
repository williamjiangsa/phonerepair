class FakeOrderList {
  List<Order> orderList = [];

  void initRepairs() {
    orderList.clear();
    for (int i = 0; i < 10; i++) {
      orderList.add(Order(i.toString(), "REP20190816" + i.toString(),
          "2019-08-16", "IPHONE 7PLUS", "更换高品质电池", "299.0"));
    }
  }

  void initRecycles() {
    orderList.clear();
    for (int i = 0; i < 10; i++) {
      orderList.add(Order(i.toString(), "REC20190816" + i.toString(),
          "2019-08-16", "IPHONE 7PLUS", "上门回收", "299.0"));
    }
  }
}

class Order {
  //订单id
  String orderId;

  //订单日期
  String orderDate;

  //订单手机型号
  String orderPhoneName;

  //订单编号
  String orderNo;

  //订单内容
  String orderContent;

  //订单金额
  String orderAmount;

  Order(this.orderId, this.orderNo, this.orderDate, this.orderPhoneName,
      this.orderContent, this.orderAmount);
}
