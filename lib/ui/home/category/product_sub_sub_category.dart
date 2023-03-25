/*
This is product category page

include file in reuseable/global_function.dart to call function from GlobalFunction
include file in reuseable/global_widget.dart to call function from GlobalWidget
include file in reuseable/cache_image_network.dart to use cache image network
include file in reuseable/shimmer_loading.dart to use shimmer loading
include file in model/home/category/category_model.dart to get categoryData

install plugin in pubspec.yaml
- carousel_slider => slider images (https://pub.dev/packages/carousel_slider)

Don't forget to add all images and sound used in this pages at the pubspec.yaml
 */

import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:meroshopping_flutter/bloc/products/categories/getsubsubcategoryproductsbloc/getsubsubcategoryproducts_bloc.dart';
import 'package:meroshopping_flutter/config/constants.dart';
import 'package:meroshopping_flutter/config/global_style.dart';
import 'package:meroshopping_flutter/ui/reuseable/app_localizations.dart';
import 'package:meroshopping_flutter/ui/home/search/search.dart';
import 'package:meroshopping_flutter/ui/reuseable/global_function.dart';
import 'package:meroshopping_flutter/ui/reuseable/global_widget.dart';
import 'package:meroshopping_flutter/ui/reuseable/shimmer_loading.dart';

class ProductSubSubCategoryPage extends StatefulWidget {
  final int subCategoryId;
  final String subCategoryName;

  const ProductSubSubCategoryPage(
      {Key? key, this.subCategoryId = 0, required this.subCategoryName})
      : super(key: key);
  @override
  _ProductSubSubCategoryPageState createState() =>
      _ProductSubSubCategoryPageState();
}

class _ProductSubSubCategoryPageState extends State<ProductSubSubCategoryPage> {
  // initialize global function, global widget and shimmer loading
  final _globalFunction = GlobalFunction();
  final _globalWidget = GlobalWidget();
  final _shimmerLoading = ShimmerLoading();

  ScrollController _scrollController = ScrollController();

  List subSubCategoryAllProductData = [];
  late GetsubsubcategoryproductsBloc _subSubcategoryAllProductBloc;
  int _apiPageCategoryAllProduct = 0;
  bool _lastDataCategoryAllProduct = false;
  bool _processApiCategoryAllProduct = false;

  CancelToken apiToken = CancelToken(); // used to cancel fetch data from API

  @override
  void initState() {
    _subSubcategoryAllProductBloc =
        BlocProvider.of<GetsubsubcategoryproductsBloc>(context);
    _subSubcategoryAllProductBloc
        .add(GetSubcategoryProductsDataEvent(id: widget.subCategoryId));

    super.initState();
  }

  @override
  void dispose() {
    apiToken.cancel("cancelled"); // cancel fetch data from API
    _scrollController.dispose();

    super.dispose();
  }

  // this function used to fetch data from API if we scroll to the bottom of the page
  void _onScroll() {
    double maxScroll = _scrollController.position.maxScrollExtent;
    double currentScroll = _scrollController.position.pixels;

    if (currentScroll == maxScroll) {
      if (_lastDataCategoryAllProduct == false &&
          !_processApiCategoryAllProduct) {
        _subSubcategoryAllProductBloc
            .add(GetSubcategoryProductsDataEvent(id: widget.subCategoryId));
        _processApiCategoryAllProduct = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: GlobalStyle.appBarIconThemeColor,
          ),
          elevation: GlobalStyle.appBarElevation,
          title: Text(
            widget.subCategoryName.replaceAll('\n', ' '),
            style: GlobalStyle.appBarTitle,
          ),
          backgroundColor: GlobalStyle.appBarBackgroundColor,
          systemOverlayStyle: GlobalStyle.appBarSystemOverlayStyle,
          actions: [
            // IconButton(
            //     icon: Icon(Icons.search, color: BLACK_GREY),
            //     onPressed: () {
            //       Navigator.push(context,
            //           MaterialPageRoute(builder: (context) => SearchPage()));
            //     }),
          ],
          bottom: _globalWidget.bottomAppBar(),
        ),
        body: WillPopScope(
          onWillPop: () {
            Navigator.pop(context);
            return Future.value(true);
          },
          child: RefreshIndicator(
            onRefresh: refreshData,
            child: MultiBlocListener(
              listeners: [
                BlocListener<GetsubsubcategoryproductsBloc,
                    GetsubsubcategoryproductsState>(
                  listener: (context, state) {
                    if (state is GetsubsubcategoryproductsWaiting) {
                      EasyLoading.show(status: "Loading...");
                    }
                    if (state is GetsubsubcategoryproductsError) {
                      _globalFunction.showToast(
                          type: 'error', message: state.errorMessage);
                    }
                    if (state is GetsubsubcategoryproductsSuccess) {
                      EasyLoading.dismiss();
                      if (state.data.length == 0) {
                        _lastDataCategoryAllProduct = true;
                      } else {
                        _apiPageCategoryAllProduct += LIMIT_PAGE;
                        subSubCategoryAllProductData.addAll(state.data);
                      }
                      _processApiCategoryAllProduct = false;
                    }
                  },
                )
              ],
              child: ListView(
                controller: _scrollController,
                physics: AlwaysScrollableScrollPhysics(),
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20, left: 16, right: 16),
                    child: Text(
                        AppLocalizations.of(context)!.translate('all_product')!,
                        style: GlobalStyle.sectionTitle),
                  ),
                  BlocBuilder<GetsubsubcategoryproductsBloc,
                      GetsubsubcategoryproductsState>(
                    builder: (context, state) {
                      if (state is GetsubsubcategoryproductsError) {
                        return Container(
                            child: Center(
                                child: Text(ERROR_OCCURED,
                                    style: TextStyle(
                                        fontSize: 14, color: BLACK_GREY))));
                      } else {
                        if (_lastDataCategoryAllProduct &&
                            _apiPageCategoryAllProduct == 0) {
                          return Container(
                              height: 200,
                              child: Center(
                                child: Text(
                                    AppLocalizations.of(context)!
                                        .translate('no_product')!,
                                    style: TextStyle(
                                        fontSize: 14, color: BLACK_GREY)),
                              ));
                        } else {
                          if (subSubCategoryAllProductData.length == 0) {
                            return _shimmerLoading.buildShimmerProduct(
                                ((MediaQuery.of(context).size.width) - 24) / 2 -
                                    12);
                          } else {
                            return CustomScrollView(
                                shrinkWrap: true,
                                primary: false,
                                slivers: <Widget>[
                                  SliverPadding(
                                    padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                                    sliver: SliverGrid(
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 8,
                                        crossAxisSpacing: 8,
                                        childAspectRatio:
                                            GlobalStyle.gridDelegateRatio,
                                      ),
                                      delegate: SliverChildBuilderDelegate(
                                        (BuildContext context, int index) {
                                          return _globalWidget.buildProductGrid(
                                              context,
                                              subSubCategoryAllProductData[
                                                  index]);
                                        },
                                        childCount:
                                            subSubCategoryAllProductData.length,
                                      ),
                                    ),
                                  ),
                                  SliverToBoxAdapter(
                                    child: _globalWidget.buildProgressIndicator(
                                        _lastDataCategoryAllProduct),
                                  ),
                                ]);
                          }
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Future refreshData() async {
    setState(() {
      _apiPageCategoryAllProduct = 0;
      _lastDataCategoryAllProduct = false;
      subSubCategoryAllProductData.clear();
      _subSubcategoryAllProductBloc
          .add(GetSubcategoryProductsDataEvent(id: widget.subCategoryId));
    });
  }
}
