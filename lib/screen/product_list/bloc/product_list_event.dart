import 'package:desktop_app_demo/model/product.dart';
import 'package:equatable/equatable.dart';

abstract class ProductListEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchProductListEvent extends ProductListEvent {}

class UpdateProductList extends ProductListEvent {
  final Product? product;
  final int? index;

  UpdateProductList(this.product, this.index);
}

class RefreshList extends ProductListEvent{

}

