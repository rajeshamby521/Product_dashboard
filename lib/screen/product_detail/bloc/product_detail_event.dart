import 'package:desktop_app_demo/model/product.dart';
import 'package:equatable/equatable.dart';

abstract class ProductDetailEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchProductEvent extends ProductDetailEvent {
  final int? id;

  FetchProductEvent(this.id);
}

class ProductDeleteEvent extends ProductDetailEvent {
  final int id;

  ProductDeleteEvent(this.id);
}

class ProductUpdateEvent extends ProductDetailEvent {
  final Product product;

  ProductUpdateEvent(this.product);
}
