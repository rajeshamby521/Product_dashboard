import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final int? id;

  final String? name;
  final int? mrp;
  final int? selling;
  final String? description;
  final String? image;

  const Product(
      {this.id,
      this.name,
      this.mrp,
      this.selling,
      this.description,
      this.image});

  static List<Product>? fromJsonArray(List<dynamic>? itemJsonList) {
    List<Product>? itemList =
        itemJsonList?.map((e) => Product.fromJson(e)).toList();
    return itemList;
  }

  Product.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        mrp = json['mrp'],
        selling = json['selling'],
        description = json['description'],
        image = json['img'];

  @override
  List<Object?> get props => [mrp, selling, id, name, description, image];
}
