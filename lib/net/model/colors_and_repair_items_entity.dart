class ColorsAndRepairItemsEntity {
  String code;
  ColorsAndRepairItemsData data;
  String message;

  ColorsAndRepairItemsEntity({this.code, this.data, this.message});

  ColorsAndRepairItemsEntity.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    data = json['data'] != null
        ? new ColorsAndRepairItemsData.fromJson(json['data'])
        : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class ColorsAndRepairItemsData {
  List<ColorsAndRepairItemsDataColor> color;
  List<ColorsAndRepairItemsDataSolution> solution;

  ColorsAndRepairItemsData({this.color, this.solution});

  ColorsAndRepairItemsData.fromJson(Map<String, dynamic> json) {
    if (json['color'] != null) {
      color = new List<ColorsAndRepairItemsDataColor>();
      (json['color'] as List).forEach((v) {
        color.add(new ColorsAndRepairItemsDataColor.fromJson(v));
      });
    }
    if (json['solution'] != null) {
      solution = new List<ColorsAndRepairItemsDataSolution>();
      (json['solution'] as List).forEach((v) {
        solution.add(new ColorsAndRepairItemsDataSolution.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.color != null) {
      data['color'] = this.color.map((v) => v.toJson()).toList();
    }
    if (this.solution != null) {
      data['solution'] = this.solution.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ColorsAndRepairItemsDataColor {
  String colorId;
  String colorHex;
  String colorName;

  ColorsAndRepairItemsDataColor({this.colorId, this.colorHex, this.colorName});

  ColorsAndRepairItemsDataColor.fromJson(Map<String, dynamic> json) {
    colorId = json['color_id'];
    colorHex = json['color_hex'];
    colorName = json['color_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['color_id'] = this.colorId;
    data['color_hex'] = this.colorHex;
    data['color_name'] = this.colorName;
    return data;
  }
}

class ColorsAndRepairItemsDataSolution {
  String problemBaoxiu;
  String problemExplain;
  String problemId;
  String problemName;
  String problemPrice;
  String problemYPrice;
  String phoneName;
  String problemRate;
  String problemateTimes;

  ColorsAndRepairItemsDataSolution(
      {this.problemBaoxiu,
      this.problemExplain,
      this.problemId,
      this.problemName,
      this.problemPrice,
      this.problemYPrice,
      this.phoneName,
      this.problemRate,
      this.problemateTimes});

  ColorsAndRepairItemsDataSolution.fromJson(Map<String, dynamic> json) {
    problemBaoxiu = json['problem_baoxiu'];
    problemExplain = json['problem_explain'];
    problemId = json['problem_id'];
    problemName = json['problem_name'];
    problemPrice = json['problem_price'];
    problemYPrice = json['problem_yprice'];
    phoneName = json['phone_name'];
    problemRate = json['problem_rate'];
    problemateTimes = json['problem_ratetimes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['problem_baoxiu'] = this.problemBaoxiu;
    data['problem_explain'] = this.problemExplain;
    data['problem_id'] = this.problemId;
    data['problem_name'] = this.problemName;
    data['problem_price'] = this.problemPrice;
    data['problem_yprice'] = this.problemYPrice;
    data['phone_name'] = this.phoneName;
    data['problem_rate'] = this.problemRate;
    data['problem_ratetimes'] = this.problemateTimes;
    return data;
  }
}
