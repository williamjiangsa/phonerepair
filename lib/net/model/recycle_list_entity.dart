class RecycleListEntity {
	String code;
	List<RecycleListData> data;
	String message;

	RecycleListEntity({this.code, this.data, this.message});

	RecycleListEntity.fromJson(Map<String, dynamic> json) {
		code = json['code'];
		if (json['data'] != null) {
			data = new List<RecycleListData>();(json['data'] as List).forEach((v) { data.add(new RecycleListData.fromJson(v)); });
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

class RecycleListData {
	RecycleListDataBrandClass brandClass;
	String brandName;
	String brandId;

	RecycleListData({this.brandClass, this.brandName, this.brandId});

	RecycleListData.fromJson(Map<String, dynamic> json) {
		brandClass = json['brand_class'] != null ? new RecycleListDataBrandClass.fromJson(json['brand_class']) : null;
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

class RecycleListDataBrandClass {
	List<RecycleListDataBrandClassClas> xClass;

	RecycleListDataBrandClass({this.xClass});

	RecycleListDataBrandClass.fromJson(Map<String, dynamic> json) {
		if (json['class'] != null) {
			xClass = new List<RecycleListDataBrandClassClas>();(json['class'] as List).forEach((v) { xClass.add(new RecycleListDataBrandClassClas.fromJson(v)); });
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

class RecycleListDataBrandClassClas {
	RecycleListDataBrandClassClassModels models;
	String classId;
	String className;

	RecycleListDataBrandClassClas({this.models, this.classId, this.className});

	RecycleListDataBrandClassClas.fromJson(Map<String, dynamic> json) {
		models = json['models'] != null ? new RecycleListDataBrandClassClassModels.fromJson(json['models']) : null;
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

class RecycleListDataBrandClassClassModels {
	List<RecycleListDataBrandClassClassModelsModel> model;

	RecycleListDataBrandClassClassModels({this.model});

	RecycleListDataBrandClassClassModels.fromJson(Map<String, dynamic> json) {
		if (json['model'] != null) {
			model = new List<RecycleListDataBrandClassClassModelsModel>();(json['model'] as List).forEach((v) { model.add(new RecycleListDataBrandClassClassModelsModel.fromJson(v)); });
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

class RecycleListDataBrandClassClassModelsModel {
	String phonePic;
	String phoneName;
	String phoneId;

	RecycleListDataBrandClassClassModelsModel({this.phonePic, this.phoneName, this.phoneId});

	RecycleListDataBrandClassClassModelsModel.fromJson(Map<String, dynamic> json) {
		phonePic = json['phone_pic'];
		phoneName = json['phone_name'];
		phoneId = json['phone_id'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['phone_pic'] = this.phonePic;
		data['phone_name'] = this.phoneName;
		data['phone_id'] = this.phoneId;
		return data;
	}
}
