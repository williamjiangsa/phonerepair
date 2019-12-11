class FakeAddressList {
  List<Address> addressList=[];
  void init(){
    addressList.clear();
    addressList.add(Address("1","小李","180****6666","上海市静安区静安寺10086"));
    addressList.add(Address("2","小红","180****5555","北京市发斯蒂芬是静安寺10086"));
    addressList.add(Address("3","小白","180****8585","苏州市ddffwssf10086"));
  }
}

class Address {

  //地址id
  String addressId;
  //收件人姓名
  String receiverName;
  //收件人手机号
  String receiverPhone;
  //收件人地址
  String address;

  Address(this.addressId, this.receiverName, this.receiverPhone, this.address);


}
