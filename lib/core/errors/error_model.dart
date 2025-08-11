class ErrorModel {
  final String field;
  final String errorMassage;
  ErrorModel({required this.field, required this.errorMassage});
  factory ErrorModel.formJson(Map<String, dynamic> json) {
    return ErrorModel(errorMassage: json['message'], field: json['field']);
  }
}

// class ErrorModel {
//   String? status;
//   int? id;
//   String? error;

//   ErrorModel({this.status, this.id, this.error});

//   ErrorModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     id = json['idClient'];
//     error = json['error'];
//   }

//   // Map<String, dynamic> toJson() {
//   //   final Map<String, dynamic> data = new Map<String, dynamic>();
//   //   data['status'] = this.status;
//   //   data['idClient'] = this.idClient;
//   //   data['error'] = this.error;
//   //   return data;
//   // }
// }
