import 'package:desktop_app_demo/model/product.dart';
import 'package:equatable/equatable.dart';

class ProductListState extends Equatable {
  final List<Product>? productList;

  final bool isInitialState;

  final int page;

  //It will be used for pagination api calling
  final bool isLoading;

  //It will be use to decide whether the api is required or not for next page
  final bool isPaginationRequired;

  const ProductListState(
      {this.productList,
      this.isInitialState = true,
      this.page = 1,
      this.isLoading = false,
      this.isPaginationRequired = true});

  ProductListState copyWith(
      {List<Product>? productList,
      bool? isInitialState,
      int? page,
      bool? isLoading,
      bool? isPaginationRequired}) {
    return ProductListState(
        isInitialState: isInitialState ?? this.isInitialState,
        productList: productList ?? this.productList,
        page: page ?? this.page,
        isLoading: isLoading ?? this.isLoading,
        isPaginationRequired:
            isPaginationRequired ?? this.isPaginationRequired);
  }

  @override
  List<Object?> get props =>
      [productList, isInitialState, page, isLoading, isPaginationRequired];
}
