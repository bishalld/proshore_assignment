/*
This is flash sale page

include file in reuseable/global_function.dart to call function from GlobalFunction
include file in reuseable/global_widget.dart to call function from GlobalWidget
include file in reuseable/cache_image_network.dart to use cache image network
include file in reuseable/shimmer_loading.dart to use shimmer loading
include file in model/home/flashsale_model.dart to get tagProductsData
 */

import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meroshopping_flutter/bloc/products/checkout/topsellingbloc/topselling_bloc.dart';
import 'package:meroshopping_flutter/bloc/products/tags/tagproductbloc/tagproduct_bloc.dart';
import 'package:meroshopping_flutter/config/constants.dart';
import 'package:meroshopping_flutter/config/global_style.dart';
import 'package:meroshopping_flutter/ui/general/product_detail/product_detail.dart';
import 'package:meroshopping_flutter/ui/reuseable/cache_image_network.dart';
import 'package:meroshopping_flutter/ui/reuseable/global_function.dart';
import 'package:meroshopping_flutter/ui/reuseable/global_widget.dart';
import 'package:meroshopping_flutter/ui/reuseable/shimmer_loading.dart';

class TagProductsPage extends StatefulWidget {
  final int id;
  final String title;
  const TagProductsPage({Key? key, required this.id, required this.title})
      : super(key: key);
  @override
  _TagProductsPageState createState() => _TagProductsPageState();
}

class _TagProductsPageState extends State<TagProductsPage> {
  // initialize global function, global widget and shimmer loading
  final _globalFunction = GlobalFunction();
  final _globalWidget = GlobalWidget();
  final _shimmerLoading = ShimmerLoading();

  List tagProductsData = [];

  late TagproductBloc _tagproductBloc;
  int _apiPage = 0;
  ScrollController _scrollController = ScrollController();
  bool _lastData = false;
  bool _processApi = false;

  CancelToken apiToken = CancelToken(); // used to cancel fetch data from API

  @override
  void initState() {
    // get data when initState
    _tagproductBloc = BlocProvider.of<TagproductBloc>(context);
    _tagproductBloc.add(TagproductDataEvent(id: widget.id));

    // Timer(Duration(seconds: 5), () {
    //   refreshData();
    // });

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
        _tagproductBloc.add(TagproductDataEvent(id: widget.id));
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
            "${widget.title} Products",
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
        body: BlocListener<TagproductBloc, TagproductState>(
          listener: (context, state) {
            if (state is TagproductError) {
              _globalFunction.showToast(
                  type: 'error', message: state.errorMessage);
            }
            if (state is TagproductSuccess) {
              _scrollController.addListener(_onScroll);
              if (state.data.length == 0) {
                _lastData = true;
              } else {
                _apiPage += LIMIT_PAGE;
                tagProductsData.addAll(state.data);
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
              BlocBuilder<TagproductBloc, TagproductState>(
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
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Center(
                            child:
                                //  Image(
                                //     image: AssetImage('assets/images/empty.png'))

                                Text("No products found",
                                    style: TextStyle(
                                        fontSize: 14, color: BLACK_GREY)),
                          ),
                        ),
                      );
                    } else {
                      if (tagProductsData.length == 0) {
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
                                    childAspectRatio:
                                        GlobalStyle.gridDelegateFlashsaleRatio,
                                  ),
                                  delegate: SliverChildBuilderDelegate(
                                    (BuildContext context, int index) {
                                      return _buildFlashsaleCard(index);
                                    },
                                    childCount: tagProductsData.length,
                                  ),
                                ),
                              ),
                              // SliverToBoxAdapter(
                              //   child: (_apiPage == LIMIT_PAGE &&
                              //           tagProductsData.length < LIMIT_PAGE)
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
                          urlName: tagProductsData[index].urlname,
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
                            "$BASE_IMAGE_URL${tagProductsData[index].filename}"),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.fromLTRB(8, 8, 8, 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tagProductsData[index].name,
                      style: GlobalStyle.productName,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              'Rs.  ' + tagProductsData[index].price.toString(),
                              style: GlobalStyle.productPrice),
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            child: Text(
                              '',
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
      tagProductsData.clear();
      _tagproductBloc.add(TagproductDataEvent(id: widget.id));
    });
  }
}
