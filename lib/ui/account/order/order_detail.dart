/*
This is order detail page

include file in reuseable/global_function.dart to call function from GlobalFunction
include file in reuseable/global_widget.dart to call function from GlobalWidget
include file in reuseable/cache_image_network.dart to use cache image network
 */

import 'package:flutter/material.dart';
import 'package:meroshopping_flutter/config/constants.dart';
import 'package:meroshopping_flutter/config/global_style.dart';

import 'package:meroshopping_flutter/ui/reuseable/app_localizations.dart';
import 'package:meroshopping_flutter/ui/reuseable/cache_image_network.dart';
import 'package:meroshopping_flutter/ui/reuseable/global_function.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../repositories/products/myorders/my_orders_repo.dart';
import 'package:intl/intl.dart';

class OrderDetailPage extends StatefulWidget {
  @override
  _OrderDetailPageState createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  // initialize global function
  final _globalFunction = GlobalFunction();
  List orderListDate = [];
  List productData = [];

  @override
  void initState() {
    getOrderListDetail();

    super.initState();
  }

  getOrderListDetail() async {
    EasyLoading.show(status: "Loading...");
    var res = await MyOrdersRepositories().myOrdersData();

    EasyLoading.dismiss();
    if (res != false) {
      orderListDate = res.orderhistory;
    } else {}
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double boxImageSize = (MediaQuery.of(context).size.width / 6);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: GlobalStyle.appBarIconThemeColor,
        ),
        elevation: 2,
        title: Text(
          AppLocalizations.of(context)!.translate('order_detail')!,
          style: GlobalStyle.appBarTitle,
        ),
        backgroundColor: GlobalStyle.appBarBackgroundColor,
        systemOverlayStyle: GlobalStyle.appBarSystemOverlayStyle,
      ),
      body: orderListDate[0] == []
          ? Container()
          : ListView(
              children: [
                _createOrderStatus(),
                Container(
                  margin: EdgeInsets.only(top: 6),
                  child: Column(
                    children: [
                      _buidOrderContainer(boxImageSize),
                    ],
                  ),
                ),
                _createDeliveryDetail(),
                _createPaymentInformation(),
              ],
            ),
    );
  }

  Widget _createOrderStatus() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 1.0), //(x,y)
            blurRadius: 3.0,
          ),
        ],
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppLocalizations.of(context)!.translate('status')!,
              style: TextStyle(color: BLACK_GREY, fontSize: 13)),
          SizedBox(
            height: 4,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(orderListDate[0].orderStatus,
                  style: TextStyle(
                      color: PRIMARY_COLOR,
                      fontSize: 14,
                      fontWeight: FontWeight.bold)),
            ],
          ),
          Divider(
            height: 32,
            color: Colors.grey[400],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(AppLocalizations.of(context)!.translate('order_date')!,
                  style: TextStyle(color: BLACK_GREY, fontSize: 13)),
              Text(
                  DateFormat('yyyy MMMM d H:m')
                      .format(DateTime.parse(orderListDate[0].createdAt))
                      .toString(),
                  style: TextStyle(
                      color: BLACK_GREY,
                      fontSize: 13,
                      fontWeight: FontWeight.bold))
            ],
          ),
          Divider(
            height: 32,
            color: Colors.grey[400],
          ),
          Text("Order Id : #${orderListDate[0].id}",
              style: TextStyle(color: BLACK_GREY, fontSize: 13)),
        ],
      ),
    );
  }

  Widget _buidOrderContainer(boxImageSize) {
    return ListView.builder(
        shrinkWrap: true, //    <-- Set this to true
        physics: ScrollPhysics(),
        itemCount: orderListDate[0].product.length,
        itemBuilder: (context, index) {
          return Container(
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
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        margin: EdgeInsets.all(12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                child: buildCacheNetworkImage(
                                    width: boxImageSize,
                                    height: boxImageSize,
                                    url:
                                        "$BASE_IMAGE_URL${orderListDate[0].product[index].filename}")),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    orderListDate[0].product[index].name,
                                    style: GlobalStyle.productName.copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(top: 4),
                                      child: Text(
                                          // orderListDate[0]
                                          //         .product[0]
                                          //         .length
                                          //         .toString() +
                                          ' '
                                          // +
                                          // AppLocalizations.of(context)!
                                          //     .translate('item')! +
                                          // '  (' +
                                          // weight.toString() +
                                          // ' ' +
                                          // AppLocalizations.of(context)!
                                          //     .translate('gr')! +
                                          // ')'
                                          ,
                                          style: GlobalStyle
                                              .shoppingCartOtherProduct
                                              .copyWith(
                                                  color: Colors.grey[400]))),
                                  Container(
                                    margin: EdgeInsets.only(top: 4),
                                    child: Text(
                                        '\RS. ' +
                                            orderListDate[0]
                                                .product[index]
                                                .price
                                                .toString(),
                                        style: GlobalStyle.productPrice),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      height: 0,
                      color: Colors.grey[400],
                    ),
                    Container(
                        margin: EdgeInsets.all(12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                AppLocalizations.of(context)!
                                    .translate('total_price')!,
                                style: TextStyle(fontSize: 12)),
                            Container(
                              child: Text(
                                  '\RS. ' +
                                      orderListDate[0]
                                          .product[index]
                                          .price
                                          .toString(),
                                  style: GlobalStyle.productPrice),
                            )
                          ],
                        ))
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget _createDeliveryDetail() {
    return Container(
        margin: EdgeInsets.only(top: 12),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 3.0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(orderListDate[0].city,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(
              height: 16,
            ),
            Table(
              children: [
                // TableRow(children: [
                //   Container(
                //     child: Text(
                //         AppLocalizations.of(context)!
                //             .translate('courier_delivery')!,
                //         style: TextStyle(
                //           color: BLACK_GREY,
                //           fontSize: 13,
                //         )),
                //   ),
                //   Container(
                //     child: Text('DHL Express',
                //         style: TextStyle(
                //             color: CHARCOAL,
                //             fontSize: 14,
                //             fontWeight: FontWeight.bold)),
                //   )
                // ]),
                TableRow(children: [
                  Container(
                    margin: EdgeInsets.only(top: 8),
                    child: Text(
                        AppLocalizations.of(context)!.translate('awb_number')!,
                        style: TextStyle(
                          color: BLACK_GREY,
                          fontSize: 13,
                        )),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 8),
                    child: Text(orderListDate[0].contact,
                        style: TextStyle(
                            color: CHARCOAL,
                            fontSize: 14,
                            fontWeight: FontWeight.bold)),
                  )
                ]),
                TableRow(children: [
                  Container(
                    margin: EdgeInsets.only(top: 8),
                    child: Text("Delivery Addresss",
                        style: TextStyle(
                          color: BLACK_GREY,
                          fontSize: 13,
                        )),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                              orderListDate[0].address != null
                                  ? "${orderListDate[0].state}"
                                  : orderListDate[0].city,
                              style: TextStyle(
                                  color: CHARCOAL,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold)),
                        ),
                        // Container(
                        //   child: Text('0811888999',
                        //       style: TextStyle(
                        //           color: CHARCOAL,
                        //           fontSize: 14,
                        //           fontWeight: FontWeight.bold)),
                        // ),
                        // Container(
                        //   child: Text('6019 Madison St',
                        //       style: TextStyle(
                        //           color: CHARCOAL,
                        //           fontSize: 14,
                        //           fontWeight: FontWeight.bold)),
                        // ),
                        // Container(
                        //   child: Text('West New York, NJ 07093',
                        //       style: TextStyle(
                        //           color: CHARCOAL,
                        //           fontSize: 14,
                        //           fontWeight: FontWeight.bold)),
                        // ),
                        // Container(
                        //   child: Text('USA',
                        //       style: TextStyle(
                        //           color: CHARCOAL,
                        //           fontSize: 14,
                        //           fontWeight: FontWeight.bold)),
                        // ),
                      ],
                    ),
                  )
                ]),
              ],
            ),
          ],
        ));
  }

  Widget _createPaymentInformation() {
    int totalPrice =
        orderListDate[0].product[0].price + orderListDate[0].deliveryCharge;

    return Container(
        margin: EdgeInsets.only(top: 16),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 3.0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                AppLocalizations.of(context)!.translate('payment_information')!,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppLocalizations.of(context)!.translate('payment_method')!,
                    style: TextStyle(color: BLACK_GREY, fontSize: 13)),
                Text(orderListDate[0].paymentType,
                    style: TextStyle(
                        color: CHARCOAL,
                        fontSize: 13,
                        fontWeight: FontWeight.bold))
              ],
            ),
            Divider(
              height: 32,
              color: Colors.grey[400],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppLocalizations.of(context)!.translate('total_price')!,
                    // ' (4 ' +
                    // AppLocalizations.of(context)!.translate('item')! +
                    // ')',
                    style: TextStyle(color: BLACK_GREY, fontSize: 13)),
                Text("RS. ${orderListDate[0].product[0].price.toString()}",
                    style: GlobalStyle.productPrice)
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppLocalizations.of(context)!.translate('total_delivery')!,
                    style: TextStyle(color: BLACK_GREY, fontSize: 13)),
                Text(orderListDate[0].deliveryCharge.toString(),
                    style: GlobalStyle.productPrice)
              ],
            ),
            Divider(
              height: 32,
              color: Colors.grey[400],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppLocalizations.of(context)!.translate('total_payment')!,
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                Text("RS. ${totalPrice.toString()}")
              ],
            ),
          ],
        ));
  }
}
