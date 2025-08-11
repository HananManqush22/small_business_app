class IdeasModel {
  List<IdeasData>? data;

  IdeasModel({this.data});

  IdeasModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <IdeasData>[];
      json['data'].forEach((v) {
        data!.add(IdeasData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class IdeasData {
  String? title;
  String? description;
  String? status;

  IdeasData({this.title, this.description, this.status});

  IdeasData.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['title'] = title;
    data['description'] = description;
    data['status'] = status;
    return data;
  }
}
