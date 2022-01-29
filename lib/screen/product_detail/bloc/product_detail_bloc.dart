import 'package:desktop_app_demo/api/product_api.dart';
import 'package:desktop_app_demo/screen/product_detail/bloc/product_detail_event.dart';
import 'package:desktop_app_demo/util/shared_prefence_util.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'product_detail_state.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  int? id;

  ProductDetailBloc() : super(const ProductDetailState()) {
    on<FetchProductEvent>(_fetchProduct);
    on<ProductDeleteEvent>(_deleteProduct);
    on<ProductUpdateEvent>(_updateProduct);
  }

  void _fetchProduct(
      FetchProductEvent event, Emitter<ProductDetailState> emit) async {
    final sharedPreferenceUtil = SharedPreferenceUtil.getInstance();
    String? token =
        await sharedPreferenceUtil.getString(SharedPreferenceUtil.TOKEN);
    var data = await ProductAPI.productDetailAPI(token, event.id!);
    //emit(state.copyWith(productDetail: data.product));
    if (data != null) {
      emit(state.copyWith(isInitialState: false, productDetail: data.product));
    }
  }

  void _deleteProduct(
      ProductDeleteEvent event, Emitter<ProductDetailState> emit) async {
    emit(state.copyWith(productDeleteStatus: false));
    final sharedPreferenceUtil = SharedPreferenceUtil.getInstance();
    String? token =
        await sharedPreferenceUtil.getString(SharedPreferenceUtil.TOKEN);
    var data = await ProductAPI.deleteProductAPI(token, event.id);
    if (data != null) {
      emit(state.copyWith(productDeleteStatus: true));
    }
  }

  void _updateProduct(
      ProductUpdateEvent event, Emitter<ProductDetailState> emit) async {
     emit(state.copyWith(productDetail: event.product));
  }
}
