class PhoneListEntity {
	String code;
	List<PhoneListData> data;
	String message;

	PhoneListEntity({this.code, this.data, this.message});

	PhoneListEntity.fromJson(Map<String, dynamic> json) {
		code = json['code'];
		if (json['data'] != null) {
			data = new List<PhoneListData>();(json['data'] as List).forEach((v) { data.add(new PhoneListData.fromJson(v)); });
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

class PhoneListData {
	PhoneListDataBrandClass brandClass;
	String brandName;
	String brandId;

	PhoneListData({this.brandClass, this.brandName, this.brandId});

	PhoneListData.fromJson(Map<String, dynamic> json) {
		brandClass = json['brand_class'] != null ? new PhoneListDataBrandClass.fromJson(json['brand_class']) : null;
		brandName = json['brand_name'];
		brandId = json['brand_id'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.brandClass != null) {
      data['brand_class'] = this.brandClass.toJson();
    }
		data['brand_name'] = this.brandName;
		data['brand_id'] = this.brandId;
		return data;
	}
}

class PhoneListDataBrandClass {
	List<PhoneListDataBrandClassClas> xClass;

	PhoneListDataBrandClass({this.xClass});

	PhoneListDataBrandClass.fromJson(Map<String, dynamic> json) {
		if (json['class'] != null) {
			xClass = new List<PhoneListDataBrandClassClas>();(json['class'] as List).forEach((v) { xClass.add(new PhoneListDataBrandClassClas.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.xClass != null) {
      data['class'] =  this.xClass.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class PhoneListDataBrandClassClas {
	PhoneListDataBrandClassClassModels models;
	String classId;
	String className;

	PhoneListDataBrandClassClas({this.models, this.classId, this.className});

	PhoneListDataBrandClassClas.fromJson(Map<String, dynamic> json) {
		models = json['models'] != null ? new PhoneListDataBrandClassClassModels.fromJson(json['models']) : null;
		classId = json['class_id'];
		className = json['class_name'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.models != null) {
      data['models'] = this.models.toJson();
    }
		data['class_id'] = this.classId;
		data['class_name'] = this.className;
		return data;
	}
}

class PhoneListDataBrandClassClassModels {
	List<PhoneListDataBrandClassClassModelsModel> model;

	PhoneListDataBrandClassClassModels({this.model});

	PhoneListDataBrandClassClassModels.fromJson(Map<String, dynamic> json) {
		if (json['model'] != null) {
			model = new List<PhoneListDataBrandClassClassModelsModel>();(json['model'] as List).forEach((v) { model.add(new PhoneListDataBrandClassClassModelsModel.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.model != null) {
      data['model'] =  this.model.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class PhoneListDataBrandClassClassModelsModel {
	String phoneName;
	String phoneId;

	PhoneListDataBrandClassClassModelsModel({this.phoneName, this.phoneId});

	PhoneListDataBrandClassClassModelsModel.fromJson(Map<String, dynamic> json) {
		phoneName = json['phone_name'];
		phoneId = json['phone_id'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['phone_name'] = this.phoneName;
		data['phone_id'] = this.phoneId;
		return data;
	}
}
