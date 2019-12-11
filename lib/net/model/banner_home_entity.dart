class BannerHomeEntity {
	String code;
	List<BannerHomeData> data;
	String message;

	BannerHomeEntity({this.code, this.data, this.message});

	BannerHomeEntity.fromJson(Map<String, dynamic> json) {
		code = json['code'];
		if (json['data'] != null) {
			data = new List<BannerHomeData>();(json['data'] as List).forEach((v) { data.add(new BannerHomeData.fromJson(v)); });
		}
		message = json['message'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['code'] = this.code;
		if (this.data != null) {
      data['data'] =  this.data.map((v) => v.toJson()).toList();
    }
		data['message'] = this.message;
		return data;
	}
}

class BannerHomeData {
	String adId;
	String adUrl;
	String adPic;

	BannerHomeData({this.adId, this.adUrl, this.adPic});

	BannerHomeData.fromJson(Map<String, dynamic> json) {
		adId = json['ad_id'];
		adUrl = json['ad_url'];
		adPic = json['ad_pic'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['ad_id'] = this.adId;
		data['ad_url'] = this.adUrl;
		data['ad_pic'] = this.adPic;
		return data;
	}
}
