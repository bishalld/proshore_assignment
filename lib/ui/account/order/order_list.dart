/*
This is order list page

include file in reuseable/global_function.dart to call function from GlobalFunction
include file in reuseable/global_widget.dart to call function from GlobalWidget
include file in reuseable/cache_image_network.dart to use cache image network
include file in reuseable/shimmer_loading.dart to use shimmer loading
include file in model/account/order_list_model.dart to get orderListData
 */

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meroshopping_flutter/bloc/account/order_list/bloc.dart';
import 'package:meroshopping_flutter/config/constants.dart';
import 'package:meroshopping_flutter/config/global_style.dart';
import 'package:meroshopping_flutter/config/shared_pref.dart';
import 'package:meroshopping_flutter/ui/account/order/order_detail.dart';
import 'package:meroshopping_flutter/ui/reuseable/app_localizations.dart';
import 'package:meroshopping_flutter/ui/reuseable/global_function.dart';
import 'package:meroshopping_flutter/ui/reuseable/global_widget.dart';
import 'package:meroshopping_flutter/ui/reuseable/shimmer_loading.dart';
import 'package:intl/intl.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  // initialize global function, global widget and shimmer loading
  final _globalFunction = GlobalFunction();
  final _globalWidget = GlobalWidget();
  final _shimmerLoading = ShimmerLoading();

  List orderListData = [];

  late OrderListBloc _orderListProductBloc;
  int _apiPage = 0;
  ScrollController _scrollController = ScrollController();
  bool _lastData = false;
  bool _processApi = false;

  CancelToken apiToken = CancelToken(); // used to cancel fetch data from API

  @override
  void initState() {
    print(userToken);
    // get data when initState
    _orderListProductBloc = BlocProvider.of<OrderListBloc>(context);
    _orderListProductBloc.add(GetOrderList());

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
        _orderListProductBloc.add(GetOrderList());
        _processApi = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final double boxImageSize = (MediaQuery.of(context).size.width / 6);
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: GlobalStyle.appBarIconThemeColor,
          ),
          elevation: GlobalStyle.appBarElevation,
          title: Text(
            AppLocalizations.of(context)!.translate('order_list')!,
            style: GlobalStyle.appBarTitle,
          ),
          backgroundColor: GlobalStyle.appBarBackgroundColor,
          systemOverlayStyle: GlobalStyle.appBarSystemOverlayStyle,
          bottom: _globalWidget.bottomAppBar(),
        ),
        body: RefreshIndicator(
          onRefresh: refreshData,
          child: BlocListener<OrderListBloc, OrderListState>(
            listener: (context, state) {
              if (state is OrderListError) {
                _globalFunction.showToast(
                    type: 'error', message: state.errorMessage);
                print(state.errorMessage);
              }
              if (state is GetOrderListSuccess) {
                _scrollController.addListener(_onScroll);
                if (state.orderListData.length == 0) {
                  _lastData = true;
                } else {
                  _apiPage += LIMIT_PAGE;
                  orderListData.addAll(state.orderListData);
                }
                _processApi = false;
              }
            },
            child: BlocBuilder<OrderListBloc, OrderListState>(
              builder: (context, state) {
                if (state is OrderListError) {
                  return Container(
                      child: Center(
                          child: Text(ERROR_OCCURED,
                              style:
                                  TextStyle(fontSize: 14, color: BLACK_GREY))));
                } else {
                  if (_lastData && _apiPage == 0) {
                    return Container(
                        child: Center(
                            child: Text(
                                AppLocalizations.of(context)!
                                    .translate('no_order_list')!,
                                style: TextStyle(
                                    fontSize: 14, color: BLACK_GREY))));
                  } else {
                    if (orderListData.length == 0) {
                      return _shimmerLoading.buildShimmerContent();
                    } else {
                      return ListView.builder(
                        itemCount: orderListData.length,
                        // Add one more item for progress indicator
                        padding: EdgeInsets.symmetric(vertical: 0),
                        physics: AlwaysScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          if (index == orderListData.length) {
                            return _globalWidget
                                .buildProgressIndicator(_lastData);
                          } else {
                            return _buildOrderList(index, boxImageSize);
                          }
                        },
                        controller: _scrollController,
                      );
                    }
                  }
                }
              },
            ),
          ),
        ));
  }

  // Widget _buildOrderListCard(index, boxImageSize) {
  //   return Container(
  //     margin: EdgeInsets.fromLTRB(12, 6, 12, 0),
  //     child: GestureDetector(
  //       behavior: HitTestBehavior.translucent,
  //       onTap: () {
  //         Navigator.push(context,
  //             MaterialPageRoute(builder: (context) => OrderDetailPage()));
  //       },
  //       child: Card(
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(10),
  //         ),
  //         elevation: 2,
  //         color: Colors.white,
  //         child: Container(
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Container(
  //                 alignment: Alignment.center,
  //                 padding: EdgeInsets.all(12),
  //                 child: Text(orderListData[index].orderStatus,
  //                     style: TextStyle(color: SOFT_BLUE, fontSize: 12)),
  //               ),
  //               Divider(
  //                 height: 0,
  //                 color: Colors.grey[400],
  //               ),
  //               Container(
  //                 margin: EdgeInsets.fromLTRB(12, 12, 12, 0),
  //                 child: Text(orderListData[index].totalAmount,
  //                     style: TextStyle(fontSize: 12, color: Colors.grey[400])),
  //               ),
  //               Container(
  //                 margin: EdgeInsets.fromLTRB(12, 8, 12, 0),
  //                 child: Text(orderListData[index].id,
  //                     style:
  //                         TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
  //               ),
  //               Container(
  //                 margin: EdgeInsets.all(12),
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.start,
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: <Widget>[
  //                     ClipRRect(
  //                         borderRadius: BorderRadius.all(Radius.circular(8)),
  //                         child: buildCacheNetworkImage(
  //                             width: boxImageSize,
  //                             height: boxImageSize,
  //                             url:
  //                                 "$BASE_IMAGE_URL${orderListData[index].product.filename}")),
  //                     SizedBox(
  //                       width: 10,
  //                     ),
  //                     Expanded(
  //                       child: Column(
  //                         mainAxisAlignment: MainAxisAlignment.start,
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: [
  //                           Text(
  //                             orderListData[index].product.name,
  //                             style: GlobalStyle.productName.copyWith(
  //                                 fontSize: 14, fontWeight: FontWeight.bold),
  //                             maxLines: 3,
  //                             overflow: TextOverflow.ellipsis,
  //                           ),
  //                           Container(
  //                               margin: EdgeInsets.only(top: 4),
  //                               child: Text(
  //                                   '+2 ' +
  //                                       AppLocalizations.of(context)!
  //                                           .translate('other_product')!,
  //                                   style: GlobalStyle.shoppingCartOtherProduct
  //                                       .copyWith(color: Colors.grey[400])))
  //                         ],
  //                       ),
  //                     )
  //                   ],
  //                 ),
  //               ),
  //               Divider(
  //                 height: 0,
  //                 color: Colors.grey[400],
  //               ),
  //               Container(
  //                   margin: EdgeInsets.all(12),
  //                   alignment: Alignment.topRight,
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.end,
  //                     children: [
  //                       Text(
  //                           AppLocalizations.of(context)!
  //                               .translate('total_payment')!,
  //                           style: TextStyle(fontSize: 12)),
  //                       Container(
  //                         margin: EdgeInsets.only(top: 4),
  //                         child: Text(
  //                             '\$' +
  //                                 _globalFunction.removeDecimalZeroFormat(
  //                                     orderListData[index].paymentType),
  //                             style: GlobalStyle.productPrice),
  //                       )
  //                     ],
  //                   ))
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Future refreshData() async {
    setState(() {
      _apiPage = 0;
      _lastData = false;
      orderListData.clear();
      _orderListProductBloc.add(GetOrderList());
    });
  }

/////
  Widget _buildOrderList(index, boxImageSize) {
    return Container(
      margin: EdgeInsets.fromLTRB(12, 6, 12, 0),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => OrderDetailPage()));
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 2,
          color: Colors.white,
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(12),
                  child: Text(orderListData[index].orderStatus,
                      style: TextStyle(color: SOFT_BLUE, fontSize: 12)),
                ),
                Divider(
                  height: 0,
                  color: Colors.grey[400],
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(12, 12, 12, 0),
                  child: Text(
                      DateFormat('yyyy MMMM d H:m')
                          .format(
                              DateTime.parse(orderListData[index].createdAt))
                          .toString(),
                      style: TextStyle(fontSize: 12, color: Colors.grey[400])),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(12, 8, 12, 0),
                  child: Text(orderListData[index].id.toString(),
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                ),
                Container(
                  margin: EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // ClipRRect(
                      //     borderRadius: BorderRadius.all(Radius.circular(8)),
                      //     child: buildCacheNetworkImage(
                      //         width: boxImageSize,
                      //         height: boxImageSize,
                      //         url:
                      //             "$BASE_IMAGE_URL${orderListData[index].product.filename}")),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              //for product name : orderListData[index].product[index].name
                              orderListData[index].name,
                              style: GlobalStyle.productName.copyWith(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Container(
                                margin: EdgeInsets.only(top: 4),
                                child: Text(
                                    '+2 ' +
                                        AppLocalizations.of(context)!
                                            .translate('other_product')!,
                                    style: GlobalStyle.shoppingCartOtherProduct
                                        .copyWith(color: Colors.grey[400])))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Divider(
                  height: 0,
                  color: Colors.grey[400],
                ),
                Container(
                    margin: EdgeInsets.all(12),
                    alignment: Alignment.topRight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                            AppLocalizations.of(context)!
                                .translate('total_payment')!,
                            style: TextStyle(fontSize: 12)),
                        Container(
                          margin: EdgeInsets.only(top: 4),
                          child: Text(
                              '\RS. ' +
                                  orderListData[index]
                                      .totalAmount
                                      .toString(), //orderListData[index].totalPrice
                              style: GlobalStyle.productPrice),
                        )
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
