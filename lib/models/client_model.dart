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
    final Map<String, dynamic> data = {};
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
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['address'] = address;
    data['description'] = description;
    data['phone'] = phone;
    data['create_at'] = createAt;
    data['update_at'] = updateAt;
    return data;
  }
}
