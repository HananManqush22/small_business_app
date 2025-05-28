class ErrorModel {
  final String field;
  final String errorMassage;
  ErrorModel({required this.field, required this.errorMassage});
  factory ErrorModel.formJson(Map<String, dynamic> json) {
    return ErrorModel(errorMassage: json['message'], field: json['field']);
  }
}
