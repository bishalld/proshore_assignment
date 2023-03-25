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
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:meroshopping_flutter/bloc/products/categories/getcategoryproductsbloc/getcategoryproducts_bloc.dart';
import 'package:meroshopping_flutter/bloc/products/categories/getsubcategoriesbloc/getsubcategories_bloc.dart';
import 'package:meroshopping_flutter/config/constants.dart';
import 'package:meroshopping_flutter/config/global_style.dart';
import 'package:meroshopping_flutter/model/home/category/category_banner_model.dart';
import 'package:meroshopping_flutter/ui/home/category/product_sub_category.dart';
import 'package:meroshopping_flutter/ui/reuseable/app_localizations.dart';
import 'package:meroshopping_flutter/ui/reuseable/global_function.dart';
import 'package:meroshopping_flutter/ui/reuseable/global_widget.dart';
import 'package:meroshopping_flutter/ui/reuseable/shimmer_loading.dart';

class ProductCategoryPage extends StatefulWidget {
  final int categoryId;
  final String categoryName;

  const ProductCategoryPage(
      {Key? key, this.categoryId = 0, required this.categoryName})
      : super(key: key);
  @override
  _ProductCategoryPageState createState() => _ProductCategoryPageState();
}

class _ProductCategoryPageState extends State<ProductCategoryPage> {
  // initialize global function, global widget and shimmer loading
  final _globalFunction = GlobalFunction();
  final _globalWidget = GlobalWidget();
  final _shimmerLoading = ShimmerLoading();

  ScrollController _scrollController = ScrollController();

  List<CategoryBannerModel> categoryBannerData = [];

  List subCategoryData = [];
  bool _allsubcategories = false;

  List categoryAllProductData = [];
  late GetcategoryproductsBloc _categoryAllProductBloc;
  int _apiPageCategoryAllProduct = 0;
  bool _lastDataCategoryAllProduct = false;
  bool _processApiCategoryAllProduct = false;

  CancelToken apiToken = CancelToken();
  late GetsubcategoriesBloc _getsubcategoriesBloc;

  @override
  void initState() {
    _getsubcategoriesBloc = BlocProvider.of<GetsubcategoriesBloc>(context);
    _getsubcategoriesBloc.add(GetSubcategoriesDataEvent(id: widget.categoryId));

    _categoryAllProductBloc = BlocProvider.of<GetcategoryproductsBloc>(context);
    _categoryAllProductBloc
        .add(GetSubcategoryProductsDataEvent(id: widget.categoryId));

    Timer(Duration(milliseconds: 4000), () {
      refreshData();
    });

    super.initState();
  }

  // @override
  // void dispose() {
  //   apiToken.cancel("cancelled"); // cancel fetch data from API
  //   _scrollController.dispose();

  //   super.dispose();
  // }

  // this function used to fetch data from API if we scroll to the bottom of the page
  void _onScroll() {
    double maxScroll = _scrollController.position.maxScrollExtent;
    double currentScroll = _scrollController.position.pixels;

    if (currentScroll == maxScroll) {
      if (_lastDataCategoryAllProduct == false &&
          !_processApiCategoryAllProduct) {
        _categoryAllProductBloc
            .add(GetSubcategoryProductsDataEvent(id: widget.categoryId));
        _processApiCategoryAllProduct = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final double boxImageSize = (MediaQuery.of(context).size.width / 3);

    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: GlobalStyle.appBarIconThemeColor,
          ),
          elevation: GlobalStyle.appBarElevation,
          title: Text(
            widget.categoryName.replaceAll('\n', ' '),
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
        body: RefreshIndicator(
          onRefresh: refreshData,
          child: MultiBlocListener(
            listeners: [
              BlocListener<GetsubcategoriesBloc, GetsubcategoriesState>(
                listener: (context, state) {
                  if (state is GetsubcategoriesError) {
                    _globalFunction.showToast(
                        type: 'error', message: state.errorMessage);
                  }
                  if (state is GetsubcategoriesSuccess) {
                    {
                      subCategoryData.addAll(state.data);
                    }
                  }
                },
              ),
              BlocListener<GetcategoryproductsBloc, GetcategoryproductsState>(
                listener: (context, state) {
                  if (state is GetcategoryproductsWaiting) {
                    EasyLoading.show(status: 'Loading...');
                  }
                  if (state is GetcategoryproductsError) {
                    _globalFunction.showToast(
                        type: 'error', message: state.errorMessage);
                  }
                  if (state is GetcategoryproductsSuccess) {
                    EasyLoading.dismiss();
                    if (state.data.length == 0) {
                      refreshData();
                      // _lastDataCategoryAllProduct = true;
                    } else {
                      _apiPageCategoryAllProduct += LIMIT_PAGE;
                      categoryAllProductData.addAll(state.data);
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
                // _createCategorySlider(),
                Container(
                  margin: EdgeInsets.only(top: 20, left: 16, right: 16),
                  child:
                      Text("Sub Categories", style: GlobalStyle.sectionTitle),
                ),
                Container(
                    margin: EdgeInsets.only(top: 8),
                    height: 100,
                    child: BlocBuilder<GetsubcategoriesBloc,
                        GetsubcategoriesState>(builder: (context, state) {
                      if (state is GetsubcategoriesError) {
                        return Container(
                            child: Center(
                                child: Text(ERROR_OCCURED,
                                    style: TextStyle(
                                        fontSize: 14, color: BLACK_GREY))));
                      } else {
                        _scrollController.addListener(_onScroll);
                        {
                          return ListView.builder(
                            padding:
                                EdgeInsets.only(left: 12, right: 12, top: 10),
                            scrollDirection: Axis.horizontal,
                            itemCount: subCategoryData.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                //padding: EdgeInsets.symmetric(horizontal: 5),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ProductSubCategoryPage(
                                                    subCategoryId:
                                                        subCategoryData[index]
                                                            .id,
                                                    subCategoryName:
                                                        subCategoryData[index]
                                                            .title)));
                                  },
                                  child: Column(children: [
                                    CachedNetworkImage(
                                      width: 25,
                                      height: 25,
                                      imageUrl: subCategoryData[index].image !=
                                              null
                                          ? "$BASE_IMAGE_URL${subCategoryData[index].image}"
                                          : "https://www.meroshopping.com/front/assets/image/catalog/demo/logo/logo-old.png",
                                    ),
                                    Flexible(
                                      child: Container(
                                        width: 80,
                                        margin:
                                            EdgeInsets.fromLTRB(0, 10, 0, 0),
                                        child: Text(
                                          subCategoryData[index].title,
                                          style: TextStyle(
                                            color: CHARCOAL,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 12,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    )
                                  ]),
                                ),
                              );
                            },
                          );
                        }
                      }
                    })),
                Container(
                  margin: EdgeInsets.only(top: 20, left: 16, right: 16),
                  child: Text(
                      AppLocalizations.of(context)!.translate('all_product')!,
                      style: GlobalStyle.sectionTitle),
                ),
                BlocBuilder<GetcategoryproductsBloc, GetcategoryproductsState>(
                  builder: (context, state) {
                    if (state is GetcategoryproductsError) {
                      return Container(
                          child: Center(
                              child: Text(ERROR_OCCURED,
                                  style: TextStyle(
                                      fontSize: 14, color: BLACK_GREY))));
                    } else {
                      _scrollController.addListener(_onScroll);
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
                        if (categoryAllProductData.length == 0) {
                          return _shimmerLoading.buildShimmerProduct(
                              ((MediaQuery.of(context).size.width) - 24) / 2 -
                                  12);
                        } else {
                          _scrollController.addListener(_onScroll);
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
                                            categoryAllProductData[index]);
                                      },
                                      childCount: categoryAllProductData.length,
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
        ));
  }

  Future refreshData() async {
    _apiPageCategoryAllProduct = 0;

    _allsubcategories = false;
    _lastDataCategoryAllProduct = false;

    _categoryAllProductBloc
        .add(GetSubcategoryProductsDataEvent(id: widget.categoryId));
    setState(() {});
  }
}
