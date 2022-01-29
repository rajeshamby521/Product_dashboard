import 'package:desktop_app_demo/api/product_api.dart';
import 'package:desktop_app_demo/screen/product_list/bloc/product_list_event.dart';
import 'package:desktop_app_demo/util/shared_prefence_util.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'product_list_state.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  ProductListBloc() : super(const ProductListState()) {
    on<FetchProductListEvent>(_fetchProducts);
    on<UpdateProductList>(_updateProductList);
    on<RefreshList>(_refreshList);
  }

  void _fetchProducts(
      FetchProductListEvent event, Emitter<ProductListState> emit) async {
    if (state.isPaginationRequired && !state.isLoading) {
      final sharedPreferenceUtil = SharedPreferenceUtil.getInstance();
      String? token =
          await sharedPreferenceUtil.getString(SharedPreferenceUtil.TOKEN);
      emit(state.copyWith(isLoading: true));
      var data = await ProductAPI.productListAPI(token, state.page);
      state.productList?.addAll(data?.itemList ?? []);

      emit(
        state.copyWith(
            isInitialState: false,
            productList: state.productList ?? data?.itemList,
            page: data?.currentPage != null ? (data!.currentPage! + 1) : 1,
            isLoading: false,
            isPaginationRequired:
                data?.itemList != null && data!.itemList!.isNotEmpty),
      );
    }
  }

  void _refreshList(RefreshList event, Emitter<ProductListState> emit) async {
    final sharedPreferenceUtil = SharedPreferenceUtil.getInstance();
    String? token =
        await sharedPreferenceUtil.getString(SharedPreferenceUtil.TOKEN);
    var data = await ProductAPI.productListAPI(token, 1);
    emit(
      state.copyWith(
          isInitialState: false,
          productList: data!.itemList,
          page: data.currentPage != null ? (data.currentPage! + 1) : 1,
          isLoading: false,
          isPaginationRequired:
              data.itemList != null && data.itemList!.isNotEmpty),
    );
  }

  void _updateProductList(
      UpdateProductList event, Emitter<ProductListState> emit) async {
    var index = event.index!;
    state.productList![index] = event.product!;
    final temp = state.copyWith(productList: state.productList);
    emit(temp);
  }
}
