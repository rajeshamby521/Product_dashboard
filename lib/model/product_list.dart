import 'package:desktop_app_demo/model/product.dart';
import 'package:equatable/equatable.dart';

class ProductList extends Equatable {
  int? currentPage;

  List<Product>? itemList;

  ProductList({
    this.currentPage,
    this.itemList,
  });

  ProductList.fromJson(Map<String, dynamic> json)
      : currentPage = json['current_page'],
        itemList = Product.fromJsonArray(json['data']);

  @override
  // TODO: implement props
  List<Object?> get props => [currentPage,itemList];
}
