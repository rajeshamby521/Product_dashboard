import 'package:desktop_app_demo/Util/shared_prefence_util.dart';
import 'package:desktop_app_demo/model/product.dart';
import 'package:desktop_app_demo/route/route_name.dart';
import 'package:desktop_app_demo/screen/product_list/bloc/product_list_event.dart';
import 'package:desktop_app_demo/util/responsive.dart';
import 'package:desktop_app_demo/utilites/label_field.dart';
import 'package:desktop_app_demo/utilites/style_extension.dart';
import 'package:desktop_app_demo/utilites/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bloc/product_list_bloc.dart';
import 'bloc/product_list_state.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({
    Key? key,
  }) : super(key: key);

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  ProductListBloc itemBloc = ProductListBloc();
  var scrollController = ScrollController();
  bool isLoading = false;
  int? position;

  @override
  void initState() {
    itemBloc.add(FetchProductListEvent());
    super.initState();
    scrollListener();
  }

  void scrollListener() {
    scrollController.addListener(() {
      if ((scrollController.position.pixels ==
          scrollController.position.maxScrollExtent)) {
        itemBloc.add(FetchProductListEvent());
      }
    });
  }

  void callBackUpdateList(Product? product) {
    if (product != null) {
      setState(() {
        itemBloc.add(UpdateProductList(product, position));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => itemBloc,
      child: BlocListener<ProductListBloc, ProductListState>(
        listener: (context, state) {},
        child: BlocBuilder<ProductListBloc, ProductListState>(
          builder: (context, state) {
            if (state.isInitialState) {
              itemBloc.add(FetchProductListEvent());
            }
            return Scaffold(
              appBar: AppBar(
                title: const Text('Product List Screen'),
                leading: Visibility(
                  visible: Responsive().getResponsiveValue(
                      forLargeScreen: true,
                      forMobileScreen: false,
                      forMediumScreen: true,
                      forShortScreen: false,
                      forMobLandScapeMode: false,
                      context: context),
                  child: IconButton(
                    onPressed: () {
                      itemBloc.add(RefreshList());
                    },
                    icon: const Icon(Icons.refresh),
                  ),
                ),
                actions: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: InkWell(
                      onTap: () async {
                        SharedPreferences sharedPreferences =
                            await SharedPreferences.getInstance();
                        sharedPreferences.remove(SharedPreferenceUtil.TOKEN);
                        Navigator.pop(context);
                        Navigator.pushNamed(context, RoutesName.LOGIN_PAGE);
                      },
                      child: LabelFieldWidget(
                        textLabel: '',
                        textStyle: textStyle(Colors.white, FontWeight.w600, 16),
                        icon: Icons.logout,
                        iconColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              body: RefreshIndicator(
                onRefresh: () async {
                  itemBloc.add(RefreshList());
                },
                child: Column(
                  children: [
                    Expanded(
                      child: state.productList != null
                          ? GridView.count(
                              crossAxisCount: Responsive().getResponsiveValue(
                                  forLargeScreen: 4,
                                  forMobileScreen: 1,
                                  forMediumScreen: 3,
                                  forShortScreen: 1,
                                  forMobLandScapeMode: 1,
                                  context: context),
                              crossAxisSpacing: 4,
                              childAspectRatio: 0.66,
                              controller: scrollController,
                              children: List.generate(state.productList!.length,
                                  (index) {
                                return Container(
                                  padding: const EdgeInsets.all(8),
                                  child: InkWell(
                                    onTap: () {
                                      position = index;
                                      Navigator.pushNamed(
                                          context, RoutesName.PRODUCT_PAGE,
                                          arguments: [
                                            state.productList![index].id,
                                            callBackUpdateList
                                          ]);
                                    },
                                    child: Card(
                                      margin: const EdgeInsets.all(8),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: AspectRatio(
                                              aspectRatio: 8,
                                              child: state.productList?[index]
                                                          .image !=
                                                      null
                                                  ? FadeInImage.assetNetwork(
                                                      placeholder:
                                                          'assets/images/samsung.jpeg',
                                                      image: state
                                                          .productList![index]
                                                          .image!)
                                                  : Image.asset(
                                                      'assets/images/samsung.jpeg'),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10.0,
                                          ),
                                          Container(
                                            padding:
                                                const EdgeInsets.only(left: 16),
                                            child: TextWidget(
                                              text: state
                                                  .productList![index].name!,
                                              style: textStyle(
                                                  const Color(0xff262626),
                                                  FontWeight.w600,
                                                  16),
                                              align: TextAlign.start,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10.0,
                                          ),
                                          Container(
                                            padding:
                                                const EdgeInsets.only(left: 16),
                                            child: TextWidget(
                                              text: state.productList![index]
                                                  .description!,
                                              style: textStyle(
                                                  const Color(0xff777777),
                                                  FontWeight.w600,
                                                  14),
                                              align: TextAlign.start,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10.0,
                                          ),
                                          Container(
                                            alignment: Alignment.centerRight,
                                            padding: const EdgeInsets.only(
                                                right: 16),
                                            child: TextWidget(
                                              text:
                                                  '\u{20B9} ${state.productList![index].selling}',
                                              style: textStyle(
                                                  const Color(0xff262626),
                                                  FontWeight.w600,
                                                  14),
                                              align: TextAlign.right,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5.0,
                                          ),
                                          if (isLoading == true)
                                            const CircularProgressIndicator(),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            )
                          : const Center(
                              child: CircularProgressIndicator(),
                            ),
                    ),
                    if (state.isInitialState == true)
                      const Text('')
                    else if (state.isLoading == true)
                      const CircularProgressIndicator()
                  ],
                ),
              ),
              floatingActionButton: FloatingActionButton.extended(
                onPressed: () {
                  Product product = Product();
                  Navigator.pushNamed(context, RoutesName.ADD_PRODUCT_PAGE,
                      arguments: [product, null]);
                },
                label: TextWidget(
                  text: 'Add Product',
                  style: textStyle(Colors.white, FontWeight.w500, 14),
                ),
                icon: Icon(
                  Icons.add,
                  size: Responsive().getResponsiveValue(
                      forLargeScreen: 40.0,
                      forMobileScreen: 24.0,
                      forMediumScreen: 35.0,
                      forShortScreen: 20.0,
                      forMobLandScapeMode: 20.0,
                      context: context),
                  semanticLabel: 'Log Out',
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
