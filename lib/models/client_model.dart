class ClientModel {
  List<ClientData>? data;

  ClientModel({this.data});

  ClientModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ClientData>[];
      json['data'].forEach((v) {
        data!.add(ClientData.fromJson(v));
      });
    }
  }

  get name => null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ClientData {
  int? id;
  String? name;
  String? email;
  String? address;
  String? description;
  String? phone;
  String? createAt;
  String? updateAt;

  ClientData(
      {this.id,
      this.name,
      this.email,
      this.address,
      this.description,
      this.phone,
      this.createAt,
      this.updateAt});

  ClientData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    address = json['address'];
    description = json['description'];
    phone = json['phone'];
    createAt = json['create_at'];
    updateAt = json['update_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['address'] = this.address;
    data['description'] = this.description;
    data['phone'] = this.phone;
    data['create_at'] = this.createAt;
    data['update_at'] = this.updateAt;
    return data;
  }
}
