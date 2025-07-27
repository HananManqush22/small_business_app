class ProjectModel {
  List<Data>? data;

  ProjectModel({this.data});

  ProjectModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  int? brandID;
  int? clientID;
  String? name;
  String? description;
  String? status;
  String? cost;
  String? date;
  String? dateFinish;
  String? createAt;
  String? updateAt;

  Data(
      {this.id,
      this.brandID,
      this.clientID,
      this.name,
      this.description,
      this.status,
      this.cost,
      this.date,
      this.dateFinish,
      this.createAt,
      this.updateAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    brandID = json['brandID'];
    clientID = json['clientID'];
    name = json['name'];
    description = json['description'];
    status = json['status'];
    cost = json['cost'];
    date = json['date'];
    dateFinish = json['dateFinish'];
    createAt = json['create_at'];
    updateAt = json['update_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['brandID'] = this.brandID;
    data['clientID'] = this.clientID;
    data['name'] = this.name;
    data['description'] = this.description;
    data['status'] = this.status;
    data['cost'] = this.cost;
    data['date'] = this.date;
    data['dateFinish'] = this.dateFinish;
    data['create_at'] = this.createAt;
    data['update_at'] = this.updateAt;
    return data;
  }
}
