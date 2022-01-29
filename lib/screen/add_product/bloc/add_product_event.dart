import 'package:desktop_app_demo/model/product.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';

abstract class AddProductEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SubmitProductEvent extends AddProductEvent {
  final String? name;
  final String? description;
  final int? mrp;
  final int? sellingPrice;
  final PlatformFile? file;

  SubmitProductEvent({
    this.name,
    this.description,
    this.sellingPrice,
    this.mrp,
    required this.file,
  });
}

class ProductUpdateEventId extends AddProductEvent {
  final int? id;

  ProductUpdateEventId(this.id);
}

class ProductNameChangeEvent extends AddProductEvent {
  final String? name;

  ProductNameChangeEvent(this.name);
}

class ProductDescriptionChangeEvent extends AddProductEvent {
  final String? description;

  ProductDescriptionChangeEvent(this.description);
}

class ProductMRPChangeEvent extends AddProductEvent {
  final int? mrp;

  ProductMRPChangeEvent(this.mrp);
}

class ProductSellChangeEvent extends AddProductEvent {
  final int? sellPrice;

  ProductSellChangeEvent(this.sellPrice);
}

class ProductImageEvent extends AddProductEvent {
  final PlatformFile? file;

  ProductImageEvent(this.file);
}


