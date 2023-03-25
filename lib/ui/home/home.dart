/*
This is home page

For this homepage, appBar is created at the bottom after CustomScrollView
we used AutomaticKeepAliveClientMixin to keep the state when moving from 1 navbar to another navbar, so the page is not refresh overtime

include file in reuseable/global_function.dart to call function from GlobalFunction
include file in reuseable/global_widget.dart to call function from GlobalWidget
include file in reuseable/cache_image_network.dart to use cache image network
include file in reuseable/shimmer_loading.dart to use shimmer loading
include file in model/home/category/category_for_you_model.dart to get categoryForYouData
include file in model/home/category/category_model.dart to get categoryData
include file in model/home/coupon_model.dart to get couponData
include file in model/home/flashsale_model.dart to get topSaleData
include file in model/home/home_banner_model.dart to get homeBannerData
include file in model/home/last_search_model.dart to get lastSearchData
include file in model/home/trending_model.dart to get homeTrendingData
include file in model/home/recomended_product_model.dart to get recomendedProductData

install plugin in pubspec.yaml
- carousel_slider => slider images (https://pub.dev/packages/carousel_slider)
- fluttertoast => to show toast (https://pub.dev/packages/fluttertoast)

Don't forget to add all images and sound used in this pages at the pubspec.yaml
 */

import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meroshopping_flutter/bloc/account/accountinfo/bloc/account_bloc.dart';
import 'package:meroshopping_flutter/bloc/homebannerbloc/bloc/homebanner_bloc.dart';
import 'package:meroshopping_flutter/bloc/products/brands/brandsbloc/brands_bloc.dart';
import 'package:meroshopping_flutter/bloc/products/categories/fetchcategoriesbloc/fetchcategories_bloc.dart';
import 'package:meroshopping_flutter/bloc/products/checkout/topsellingbloc/topselling_bloc.dart';
import 'package:meroshopping_flutter/bloc/products/tags/tagbloc/tags_bloc.dart';
import 'package:meroshopping_flutter/config/constants.dart';
import 'package:meroshopping_flutter/config/global_style.dart';
import 'package:meroshopping_flutter/config/shared_pref.dart';
import 'package:meroshopping_flutter/ui/home/brandproduct.dart';
import 'package:meroshopping_flutter/ui/home/category/allcategory.dart';
import 'package:meroshopping_flutter/ui/home/tagproduct.dart';
import 'package:meroshopping_flutter/ui/home/topsale.dart';
import 'package:meroshopping_flutter/ui/general/product_detail/product_detail.dart';
import 'package:meroshopping_flutter/ui/general/notification.dart';
import 'package:meroshopping_flutter/ui/home/category/product_category.dart';
import 'package:meroshopping_flutter/ui/reuseable/app_localizations.dart';
import 'package:meroshopping_flutter/ui/reuseable/cache_image_network.dart';
import 'package:meroshopping_flutter/ui/home/search/search.dart';
import 'package:meroshopping_flutter/ui/reuseable/global_function.dart';
import 'package:meroshopping_flutter/ui/reuseable/global_widget.dart';
import 'package:meroshopping_flutter/ui/reuseable/shimmer_loading.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  // initialize global function, global widget and shimmer loading
  final _globalFunction = GlobalFunction();
  final _globalWidget = GlobalWidget();
  final _shimmerLoading = ShimmerLoading();

  List homeBannerData = [];
  List topSaleData = [];
  List brandData = [];
  List tagsData = [];
  //List<CategoryForYouModel> categoryForYouData = [];
  List categoryData = [];

  // late HomeBannerBloc _homeBannerBloc;
  // bool _lastDataHomeBanner = false;

  late TopsellingBloc _topSaleBloc;
  bool _lastDatatopsale = false;

  late BrandsBloc _brandBloc;
  bool _lastDatabrand = false;

  late TagsBloc _tagBloc;
  bool _lastDataTag = false;

  // late CategoryForYouBloc _categoryForYouBloc;
  // bool _lastDataCategoryForYou = false;

  //late CategoryBloc _categoryBloc;
  bool _lastDataCategory = false;

  late HomebannerBloc _homebannerBloc;
  bool _lastDataHomeBanner = false;

  // List<RecomendedProductModel> recomendedProductData = [];
  // late RecomendedProductBloc _recomendedProductBloc;
  // int _apiPageRecomended = 0;
  // bool _lastDataRecomended = false;
  // bool _processApiRecomended = false;

  CancelToken apiToken = CancelToken(); // used to cancel fetch data from API

  int _currentImageSlider = 0;

  late ScrollController _scrollController;
  Color _topIconColor = Colors.white;
  Color _topSearchColor = Colors.white;
  late AnimationController _topColorAnimationController;
  late Animation _appBarColor;
  SystemUiOverlayStyle _appBarSystemOverlayStyle = SystemUiOverlayStyle.light;

  // keep the state to do not refresh when switch navbar
  @override
  bool get wantKeepAlive => true;

  ///new bloc list
  late FetchcategoriesBloc _fetchcategoriesBloc;
  late AccountBloc _accountBloc;

  @override
  void initState() {
    _homebannerBloc = BlocProvider.of<HomebannerBloc>(context);
    _homebannerBloc.add(GetBannerEvent());

    _topSaleBloc = BlocProvider.of<TopsellingBloc>(context);
    _topSaleBloc.add(TopsellingDataEvent());

    _brandBloc = BlocProvider.of<BrandsBloc>(context);
    _brandBloc.add(BrandsDataEvent());

    _tagBloc = BlocProvider.of<TagsBloc>(context);
    _tagBloc.add(TagDataEvent());

    _accountBloc = BlocProvider.of<AccountBloc>(context);
    _accountBloc.add(AccountInfoEvent());

    // _categoryForYouBloc = BlocProvider.of<CategoryForYouBloc>(context);
    // _categoryForYouBloc
    //     .add(GetCategoryForYou(sessionId: SESSION_ID, apiToken: apiToken));

    // _recomendedProductBloc = BlocProvider.of<RecomendedProductBloc>(context);
    // _recomendedProductBloc.add(GetRecomendedProduct(
    //     sessionId: SESSION_ID,
    //     skip: _apiPageRecomended.toString(),
    // limit: LIMIT_PAGE.toString(),
    //apiToken: apiToken));

    setupAnimateAppbar();

    // set how many times left for flashsale
    var timeNow = DateTime.now();

    // 8000 second = 2 hours 13 minutes 20 second for flashsale timer

    ///new bloc list
    _fetchcategoriesBloc = BlocProvider.of<FetchcategoriesBloc>(context);
    _fetchcategoriesBloc.add(FetchAllcategoriesEvent());
    print(userToken);

    super.initState();
  }

  @override
  void dispose() {
    apiToken.cancel("cancelled"); // cancel fetch data from API

    _scrollController.dispose();
    _topColorAnimationController.dispose();
    super.dispose();
  }

  void setupAnimateAppbar() {
    // use this function and paramater to animate top bar
    _topColorAnimationController =
        AnimationController(vsync: this, duration: Duration(seconds: 0));
    _appBarColor = ColorTween(begin: Colors.transparent, end: Colors.white)
        .animate(_topColorAnimationController);
    _scrollController = ScrollController()
      ..addListener(() {
        _topColorAnimationController.animateTo(_scrollController.offset / 120);
        // if scroll for above 150, then change app bar color to white, search button to dark, and top icon color to dark
        // if scroll for below 150, then change app bar color to transparent, search button to white and top icon color to light
        if (_scrollController.hasClients &&
            _scrollController.offset > (150 - kToolbarHeight)) {
          if (_topIconColor != BLACK_GREY) {
            _topIconColor = BLACK_GREY;
            _topSearchColor = Colors.grey[100]!;
            _appBarSystemOverlayStyle = SystemUiOverlayStyle.dark;
          }
        } else {
          if (_topIconColor != Colors.white) {
            _topIconColor = Colors.white;
            _topSearchColor = Colors.white;
            _appBarSystemOverlayStyle = SystemUiOverlayStyle.light;
          }
        }
      });
  }

  // this function used to fetch data from API if we scroll to the bottom of the page
  void _onScroll() {
    double maxScroll = _scrollController.position.maxScrollExtent;
    double currentScroll = _scrollController.position.pixels;

    if (currentScroll == maxScroll) {
      // if (_lastDataRecomended == false && !_processApiRecomended) {
      //   _recomendedProductBloc.add(GetRecomendedProduct(
      //       sessionId: SESSION_ID,
      //       skip: _apiPageRecomended.toString(),
      //       limit: LIMIT_PAGE.toString(),
      //       apiToken: apiToken));
      //   _processApiRecomended = true;
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    // if we used AutomaticKeepAliveClientMixin, we must call super.build(context);
    super.build(context);

    final double boxImageSize = (MediaQuery.of(context).size.width / 3);
    //final double categoryForYouHeightShort = boxImageSize;
    //final double categoryForYouHeightLong = (boxImageSize * 2);

    return Scaffold(
      body: MultiBlocListener(
        listeners: [
          BlocListener<HomebannerBloc, HomebannerState>(
            listener: (context, state) {
              if (state is BannerError) {
                _globalFunction.showToast(
                    type: 'error', message: state.errorMessage);
              }
              if (state is BannerSuccess) {
                if (state.data.length == 0) {
                  _lastDataHomeBanner = true;
                } else {
                  homeBannerData.addAll(state.data);
                }
              }
            },
          ),
          BlocListener<TopsellingBloc, TopsellingState>(
            listener: (context, state) {
              if (state is TopsellingError) {
                _globalFunction.showToast(
                    type: 'error', message: state.errorMessage);
              }
              if (state is TopsellingSuccess) {
                if (state.data.length == 0) {
                  _lastDatatopsale = true;
                } else {
                  topSaleData.addAll(state.data);
                }
              }
            },
          ),
          BlocListener<BrandsBloc, BrandsState>(
            listener: (context, state) {
              if (state is BrandsError) {
                _globalFunction.showToast(
                    type: 'error', message: state.errorMessage);
              }
              if (state is BrandsSuccess) {
                if (state.data.length == 0) {
                  _lastDatabrand = true;
                } else {
                  brandData.addAll(state.data);
                }
              }
            },
          ),
          BlocListener<TagsBloc, TagsState>(
            listener: (context, state) {
              if (state is TagsError) {
                _globalFunction.showToast(
                    type: 'error', message: state.errorMessage);
              }
              if (state is TagsSuccess) {
                tagsData.addAll(state.data);
              }
            },
          ),
          // BlocListener<CategoryForYouBloc, CategoryForYouState>(
          //   listener: (context, state) {
          //     if (state is CategoryForYouError) {
          //       _globalFunction.showToast(
          //           type: 'error', message: state.errorMessage);
          //     }
          //     if (state is GetCategoryForYouSuccess) {
          //       if (state.categoryForYouData.length == 0) {
          //         _lastDataCategoryForYou = true;
          //       } else {
          //         categoryForYouData.addAll(state.categoryForYouData);
          //       }
          //     }
          //   },
          // ),
          // BlocListener<RecomendedProductBloc, RecomendedProductState>(
          //   listener: (context, state) {
          //     if (state is RecomendedProductError) {
          //       _globalFunction.showToast(
          //           type: 'error', message: state.errorMessage);
          //     }
          //     if (state is GetRecomendedProductSuccess) {
          //       _scrollController.addListener(_onScroll);
          //       if (state.recomendedProductData.length == 0) {
          //         _lastDataRecomended = true;
          //       } else {
          //         _apiPageRecomended += LIMIT_PAGE;
          //         recomendedProductData.addAll(state.recomendedProductData);
          //       }
          //       _processApiRecomended = false;
          //     }
          //   },
          // ),
          BlocListener<FetchcategoriesBloc, FetchcategoriesState>(
            listener: (context, state) {
              if (state is FetchcategoriesError) {
                _globalFunction.showToast(
                    type: 'error', message: state.errorMessage);
              }
              if (state is FetchcategoriesSuccess) {
                if (state.data.length == 0) {
                  _lastDataCategory = true;
                } else {
                  categoryData.addAll(state.data);
                }
              }
            },
          ),
        ],
        child: RefreshIndicator(
          onRefresh: refreshData,
          child: Stack(
            children: [
              CustomScrollView(
                controller: _scrollController,
                slivers: [
                  SliverList(
                      delegate: SliverChildListDelegate([
                    _createHomeBannerSlider(),
                    //_createCoupon(),
                    _createGridCategory(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 3, horizontal: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Top Selling", style: GlobalStyle.sectionTitle),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => topSellingPage()));
                            },
                            child: Text(
                                AppLocalizations.of(context)!
                                    .translate('view_all')!,
                                style: GlobalStyle.viewAll,
                                textAlign: TextAlign.end),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 16),
                      height: boxImageSize *
                          GlobalStyle.horizontalProductHeightMultiplication,
                      child: BlocBuilder<TopsellingBloc, TopsellingState>(
                        builder: (context, state) {
                          if (state is TopsellingError) {
                            return Container(
                                child: Center(
                                    child: Text(ERROR_OCCURED,
                                        style: TextStyle(
                                            fontSize: 14, color: BLACK_GREY))));
                          } else {
                            if (_lastDatatopsale) {
                              return Container(
                                  child: Center(
                                      child: Text(
                                          "No any top selling product found!",
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: BLACK_GREY))));
                            } else {
                              if (topSaleData.length == 0) {
                                return _shimmerLoading
                                    .buildShimmerHomeFlashsale(boxImageSize);
                              } else {
                                return ListView.builder(
                                  padding: EdgeInsets.only(left: 12, right: 12),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 5,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return _buildTopsaleCard(
                                        index, boxImageSize);
                                  },
                                );
                              }
                            }
                          }
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 30, left: 16, right: 16),
                      child: Text("Tags", style: GlobalStyle.sectionTitle),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 8),
                        height: boxImageSize *
                            GlobalStyle.horizontalProductHeightMultiplication /
                            4 *
                            1.45,
                        child: BlocBuilder<TagsBloc, TagsState>(
                            builder: (context, state) {
                          if (state is TagsError) {
                            return Container(
                                child: Center(
                                    child: Text(ERROR_OCCURED,
                                        style: TextStyle(
                                            fontSize: 14, color: BLACK_GREY))));
                          } else {
                            if (tagsData.length == 0) {
                              return _shimmerLoading
                                  .buildShimmerHorizontalProduct(boxImageSize);
                            } else {
                              return ListView.builder(
                                padding: EdgeInsets.only(
                                    left: 12, right: 12, top: 10),
                                scrollDirection: Axis.horizontal,
                                itemCount: tagsData.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: (() {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                TagProductsPage(
                                                  id: tagsData[index].id,
                                                  title: tagsData[index].name,
                                                )),
                                      );
                                    }),
                                    child: Container(
                                      child: Column(children: [
                                        buildCacheNetworkImage(
                                            height: 35,
                                            url: tagsData[index].image != null
                                                ? "$BASE_IMAGE_URL${tagsData[index].image}"
                                                : "https://hamrowholesale.com/front/assets/image/catalog/demo/logo/logo-old.png",
                                            plColor: Colors.transparent),
                                        Flexible(
                                          child: Container(
                                            width: 80,
                                            margin: EdgeInsets.fromLTRB(
                                                0, 10, 0, 0),
                                            child: Text(
                                              tagsData[index].name,
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
                    // Container(
                    //   margin: EdgeInsets.fromLTRB(12, 0, 12, 0),
                    //   child: BlocBuilder<HomeTrendingBloc, HomeTrendingState>(
                    //     builder: (context, state) {
                    //       if (state is HomeTrendingError) {
                    //         return Container(
                    //             child: Center(
                    //                 child: Text(ERROR_OCCURED,
                    //                     style: TextStyle(
                    //                         fontSize: 14, color: BLACK_GREY))));
                    //       } else {
                    //         if (_lastDataTag) {
                    //           return Container(
                    //               child: Center(
                    //                   child: Text(
                    //                       AppLocalizations.of(context)!
                    //                           .translate(
                    //                               'no_trending_product')!,
                    //                       style: TextStyle(
                    //                           fontSize: 14,
                    //                           color: BLACK_GREY))));
                    //         } else {
                    //           if (tagsData.length == 0) {
                    //             return _shimmerLoading.buildShimmerTrending(
                    //                 MediaQuery.of(context).size.width / 2);
                    //           } else {
                    //             return GridView.count(
                    //               padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                    //               primary: false,
                    //               childAspectRatio: 4 / 1.6,
                    //               shrinkWrap: true,
                    //               crossAxisSpacing: 2,
                    //               mainAxisSpacing: 2,
                    //               crossAxisCount: 2,
                    //               children:
                    //                   List.generate(tagsData.length, (index) {
                    //                 return _buildTrendingProductCard(index);
                    //               }),
                    //             );
                    //           }
                    //         }
                    //       }
                    //     },
                    //   ),
                    // ),
                    Container(
                      margin: EdgeInsets.only(top: 30, left: 16, right: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Top Brands", style: GlobalStyle.sectionTitle),
                          // GestureDetector(
                          //   onTap: () {
                          //     Navigator.push(
                          //         context,
                          //         MaterialPageRoute(
                          //             builder: (context) => LastSearchPage()));
                          //   },
                          //   child: Text(
                          //       AppLocalizations.of(context)!
                          //           .translate('view_all')!,
                          //       style: GlobalStyle.viewAll,
                          //       textAlign: TextAlign.end),
                          // )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 16),
                      height: 100,

                      //  boxImageSize *
                      //     GlobalStyle.horizontalProductHeightMultiplication,
                      child: BlocBuilder<BrandsBloc, BrandsState>(
                        builder: (context, state) {
                          if (state is BrandsError) {
                            return Container(
                                child: Center(
                                    child: Text(ERROR_OCCURED,
                                        style: TextStyle(
                                            fontSize: 14, color: BLACK_GREY))));
                          } else {
                            if (_lastDatabrand) {
                              return Container(
                                  child: Center(
                                      child: Text("No any brand found",
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: BLACK_GREY))));
                            } else {
                              if (brandData.length == 0) {
                                return _shimmerLoading
                                    .buildShimmerHorizontalProduct(
                                        boxImageSize);
                              } else {
                                return ListView.builder(
                                  padding: EdgeInsets.only(
                                      left: 12, right: 12, top: 10),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: brandData.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  BrandProductPage(
                                                    id: brandData[index].id,
                                                    title:
                                                        brandData[index].name,
                                                  )),
                                        );
                                      },
                                      child: Container(
                                        //padding: EdgeInsets.symmetric(horizontal: 5),
                                        child: Column(children: [
                                          buildCacheNetworkImage(
                                              // width: 35,
                                              height: 35,
                                              url: brandData[index].logo != null
                                                  ? "$BASE_IMAGE_URL${brandData[index].logo}"
                                                  : "https://www.meroshopping.com/front/assets/image/catalog/demo/logo/logo-old.png",
                                              plColor: Colors.transparent),
                                          Flexible(
                                            child: Container(
                                              width: 100,
                                              margin: EdgeInsets.fromLTRB(
                                                  5, 10, 5, 0),
                                              child: Text(
                                                brandData[index].name,
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
                          }
                        },
                      ),
                    ),
                    // Container(
                    //   margin: EdgeInsets.only(top: 30, left: 16, right: 16),
                    //   child: Text(
                    //       AppLocalizations.of(context)!
                    //           .translate('category_for_you')!,
                    //       style: GlobalStyle.sectionTitle),
                    // ),
                    // _createCategoryForYou(boxImageSize,
                    //   categoryForYouHeightShort, categoryForYouHeightLong),
                    // Container(
                    //   margin: EdgeInsets.only(top: 30, left: 16, right: 16),
                    //   child: Text(
                    //       AppLocalizations.of(context)!
                    //           .translate('recomended_product')!,
                    //       style: GlobalStyle.sectionTitle),
                    // ),
                    // BlocBuilder<RecomendedProductBloc, RecomendedProductState>(
                    //   builder: (context, state) {
                    //     if (state is RecomendedProductError) {
                    //       return Container(
                    //           child: Center(
                    //               child: Text(ERROR_OCCURED,
                    //                   style: TextStyle(
                    //                       fontSize: 14, color: BLACK_GREY))));
                    //     } else {
                    //       if (_lastDataRecomended && _apiPageRecomended == 0) {
                    //         return Container(
                    //             child: Text(
                    //                 AppLocalizations.of(context)!
                    //                     .translate('no_recomended_product')!,
                    //                 style: TextStyle(
                    //                     fontSize: 14, color: BLACK_GREY)));
                    //       } else {
                    //         if (recomendedProductData.length == 0) {
                    //           return _shimmerLoading.buildShimmerProduct(
                    //               ((MediaQuery.of(context).size.width) - 24) /
                    //                       2 -
                    //                   12);
                    //         } else {
                    //           return CustomScrollView(
                    //               shrinkWrap: true,
                    //               primary: false,
                    //               slivers: <Widget>[
                    //                 SliverPadding(
                    //                   padding:
                    //                       EdgeInsets.fromLTRB(12, 8, 12, 8),
                    //                   sliver: SliverGrid(
                    //                     gridDelegate:
                    //                         SliverGridDelegateWithFixedCrossAxisCount(
                    //                       crossAxisCount: 2,
                    //                       mainAxisSpacing: 8,
                    //                       crossAxisSpacing: 8,
                    //                       childAspectRatio:
                    //                           GlobalStyle.gridDelegateRatio,
                    //                     ),
                    //                     delegate: SliverChildBuilderDelegate(
                    //                       (BuildContext context, int index) {
                    //                         return _globalWidget
                    //                             .buildProductGrid(
                    //                                 context,
                    //                                 recomendedProductData[
                    //                                     index]);
                    //                       },
                    //                       childCount:
                    //                           recomendedProductData.length,
                    //                     ),
                    //                   ),
                    //                 ),
                    //                 SliverToBoxAdapter(
                    //                   child:
                    //                       (_apiPageRecomended == LIMIT_PAGE &&
                    //                               recomendedProductData.length <
                    //                                   LIMIT_PAGE)
                    //  ? Wrap()
                    //                           : _globalWidget
                    //                               .buildProgressIndicator(
                    //                                   _lastDataRecomended),
                    //                 ),
                    //               ]);
                    //         }
                    //       }
                    //     }
                    //   },
                    // ),
                  ])),
                ],
              ),
              // Create AppBar with Animation
              Container(
                height: AppBar().preferredSize.height +
                    MediaQuery.of(context).padding.top -
                    20 +
                    22,
                child: AnimatedBuilder(
                  animation: _topColorAnimationController,
                  builder: (context, child) => AppBar(
                    backgroundColor: _appBarColor.value,
                    systemOverlayStyle: _appBarSystemOverlayStyle,
                    elevation: GlobalStyle.appBarElevation,
                    title: Container(
                      child: TextButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) => _topSearchColor,
                            ),
                            overlayColor:
                                MaterialStateProperty.all(Colors.transparent),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            )),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SearchPage()));
                          },
                          child: Row(
                            children: [
                              SizedBox(width: 8),
                              Icon(
                                Icons.search,
                                color: Colors.grey[500],
                                size: 18,
                              ),
                              SizedBox(width: 8),
                              Text(
                                AppLocalizations.of(context)!
                                    .translate('search_product')!,
                                style: TextStyle(
                                    color: Colors.grey[500],
                                    fontWeight: FontWeight.normal),
                              )
                            ],
                          )),
                    ),
                    actions: [
                      // GestureDetector(
                      //   onTap: () {
                      //     Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //         builder: (context) => ChatUsPage(),
                      //       ),
                      //     );
                      //   },
                      //   child: Icon(
                      //     Icons.email,
                      //     color: _topIconColor,
                      //   ),
                      // ),

                      // IconButton(
                      //     icon: _globalWidget.customNotifIcon(8, _topIconColor),
                      //     onPressed: () {
                      //       Navigator.push(
                      //           context,
                      //           MaterialPageRoute(
                      //               builder: (context) => NotificationPage()));
                      //     }),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future refreshData() async {
    //_apiPageRecomended = 0;
    homeBannerData.clear();
    topSaleData.clear();
    brandData.clear();
    tagsData.clear();
    //categoryForYouData.clear();
    categoryData.clear();
    // recomendedProductData.clear();
    // _homeBannerBloc
    //     .add(GetHomeBanner(sessionId: SESSION_ID, apiToken: apiToken));
    _topSaleBloc.add(TopsellingDataEvent());
    _brandBloc.add(BrandsDataEvent());
    _tagBloc.add(TagDataEvent());
    // _categoryForYouBloc
    // .add(GetCategoryForYou(sessionId: SESSION_ID, apiToken: apiToken));
    //_categoryBloc.add(GetCategory(sessionId: SESSION_ID, apiToken: apiToken));
    // _recomendedProductBloc.add(GetRecomendedProduct(
    //     sessionId: SESSION_ID,
    //     skip: _apiPageRecomended.toString(),
    //     limit: LIMIT_PAGE.toString(),
    //     apiToken: apiToken));
    // setState(() {
    // });
  }

  Widget _createHomeBannerSlider() {
    double homeBannerWidth = MediaQuery.of(context).size.width;
    double homeBannerHeight = MediaQuery.of(context).size.width * 6 / 8;

    return BlocBuilder<HomebannerBloc, HomebannerState>(
      builder: (context, state) {
        if (state is BannerError) {
          return Container(
            width: homeBannerWidth,
            height: homeBannerHeight,
            child: Center(
              child: Text(
                ERROR_OCCURED,
                style: TextStyle(
                  fontSize: 14,
                  color: BLACK_GREY,
                ),
              ),
            ),
          );
        } else {
          if (_lastDataHomeBanner) {
            return Container(
                width: homeBannerWidth,
                height: homeBannerHeight,
                child: Center(
                    child: Text(
                        AppLocalizations.of(context)!
                            .translate('no_home_banner_data')!,
                        style: TextStyle(fontSize: 14, color: BLACK_GREY))));
          } else {
            if (homeBannerData.length == 0) {
              return _shimmerLoading.buildShimmerHomeBanner(
                  homeBannerWidth, homeBannerHeight);
            } else {
              return Column(
                children: [
                  CarouselSlider(
                    items: homeBannerData
                        .map((item) => Container(
                              child: buildCacheNetworkImage(
                                  width: 0,
                                  height: 0,
                                  url: item.image != null
                                      ? "$BASE_IMAGE_URL${item.image}"
                                      : "https://hamrowholesale.com/front/assets/image/catalog/demo/logo/logo-old.png"),
                            ))
                        .toList(),
                    options: CarouselOptions(
                        aspectRatio: 8 / 6,
                        viewportFraction: 1.0,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 6),
                        autoPlayAnimationDuration: Duration(milliseconds: 300),
                        enlargeCenterPage: false,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _currentImageSlider = index;
                          });
                        }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: homeBannerData.map((item) {
                      int index = homeBannerData.indexOf(item);
                      return Container(
                        width: 8.0,
                        height: 8.0,
                        margin: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 2.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentImageSlider == index
                              ? PRIMARY_COLOR
                              : Colors.grey[300],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              );
            }
          }
        }
      },
    );
  }

  // Widget _createCoupon() {
  //   return GestureDetector(
  //     behavior: HitTestBehavior.translucent,
  //     onTap: () {
  //       Navigator.push(
  //           context, MaterialPageRoute(builder: (context) => CouponPage()));
  //     },
  //     child: Container(
  //       padding: EdgeInsets.all(12),
  //       margin: EdgeInsets.all(16.0),
  //       decoration: BoxDecoration(
  //           color: SOFT_BLUE, borderRadius: BorderRadius.circular(5)),
  //       child: Row(
  //         children: [
  //           Expanded(
  //             child: Container(
  //               child: Text(
  //                 AppLocalizations.of(context)!.translate('coupon_waiting')!,
  //                 style: TextStyle(
  //                     fontSize: 14,
  //                     color: Color(0xffffffff),
  //                     fontWeight: FontWeight.bold),
  //               ),
  //             ),
  //           ),
  //           Icon(Icons.local_offer, color: Colors.white)
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Widget _buildFlashsaleTime() {
  //   return Row(
  //     children: [
  //       Text(' : ',
  //           style: TextStyle(
  //               color: Colors.red, fontSize: 13, fontWeight: FontWeight.bold)),
  //       Text(' : ',
  //           style: TextStyle(
  //               color: Colors.red, fontSize: 13, fontWeight: FontWeight.bold)),
  //     ],
  //   );
  // }

  Widget _createGridCategory() {
    return BlocBuilder<FetchcategoriesBloc, FetchcategoriesState>(
      builder: (context, state) {
        if (state is FetchcategoriesError) {
          return Container(
              child: Center(
                  child: Text(ERROR_OCCURED,
                      style: TextStyle(fontSize: 14, color: BLACK_GREY))));
        } else {
          if (_lastDataCategory) {
            return Wrap();
          } else {
            if (categoryData.length == 0) {
              return _shimmerLoading.buildShimmerCategory();
            } else {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Categories",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w800)),
                        GestureDetector(
                          onTap: (() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AllcategoryPage()));
                          }),
                          child: Text("View All",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.green,
                                  fontWeight: FontWeight.w600)),
                        ),
                      ],
                    ),
                  ),
                  GridView.count(
                    padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
                    primary: false,
                    childAspectRatio: 1.1,
                    shrinkWrap: true,
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 0,
                    crossAxisCount: 4,
                    children: List.generate(8, (index) {
                      return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductCategoryPage(
                                        categoryId: categoryData[index].id,
                                        categoryName:
                                            categoryData[index].title)));
                          },
                          child: Column(children: [
                            buildCacheNetworkImage(
                                width: 25,
                                height: 25,
                                url:
                                    "$BASE_IMAGE_URL${categoryData[index].icon}",
                                plColor: Colors.transparent),
                            Flexible(
                              child: Container(
                                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                child: Text(
                                  categoryData[index].title,
                                  style: TextStyle(
                                    color: CHARCOAL,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 12,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            )
                          ]));
                    }),
                  ),
                ],
              );
            }
          }
        }
      },
    );
  }

  // Widget _buildLastBox(boxImageSize, StatefulWidget page) {
  //   return Container(
  //     width: boxImageSize + 10,
  //     child: Card(
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(10),
  //       ),
  //       elevation: 2,
  //       color: Colors.white,
  //       child: GestureDetector(
  //         behavior: HitTestBehavior.translucent,
  //         onTap: () {
  //           Navigator.push(
  //               context, MaterialPageRoute(builder: (context) => page));
  //         },
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: <Widget>[
  //             Container(
  //               width: 50,
  //               child: TextButton(
  //                   style: ButtonStyle(
  //                     backgroundColor: MaterialStateProperty.resolveWith<Color>(
  //                       (Set<MaterialState> states) => PRIMARY_COLOR,
  //                     ),
  //                     overlayColor:
  //                         MaterialStateProperty.all(Colors.transparent),
  //                     shape: MaterialStateProperty.all(RoundedRectangleBorder(
  //                       borderRadius: BorderRadius.circular(3.0),
  //                     )),
  //                   ),
  //                   onPressed: () {
  //                     Navigator.push(context,
  //                         MaterialPageRoute(builder: (context) => page));
  //                   },
  //                   child: Text(
  //                     AppLocalizations.of(context)!.translate('go')!,
  //                     style: TextStyle(
  //                         fontSize: 14,
  //                         fontWeight: FontWeight.bold,
  //                         color: Colors.white),
  //                     textAlign: TextAlign.center,
  //                   )),
  //             ),
  //             SizedBox(
  //               height: 10,
  //             ),
  //             Text(
  //               AppLocalizations.of(context)!
  //                   .translate('check_another_product')!,
  //               style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
  //               textAlign: TextAlign.center,
  //             )
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _buildTopsaleCard(index, boxImageSize) {
    return Container(
      width: boxImageSize + 10,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 2,
        color: Colors.white,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProductDetailPage(
                          urlName: topSaleData[index].urlname,
                        )));
          },
          child: Column(
            children: <Widget>[
              Stack(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                      child: buildCacheNetworkImage(
                          width: boxImageSize + 10,
                          height: boxImageSize + 10,
                          url:
                              "$BASE_IMAGE_URL${topSaleData[index].filename}")),
                  // Positioned(
                  //   right: 0,
                  //   top: 10,
                  //   child: Container(
                  //     decoration: BoxDecoration(
                  //         color: Colors.red,
                  //         borderRadius: BorderRadius.only(
                  //             topLeft: Radius.circular(6),
                  //             bottomLeft: Radius.circular(6))),
                  //     padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
                  //     child: Text("",
                  //         style: TextStyle(
                  //             color: Colors.white,
                  //             fontWeight: FontWeight.bold,
                  //             fontSize: 12)),
                  //   ),
                  // )
                ],
              ),
              Container(
                margin: EdgeInsets.fromLTRB(8, 8, 8, 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      topSaleData[index].name,
                      style: GlobalStyle.productName,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 8),
                    // Container(
                    //   margin: EdgeInsets.only(top: 5),
                    //   child: Text('Rs. ' + topSaleData[index].price.toString(),
                    //       style: GlobalStyle.productPriceDiscounted),
                    // ),
                    Container(
                      margin: EdgeInsets.only(top: 2),
                      child: Text('Rs. ' + topSaleData[index].price.toString(),
                          style: GlobalStyle.productPrice),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // Widget _buildTrendingProductCard(index) {
  //   return GestureDetector(
  //     onTap: () {
  //       StatefulWidget menuPage =
  //           SearchProductPage(words: tagsData[index].name);
  //       Navigator.push(
  //           context, MaterialPageRoute(builder: (context) => menuPage));
  //     },
  //     child: Card(
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(10),
  //         ),
  //         elevation: 2,
  //         color: Colors.white,
  //         child: Row(
  //           children: [
  //             ClipRRect(
  //                 borderRadius: BorderRadius.only(
  //                     topLeft: Radius.circular(10),
  //                     bottomLeft: Radius.circular(10)),
  //                 child: buildCacheNetworkImage(
  //                     width:
  //                         (MediaQuery.of(context).size.width / 2) * (1.6 / 4) -
  //                             12 -
  //                             1,
  //                     height:
  //                         (MediaQuery.of(context).size.width / 2) * (1.6 / 4) -
  //                             12 -
  //                             1,
  //                     url: tagsData[index].image)),
  //             Expanded(
  //               child: Container(
  //                 margin: EdgeInsets.all(10),
  //                 child: Column(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Text(tagsData[index].name,
  //                         style: TextStyle(
  //                             fontSize: 11, fontWeight: FontWeight.bold)),
  //                     SizedBox(height: 4),
  //                     Text(
  //                         tagsData[index].sale +
  //                             ' ' +
  //                             AppLocalizations.of(context)!
  //                                 .translate('product')!,
  //                         style: TextStyle(fontSize: 9, color: BLACK_GREY))
  //                   ],
  //                 ),
  //               ),
  //             )
  //           ],
  //         )),
  //   );
  // }

  // Widget _createCategoryForYou(
  //     boxImageSize, categoryForYouHeightShort, categoryForYouHeightLong) {
  //   return BlocBuilder<CategoryForYouBloc, CategoryForYouState>(
  //     builder: (context, state) {
  //       if (state is CategoryForYouError) {
  //         return Container(
  //             width: categoryForYouHeightShort * 3,
  //             height: categoryForYouHeightLong,
  //             child: Center(
  //                 child: Text(ERROR_OCCURED,
  //                     style: TextStyle(fontSize: 14, color: BLACK_GREY))));
  //       } else {
  //         if (_lastDataCategoryForYou) {
  //           return Container(
  //               width: categoryForYouHeightShort * 3,
  //               height: categoryForYouHeightLong,
  //               child: Center(
  //                   child: Text(
  //                       AppLocalizations.of(context)!
  //                           .translate('no_category_for_you')!,
  //                       style: TextStyle(fontSize: 14, color: BLACK_GREY))));
  //         } else {
  //           if (categoryForYouData.length == 0) {
  //             return _shimmerLoading.buildShimmerCategoryForYou(
  //                 categoryForYouHeightShort * 3, categoryForYouHeightLong);
  //           } else {
  //             return Container(
  //               margin: EdgeInsets.only(top: 8),
  //               width: MediaQuery.of(context).size.width,
  //               height: categoryForYouHeightLong,
  //               child: Row(
  //                 children: [
  //                   GestureDetector(
  //                     onTap: () {
  //                       Navigator.push(
  //                           context,
  //                           MaterialPageRoute(
  //                               builder: (context) => ProductCategoryPage(
  //                                   categoryId: categoryForYouData[0].id,
  //                                   categoryName: categoryData[0].name)));
  //                     },
  //                     child: Container(
  //                       width: boxImageSize,
  //                       height: categoryForYouHeightLong,
  //                       child: buildCacheNetworkImage(
  //                           width: 0,
  //                           height: 0,
  //                           url: categoryForYouData[0].image),
  //                     ),
  //                   ),
  //                   Column(
  //                     children: [
  //                       Row(
  //                         children: [
  //                           GestureDetector(
  //                             onTap: () {
  //                               Navigator.push(
  //                                   context,
  //                                   MaterialPageRoute(
  //                                       builder: (context) =>
  //                                           ProductCategoryPage(
  //                                               categoryId:
  //                                                   categoryForYouData[1].id,
  //                                               categoryName:
  //                                                   categoryData[1].name)));
  //                             },
  //                             child: Container(
  //                               width: boxImageSize,
  //                               height: categoryForYouHeightShort,
  //                               child: buildCacheNetworkImage(
  //                                   width: 0,
  //                                   height: 0,
  //                                   url: categoryForYouData[1].image),
  //                             ),
  //                           ),
  //                           GestureDetector(
  //                             onTap: () {
  //                               Navigator.push(
  //                                   context,
  //                                   MaterialPageRoute(
  //                                       builder: (context) =>
  //                                           ProductCategoryPage(
  //                                               categoryId:
  //                                                   categoryForYouData[2].id,
  //                                               categoryName:
  //                                                   categoryData[2].name)));
  //                             },
  //                             child: Container(
  //                               width: boxImageSize,
  //                               height: categoryForYouHeightShort,
  //                               child: buildCacheNetworkImage(
  //                                   width: 0,
  //                                   height: 0,
  //                                   url: categoryForYouData[2].image),
  //                             ),
  //                           )
  //                         ],
  //                       ),
  //                       Row(
  //                         children: [
  //                           GestureDetector(
  //                             onTap: () {
  //                               Navigator.push(
  //                                   context,
  //                                   MaterialPageRoute(
  //                                       builder: (context) =>
  //                                           ProductCategoryPage(
  //                                               categoryId:
  //                                                   categoryForYouData[3].id,
  //                                               categoryName:
  //                                                   categoryData[3].name)));
  //                             },
  //                             child: Container(
  //                               width: boxImageSize,
  //                               height: categoryForYouHeightShort,
  //                               child: buildCacheNetworkImage(
  //                                   width: 0,
  //                                   height: 0,
  //                                   url: categoryForYouData[3].image),
  //                             ),
  //                           ),
  //                           GestureDetector(
  //                             onTap: () {
  //                               Navigator.push(
  //                                   context,
  //                                   MaterialPageRoute(
  //                                       builder: (context) =>
  //                                           ProductCategoryPage(
  //                                               categoryId:
  //                                                   categoryForYouData[4].id,
  //                                               categoryName:
  //                                                   categoryData[4].name)));
  //                             },
  //                             child: Container(
  //                               width: boxImageSize,
  //                               height: categoryForYouHeightShort,
  //                               child: buildCacheNetworkImage(
  //                                   width: 0,
  //                                   height: 0,
  //                                   url: categoryForYouData[4].image),
  //                             ),
  //                           )
  //                         ],
  //                       )
  //                     ],
  //                   )
  //                 ],
  //               ),
  //             );
  //           }
  //         }
  //       }
  //     },
  //   );
  // }
}
