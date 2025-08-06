class ProjectModel {
  List<Data>? data;

  ProjectModel({this.data});

  ProjectModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
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
  String? remendDate;
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
      this.remendDate,
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
    remendDate = json['dateFinish'];
    createAt = json['create_at'];
    updateAt = json['update_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['brandID'] = brandID;
    data['clientID'] = clientID;
    data['name'] = name;
    data['description'] = description;
    data['status'] = status;
    data['cost'] = cost;
    data['date'] = date;
    data['dateFinish'] = remendDate;
    data['create_at'] = createAt;
    data['update_at'] = updateAt;
    return data;
  }
}
