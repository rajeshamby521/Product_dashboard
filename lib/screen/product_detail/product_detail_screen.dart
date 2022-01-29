import 'package:desktop_app_demo/model/product.dart';
import 'package:desktop_app_demo/route/route_name.dart';
import 'package:desktop_app_demo/screen/product_detail/bloc/product_detail_event.dart';
import 'package:desktop_app_demo/screen/product_detail/bloc/product_detail_state.dart';
import 'package:desktop_app_demo/util/Responsive.dart';
import 'package:desktop_app_demo/utilites/label_field.dart';
import 'package:desktop_app_demo/utilites/material_button.dart';
import 'package:desktop_app_demo/utilites/style_extension.dart';
import 'package:desktop_app_demo/utilites/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/product_detail_bloc.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({Key? key, required this.id, this.callBack})
      : super(key: key);
  final int id;
  final Function? callBack;

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  ProductDetailBloc productBloc = ProductDetailBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void callBack(Product? product) {
    if (product != null) {

      productBloc.add(ProductUpdateEvent(product));
    }
    if (widget.callBack != null) {
      widget.callBack!(product);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => productBloc,
      child: BlocListener<ProductDetailBloc, ProductDetailState>(
        listener: (context, state) {
          if (state.productDeleteStatus == true) {
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pushNamed(context, RoutesName.PRODUCT_LIST_PAGE);
          }
        },
        child: BlocBuilder<ProductDetailBloc, ProductDetailState>(
          builder: (context, state) {
            if (state.isInitialState == true) {
              productBloc.add(FetchProductEvent(widget.id));
            }

            return Scaffold(
              appBar: AppBar(
                title: const Text('Product Detail'),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: InkWell(
                      onTap: () async {
                        var product = state.productDetail!;
                        Navigator.pushNamed(
                            context, RoutesName.ADD_PRODUCT_PAGE,
                            arguments: [product, callBack]);
                      },
                      child: LabelFieldWidget(
                        textLabel: '',
                        textStyle: textStyle(Colors.white, FontWeight.w600, 16),
                        icon: Icons.edit,
                        iconColor: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: InkWell(
                      onTap: () {
                        AlertDialog alert = AlertDialog(
                          content: TextWidget(
                              text: 'Are your sure delete this product',
                              style:
                                  textStyle(Colors.black, FontWeight.w500, 16)),
                          actions: [
                            MaterialButtonWidget(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: TextWidget(
                                text: 'NO',
                                style: textStyle(
                                    Colors.black, FontWeight.w500, 14),
                              ),
                            ),
                            MaterialButtonWidget(
                              onTap: () {
                                Navigator.pop(context);
                                context
                                    .read<ProductDetailBloc>()
                                    .add(ProductDeleteEvent(widget.id));
                              },
                              child: TextWidget(
                                text: 'Yes',
                                style: textStyle(
                                    Colors.black, FontWeight.w500, 14),
                              ),
                            ),
                          ],
                        );
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      },
                      child: LabelFieldWidget(
                        textLabel: '',
                        textStyle: textStyle(Colors.white, FontWeight.w600, 16),
                        icon: Icons.delete,
                        iconColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              body: state.productDetail != null
                  ? SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                                child: Card(
                                  margin: const EdgeInsets.all(8),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: state.productDetail!.image != null
                                      ? FadeInImage.assetNetwork(
                                          height: 600,
                                          width: 150,
                                          placeholder:
                                              'assets/images/samsung.jpeg',
                                          image: state.productDetail!.image!)
                                      : SizedBox(
                                          height: 600,
                                          width: 150,
                                          child: Image.asset(
                                            'assets/images/samsung.jpeg',
                                          ),
                                        ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: Responsive().getResponsiveValue(
                                        forLargeScreen: 80.0,
                                        forMobileScreen: 30.0,
                                        forMediumScreen: 80.0,
                                        forShortScreen: 30.0,
                                        forMobLandScapeMode: 30.0,
                                        context: context),
                                  ),
                                  Visibility(
                                    visible: Responsive().getResponsiveValue(
                                        forLargeScreen: false,
                                        forMobileScreen: true,
                                        forMediumScreen: false,
                                        forShortScreen: true,
                                        forMobLandScapeMode: false,
                                        context: context),
                                    child: Card(
                                      margin: const EdgeInsets.all(8),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      child: state.productDetail!.image != null
                                          ? FadeInImage.assetNetwork(
                                              height: 200,
                                              width: 150,
                                              placeholder:
                                                  'assets/images/samsung.jpeg',
                                              image:
                                                  state.productDetail!.image!)
                                          : SizedBox(
                                              height: 200,
                                              width: 150,
                                              child: Image.asset(
                                                'assets/images/samsung.jpeg',
                                              ),
                                            ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(left: 16),
                                    child: TextWidget(
                                      text: state.productDetail!.name!,
                                      style: textStyle(const Color(0xff262626),
                                          FontWeight.w600, 24),
                                      align: TextAlign.start,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(left: 16),
                                    child: TextWidget(
                                      text: state.productDetail!.description!,
                                      style: textStyle(const Color(0xff777777),
                                          FontWeight.w600, 14),
                                      align: TextAlign.start,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(left: 16),
                                    child: TextWidget(
                                      text:
                                          '\u{20B9}${state.productDetail!.mrp!}',
                                      style: textStyle(const Color(0xff777777),
                                          FontWeight.w600, 14),
                                      align: TextAlign.start,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(left: 16),
                                    child: TextWidget(
                                      text:
                                          '\u{20B9} ${state.productDetail!.selling}',
                                      style: textStyle(const Color(0xff262626),
                                          FontWeight.w600, 14),
                                      align: TextAlign.right,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 50.0,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: MaterialButtonWidget(
                                          onTap: () {},
                                          child: TextWidget(
                                            text: 'ADD TO CART',
                                            style: textStyle(Colors.black,
                                                FontWeight.w600, 14),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: MaterialButtonWidget(
                                          onTap: () {},
                                          child: TextWidget(
                                            text: 'BUY NOW',
                                            style: textStyle(Colors.black,
                                                FontWeight.w600, 14),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
            );
          },
        ),
      ),
    );
  }
}
