class DeleteProductResponse {
  bool? status;
  String? message;

  DeleteProductResponse({this.message, this.status});

  DeleteProductResponse.fromJson(Map<String, dynamic> json)
      : message = json['message'],
        status = json['status'];
}
