class OutCostModel {
  List<Data>? data;

  OutCostModel({this.data});

  OutCostModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
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

class Data {
  int? id;
  int? projectID;
  String? amount;
  String? description;
  String? createAt;
  String? updateAt;

  Data(
      {this.id,
      this.projectID,
      this.amount,
      this.description,
      this.createAt,
      this.updateAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    projectID = json['projectID'];
    amount = json['amount'];
    description = json['description'];
    createAt = json['create_at'];
    updateAt = json['update_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['projectID'] = projectID;
    data['amount'] = amount;
    data['description'] = description;
    data['create_at'] = createAt;
    data['update_at'] = updateAt;
    return data;
  }
}
