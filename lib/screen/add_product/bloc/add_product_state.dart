import 'package:equatable/equatable.dart';

class AddProductState extends Equatable {
  final bool? isSuccessAddProduct;
  final bool? isLoading;
  final bool? isName;
  final bool? validDescription;
  final bool? validMRP;
  final bool? validSellPrice;
  final bool? disable;
  final int? id;

  AddProductState copyWith({
    bool? isSuccessAddProduct,
    bool? isLoading,
    bool? isName,
    bool? validDescription,
    bool? validMRP,
    bool? validSellPrice,
    bool? disable,
    int? id,
  }) {
    return AddProductState(
      isSuccessAddProduct: isSuccessAddProduct ?? this.isSuccessAddProduct,
      isLoading: isLoading ?? this.isLoading,
      isName: isName ?? this.isName,
      validDescription: validDescription ?? this.validDescription,
      validMRP: validMRP ?? this.validMRP,
      validSellPrice: validSellPrice ?? this.validSellPrice,
      disable: disable ?? this.disable,
      id: id ?? id,
    );
  }

  const AddProductState({
    this.isSuccessAddProduct = false,
    this.isName = false,
    this.isLoading,
    this.validDescription = false,
    this.validMRP = false,
    this.validSellPrice = false,
    this.disable = true,
    this.id,
  });

  @override
  List<Object?> get props => [
        isSuccessAddProduct,
        isName,
        isLoading,
        validSellPrice,
        validMRP,
        validDescription,
        disable,
        id
      ];
}
