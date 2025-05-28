class ProfiledModel {
  List<Data>? data;

  ProfiledModel({this.data});

  ProfiledModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  int? brandID;
  String? name;
  String? logo;
  String? description;
  String? phone;
  String? address;
  String? createAt;
  String? updateAt;

  Data(
      {this.id,
      this.brandID,
      this.name,
      this.logo,
      this.description,
      this.phone,
      this.address,
      this.createAt,
      this.updateAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    brandID = json['brandID'];
    name = json['name'];
    logo = json['logo'];
    description = json['description'];
    phone = json['phone'];
    address = json['address'];
    createAt = json['create_at'];
    updateAt = json['update_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['brandID'] = this.brandID;
    data['name'] = this.name;
    data['logo'] = this.logo;
    data['description'] = this.description;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['create_at'] = this.createAt;
    data['update_at'] = this.updateAt;
    return data;
  }
}
