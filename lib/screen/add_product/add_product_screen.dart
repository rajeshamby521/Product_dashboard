import 'package:desktop_app_demo/model/product.dart';
import 'package:desktop_app_demo/screen/add_product/bloc/add_product_bloc.dart';
import 'package:desktop_app_demo/screen/add_product/bloc/add_product_state.dart';
import 'package:desktop_app_demo/util/Responsive.dart';
import 'package:desktop_app_demo/util/colors_constant.dart';
import 'package:desktop_app_demo/utilites/label_field.dart';
import 'package:desktop_app_demo/utilites/material_button.dart';
import 'package:desktop_app_demo/utilites/style_extension.dart';
import 'package:desktop_app_demo/utilites/text_field_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/add_product_event.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key, required this.product, this.callBack})
      : super(key: key);
  final Product product;
  final Function? callBack;

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController mrp = TextEditingController();
  TextEditingController selling = TextEditingController();
  AddProductBloc addProductBloc = AddProductBloc();
  PlatformFile? file;

  @override
  void initState() {
    super.initState();
    if (widget.product.id != null) {
      addProductBloc.add(ProductUpdateEventId(widget.product.id));

      name.text = widget.product.name!;
      description.text = widget.product.description!;
      mrp.text = widget.product.mrp!.toString();
      selling.text = widget.product.selling.toString();
      addProductBloc.add(ProductSellChangeEvent(widget.product.selling));
      addProductBloc.add(ProductMRPChangeEvent(widget.product.mrp));
      addProductBloc
          .add(ProductDescriptionChangeEvent(widget.product.description));
      addProductBloc.add(ProductNameChangeEvent(widget.product.name));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => addProductBloc,
      child: BlocListener<AddProductBloc, AddProductState>(
        listener: (context, state) {
          if (state.isSuccessAddProduct == true) {
            if (widget.callBack != null) {
              if (widget.product.id != null) {
                Product updateProduct = Product(
                    id: widget.product.id,
                    name: name.text,
                    description: description.text,
                    mrp: int.parse(mrp.text),
                    selling: int.parse(selling.text));
                widget.callBack!(updateProduct);
              }
            }
            Navigator.pop(context);
          }
        },
        child: BlocBuilder<AddProductBloc, AddProductState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Add Product Screen'),
                backgroundColor: ColorsConstant.APP_PRIMARY_COLOR,
              ),
              body: Row(
                children: [
                  Visibility(
                    visible: Responsive().getResponsiveValue(
                        forLargeScreen: true,
                        forMobileScreen: false,
                        forMediumScreen: true,
                        forShortScreen: false,
                        forMobLandScapeMode: false,
                        context: context),
                    child: Expanded(
                      flex: 1,
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                Color(0xFF3366FF),
                                Color(0xFF00CCFF),
                              ],
                              begin: FractionalOffset(0.0, 0.0),
                              end: FractionalOffset(1.0, 0.0),
                              stops: [0.0, 1.0],
                              tileMode: TileMode.clamp),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: SingleChildScrollView(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 60,
                            ),
                            Container(
                              width: 334,
                              height: 52,
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: ColorsConstant.APP_PRIMARY_COLOR,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(2),
                              ),
                              child: InkWell(
                                onTap: () async {
                                  var pickedFile = await FilePicker.platform
                                      .pickFiles(type: FileType.image);
                                  file = pickedFile!.files.single;

                                  context
                                      .read<AddProductBloc>()
                                      .add(ProductImageEvent(file!));
                                },
                                child: LabelFieldWidget(
                                  textLabel: 'Upload Product Picture ',
                                  textStyle: textStyle(
                                      Colors.black54, FontWeight.w600, 16),
                                  icon: Icons.drive_folder_upload,
                                  iconColor: Colors.black54,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            TextFieldWidget(
                                controller: name,
                                cursorColors: Colors.black,
                                textStyle: textStyle(
                                    Colors.black54, FontWeight.w600, 18),
                                hintTextStyle:
                                    textStyle(Colors.grey, FontWeight.w600, 16),
                                placeholderText: 'Enter Product Name',
                                maxLine: 1,
                                onChanged: (value) {
                                  context
                                      .read<AddProductBloc>()
                                      .add(ProductNameChangeEvent(value));
                                }),
                            const SizedBox(
                              height: 8,
                            ),
                            SizedBox(
                              height: 80,
                              child: TextFieldWidget(
                                controller: description,
                                cursorColors: Colors.black,
                                textStyle: textStyle(
                                    Colors.black54, FontWeight.w600, 18),
                                hintTextStyle:
                                    textStyle(Colors.grey, FontWeight.w600, 16),
                                placeholderText: 'Enter Description',
                                maxLine: 2,
                                onChanged: (value) {
                                  context.read<AddProductBloc>().add(
                                      ProductDescriptionChangeEvent(value));
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            TextFieldWidget(
                              controller: mrp,
                              cursorColors: Colors.black,
                              textStyle: textStyle(
                                  Colors.black54, FontWeight.w600, 18),
                              hintTextStyle:
                                  textStyle(Colors.grey, FontWeight.w600, 16),
                              placeholderText: 'Enter MRP ',
                              textInputType: TextInputType.number,
                              maxLine: 1,
                              onChanged: (value) {
                                context.read<AddProductBloc>().add(
                                    ProductMRPChangeEvent(int.tryParse(value)));
                              },
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            TextFieldWidget(
                              controller: selling,
                              cursorColors: Colors.black,
                              textStyle: textStyle(
                                  Colors.black54, FontWeight.w600, 18),
                              hintTextStyle:
                                  textStyle(Colors.grey, FontWeight.w600, 16),
                              placeholderText: 'Enter Sell Price',
                              textInputType: TextInputType.number,
                              maxLine: 1,
                              onChanged: (value) {
                                context.read<AddProductBloc>().add(
                                    ProductSellChangeEvent(
                                        int.tryParse(value)));
                              },
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            MaterialButtonWidget(
                              width: 350,
                              child: state.isLoading == true
                                  ? const SizedBox(
                                      width: 26,
                                      height: 26,
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.black),
                                      ),
                                    )
                                  : Text(
                                      'Add Product',
                                      style: textStyle(
                                          Colors.white, FontWeight.w600, 18),
                                    ),
                              onTap: state.disable == false
                                  ? () => {
                                        context.read<AddProductBloc>().add(
                                              SubmitProductEvent(
                                                name: name.text,
                                                description: description.text,
                                                mrp: int.parse(mrp.text),
                                                sellingPrice:
                                                    int.parse(selling.text),
                                                file: file,
                                              ),
                                            )
                                      }
                                  : null,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
