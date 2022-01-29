import 'package:desktop_app_demo/api/product_api.dart';
import 'package:desktop_app_demo/model/add_product_request.dart';
import 'package:desktop_app_demo/screen/add_product/bloc/add_product_event.dart';
import 'package:desktop_app_demo/screen/add_product/bloc/add_product_state.dart';
import 'package:desktop_app_demo/util/shared_prefence_util.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddProductBloc extends Bloc<AddProductEvent, AddProductState> {
  int? id;
  String? description;
  String? name;
  int? mrp;
  int? selling;

  AddProductBloc() : super(const AddProductState()) {
    on<ProductUpdateEventId>(_productId);
    on<SubmitProductEvent>(_addProduct);
    on<ProductNameChangeEvent>(_addProductName);
    on<ProductDescriptionChangeEvent>(_addProductDescription);
    on<ProductMRPChangeEvent>(_addProductMRP);
    on<ProductSellChangeEvent>(_addProductSellPrice);
  }

  void _productId(ProductUpdateEventId event, Emitter<AddProductState> emit) {
    id = event.id;
  }

  void _addProduct(
      SubmitProductEvent event, Emitter<AddProductState> emit) async {
    if (event.name != null &&
        event.description != null &&
        event.mrp != null &&
        event.sellingPrice != null) {
      emit(state.copyWith(isSuccessAddProduct: false, isLoading: false));
      final sharedPreferenceUtil = SharedPreferenceUtil.getInstance();
      String? token =
          await sharedPreferenceUtil.getString(SharedPreferenceUtil.TOKEN);
      AddProductRequest product = AddProductRequest();
      product.name = event.name;
      product.description = event.description;
      product.mrp = event.mrp;
      product.selling = event.sellingPrice;
      ProductAPI productApi = ProductAPI();

      if (id != null) {
        // update Product
        if (event.file != null) {
          // update product with image
          var responseUpdate = await productApi.updateProductAPIWithImage(
              token, product, id!, event.file!);
          if (responseUpdate != null) {
            emit(state.copyWith(isSuccessAddProduct: true, isLoading: true));
          } else {
            emit(state.copyWith(isSuccessAddProduct: false, isLoading: false));
          }
        } else {
          // update product without image
          var responseUpdate =
              await productApi.updateProductAPWithoutImage(token, product, id!);
          if (responseUpdate != null) {
            emit(state.copyWith(isSuccessAddProduct: true, isLoading: true));
          } else {
            emit(state.copyWith(isSuccessAddProduct: false, isLoading: false));
          }
        }
      } else {
        //  Add Product
        if (event.file != null) {
          // add Product with image
          var response = await ProductAPI.addProductAPIWithImage(
              token, product, event.file!);

          if (response != null) {
            emit(state.copyWith(
                isSuccessAddProduct: true, isLoading: true, id: response.id));
          } else {
            emit(state.copyWith(isSuccessAddProduct: false, isLoading: false));
          }
        } else {
          // add Product without image
          var response =
              await productApi.addProductAPIWithoutImage(token, product);
          if (response != null) {
            emit(state.copyWith(
                isSuccessAddProduct: true, isLoading: true, id: response.id));
          } else {
            emit(state.copyWith(isSuccessAddProduct: false, isLoading: false));
          }
        }
      }
    } else {
      if (event.name!.isEmpty) {
        emit(state.copyWith(isName: false));
      }
      if (event.description!.isEmpty) {
        emit(state.copyWith(validDescription: false));
      }
      if (event.mrp == null) {
        emit(state.copyWith(validMRP: false));
      }
      if (event.sellingPrice == null) {
        emit(state.copyWith(validSellPrice: false));
      }
    }
  }

  void _addProductName(
      ProductNameChangeEvent event, Emitter<AddProductState> emit) async {
    if (event.name!.isNotEmpty) {
      name = event.name;
      emit(state.copyWith(isName: true, disable: false));
      // enable disable button  condition
      buttonEnableDisable(emit);
    } else {
      emit(state.copyWith(isName: false, disable: true));
    }
  }

  void _addProductDescription(ProductDescriptionChangeEvent event,
      Emitter<AddProductState> emit) async {
    if (event.description!.isNotEmpty) {
      description = event.description;
      emit(state.copyWith(validDescription: true, disable: false));

      // enable disable button  condition
      buttonEnableDisable(emit);
    } else {
      emit(state.copyWith(validDescription: false, disable: true));
    }
  }

  void _addProductMRP(
      ProductMRPChangeEvent event, Emitter<AddProductState> emit) async {
    if (event.mrp != null) {
      mrp = event.mrp;
      emit(state.copyWith(validMRP: true, disable: false));

      // enable disable button  condition
      buttonEnableDisable(emit);
    } else {
      emit(state.copyWith(validMRP: false, disable: true));
    }
  }

  void _addProductSellPrice(
      ProductSellChangeEvent event, Emitter<AddProductState> emit) async {
    if (event.sellPrice != null) {
      selling = event.sellPrice;
      emit(state.copyWith(validSellPrice: true, disable: false));

      // enable disable button  condition
      buttonEnableDisable(emit);
    } else {
      emit(state.copyWith(validSellPrice: false, disable: true));
    }
  }

  buttonEnableDisable(Emitter<AddProductState> emit) {
    if (state.isName == true &&
        state.validSellPrice == true &&
        state.validMRP == true &&
        state.validDescription == true &&
        name != null &&
        description != null &&
        mrp != null &&
        selling != null) {
      emit(state.copyWith(disable: false));
    } else {
      emit(state.copyWith(disable: true));
    }
  }
}
