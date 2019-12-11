class ProblemsEntity {
	String code;
	List<ProblemsData> data;
	String message;

	ProblemsEntity({this.code, this.data, this.message});

	ProblemsEntity.fromJson(Map<String, dynamic> json) {
		code = json['code'];
		if (json['data'] != null) {
			data = new List<ProblemsData>();(json['data'] as List).forEach((v) { data.add(new ProblemsData.fromJson(v)); });
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

class ProblemsData {
	String proclassWeight;
	String proclassName;
	String proclassDisplay;
	String proclassId;

	ProblemsData({this.proclassWeight, this.proclassName, this.proclassDisplay, this.proclassId});

	ProblemsData.fromJson(Map<String, dynamic> json) {
		proclassWeight = json['proclass_weight'];
		proclassName = json['proclass_name'];
		proclassDisplay = json['proclass_display'];
		proclassId = json['proclass_id'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['proclass_weight'] = this.proclassWeight;
		data['proclass_name'] = this.proclassName;
		data['proclass_display'] = this.proclassDisplay;
		data['proclass_id'] = this.proclassId;
		return data;
	}
}
