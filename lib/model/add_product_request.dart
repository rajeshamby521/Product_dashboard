class AddProductRequest {
  String? name;
  int? mrp;
  int? selling;
  String? description;
  String? image;

  AddProductRequest(
      {this.name, this.mrp, this.selling, this.description, this.image});

  Map<String, dynamic> toJson() => {
        'name': name,
        'mrp': mrp,
        'selling': selling,
        'description': description
      };
}
