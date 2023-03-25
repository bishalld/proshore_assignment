/*
This is flash sale page

include file in reuseable/global_function.dart to call function from GlobalFunction
include file in reuseable/global_widget.dart to call function from GlobalWidget
include file in reuseable/cache_image_network.dart to use cache image network
include file in reuseable/shimmer_loading.dart to use shimmer loading
include file in model/home/flashsale_model.dart to get topsaleData
 */

import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meroshopping_flutter/bloc/products/checkout/topsellingbloc/topselling_bloc.dart';
import 'package:meroshopping_flutter/config/constants.dart';
import 'package:meroshopping_flutter/config/global_style.dart';
import 'package:meroshopping_flutter/ui/general/product_detail/product_detail.dart';
import 'package:meroshopping_flutter/ui/reuseable/app_localizations.dart';
import 'package:meroshopping_flutter/ui/reuseable/cache_image_network.dart';
import 'package:meroshopping_flutter/ui/reuseable/global_function.dart';
import 'package:meroshopping_flutter/ui/reuseable/global_widget.dart';
import 'package:meroshopping_flutter/ui/reuseable/shimmer_loading.dart';

class topSellingPage extends StatefulWidget {
  const topSellingPage({Key? key}) : super(key: key);
  @override
  _topSellingPageState createState() => _topSellingPageState();
}

class _topSellingPageState extends State<topSellingPage> {
  // initialize global function, global widget and shimmer loading
  final _globalFunction = GlobalFunction();
  final _globalWidget = GlobalWidget();
  final _shimmerLoading = ShimmerLoading();

  List topsaleData = [];

  late TopsellingBloc _topsaleBloc;
  int _apiPage = 0;
  ScrollController _scrollController = ScrollController();
  bool _lastData = false;
  bool _processApi = false;

  CancelToken apiToken = CancelToken(); // used to cancel fetch data from API

  @override
  void initState() {
    // get data when initState
    _topsaleBloc = BlocProvider.of<TopsellingBloc>(context);
    _topsaleBloc.add(TopsellingDataEvent());
    setState(() {});

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
      if (_lastData == false && !_processApi) {
        _topsaleBloc.add(TopsellingDataEvent());
        _processApi = true;
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
            "Top Selling Products",
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
            child: BlocListener<TopsellingBloc, TopsellingState>(
              listener: (context, state) {
                if (state is TopsellingError) {
                  _globalFunction.showToast(
                      type: 'error', message: state.errorMessage);
                }
                if (state is TopsellingSuccess) {
                  _scrollController.addListener(_onScroll);
                  if (state.data.length == 0) {
                    _lastData = true;
                  } else {
                    _apiPage += LIMIT_PAGE;
                    topsaleData.addAll(state.data);
                  }
                  _processApi = false;
                }
              },
              child: ListView(
                controller: _scrollController,
                physics: AlwaysScrollableScrollPhysics(),
                children: [
                  // buildCacheNetworkImage(
                  //     width: MediaQuery.of(context).size.width,
                  //     height: MediaQuery.of(context).size.width / 2,
                  //     url: GLOBAL_URL + '/flashsale/1.jpg'),
                  // Container(
                  //   margin: EdgeInsets.all(16),
                  // ),
                  BlocBuilder<TopsellingBloc, TopsellingState>(
                    builder: (context, state) {
                      if (state is TopsellingError) {
                        return Container(
                            child: Center(
                                child: Text(ERROR_OCCURED,
                                    style: TextStyle(
                                        fontSize: 14, color: BLACK_GREY))));
                      } else {
                        if (_lastData && _apiPage == 0) {
                          return Container(
                              child: Center(
                                  child: Text(
                                      AppLocalizations.of(context)!
                                          .translate('no_flash_sale')!,
                                      style: TextStyle(
                                          fontSize: 14, color: BLACK_GREY))));
                        } else {
                          if (topsaleData.length == 0) {
                            return _shimmerLoading.buildShimmerFlashsale(
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
                                        childAspectRatio: GlobalStyle
                                            .gridDelegateFlashsaleRatio,
                                      ),
                                      delegate: SliverChildBuilderDelegate(
                                        (BuildContext context, int index) {
                                          return _buildFlashsaleCard(index);
                                        },
                                        childCount: topsaleData.length,
                                      ),
                                    ),
                                  ),
                                  // SliverToBoxAdapter(
                                  //   child: (_apiPage == LIMIT_PAGE &&
                                  //           topsaleData.length < LIMIT_PAGE)
                                  //       ? Wrap()
                                  //       : _globalWidget
                                  //           .buildProgressIndicator(_lastData),
                                  // ),
                                ]);
                          }
                        }
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ));
  }

  Widget _buildFlashsaleCard(index) {
    final double boxImageSize =
        ((MediaQuery.of(context).size.width) - 24) / 2 - 12;
    return Container(
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
                          urlName: topsaleData[index].urlname,
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
                          width: boxImageSize,
                          height: boxImageSize,
                          url:
                              "$BASE_IMAGE_URL${topsaleData[index].filename}")),
                ],
              ),
              Container(
                margin: EdgeInsets.fromLTRB(8, 8, 8, 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      topsaleData[index].name,
                      style: GlobalStyle.productName,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("", style: GlobalStyle.productPrice),
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            child: Text(
                              'Rs.  ' + topsaleData[index].price.toString(),
                              style: GlobalStyle.productPriceDiscounted,
                              textAlign: TextAlign.right,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget _createAvailableBar(double sale, double total) {
  //   final double availableWidth =
  //       ((MediaQuery.of(context).size.width) - 24) / 2 - 28;
  //   return Container(
  //     margin: EdgeInsets.only(top: 10),
  //     child: Container(
  //       child: Row(
  //         children: [
  //           Container(
  //             width: sale / total * (availableWidth),
  //             height: 5,
  //             decoration: BoxDecoration(
  //               color: SOFT_BLUE,
  //               borderRadius: BorderRadius.only(
  //                   topLeft: Radius.circular(10),
  //                   bottomLeft: Radius.circular(10),
  //                   topRight: Radius.circular(sale == total ? 10 : 0),
  //                   bottomRight: Radius.circular(sale == total ? 10 : 0)),
  //             ),
  //           ),
  //           Container(
  //             width: (total - sale) / total * (availableWidth),
  //             height: 5,
  //             decoration: BoxDecoration(
  //               color: Colors.grey[300],
  //               borderRadius: BorderRadius.only(
  //                   topLeft: Radius.circular(sale == 0 ? 10 : 0),
  //                   bottomLeft: Radius.circular(sale == 0 ? 10 : 0),
  //                   topRight: Radius.circular(10),
  //                   bottomRight: Radius.circular(10)),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Future refreshData() async {
    setState(() {
      _apiPage = 0;
      _lastData = false;
      topsaleData.clear();
      _topsaleBloc.add(TopsellingDataEvent());
    });
  }
}
