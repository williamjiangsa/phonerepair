class CommentEntity {
	String code;
	List<CommentData> data;
	String message;

	CommentEntity({this.code, this.data, this.message});

	CommentEntity.fromJson(Map<String, dynamic> json) {
		code = json['code'];
		if (json['data'] != null) {
			data = new List<CommentData>();(json['data'] as List).forEach((v) { data.add(new CommentData.fromJson(v)); });
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

class CommentData {
	String commentTime;
	String commentUsername;
	String commentDisplay;
	String commentProname;
	String commentScore;
	String commentId;
	String commentPhone;
	String commentDetail;

	CommentData({this.commentTime, this.commentUsername, this.commentDisplay, this.commentProname, this.commentScore, this.commentId, this.commentPhone, this.commentDetail});

	CommentData.fromJson(Map<String, dynamic> json) {
		commentTime = json['comment_time'];
		commentUsername = json['comment_username'];
		commentDisplay = json['comment_display'];
		commentProname = json['comment_proname'];
		commentScore = json['comment_score'];
		commentId = json['comment_id'];
		commentPhone = json['comment_phone'];
		commentDetail = json['comment_detail'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['comment_time'] = this.commentTime;
		data['comment_username'] = this.commentUsername;
		data['comment_display'] = this.commentDisplay;
		data['comment_proname'] = this.commentProname;
		data['comment_score'] = this.commentScore;
		data['comment_id'] = this.commentId;
		data['comment_phone'] = this.commentPhone;
		data['comment_detail'] = this.commentDetail;
		return data;
	}
}
