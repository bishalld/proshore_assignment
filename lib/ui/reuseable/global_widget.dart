import 'package:flutter/material.dart';
import 'package:meroshopping_flutter/config/constants.dart';
import 'package:meroshopping_flutter/config/global_style.dart';
import 'package:meroshopping_flutter/ui/general/product_detail/product_detail.dart';
import 'package:meroshopping_flutter/ui/reuseable/app_localizations.dart';
import 'package:meroshopping_flutter/ui/reuseable/cache_image_network.dart';
import 'package:meroshopping_flutter/ui/reuseable/global_function.dart';

class GlobalWidget {
  // initialize global function
  final _globalFunction = GlobalFunction();

  PreferredSizeWidget bottomAppBar() {
    return PreferredSize(
        child: Container(
          color: Colors.grey[100],
          height: 1.0,
        ),
        preferredSize: Size.fromHeight(1.0));
  }

  Widget customNotifIcon(int count, Color color) {
    return Stack(
      children: <Widget>[
        Icon(Icons.notifications, color: color),
        Positioned(
          right: 0,
          child: Container(
            padding: EdgeInsets.all(1),
            decoration: BoxDecoration(
              color: ASSENT_COLOR,
              borderRadius: BorderRadius.circular(10),
            ),
            constraints: BoxConstraints(
              minWidth: 14,
              minHeight: 14,
            ),
            child: Center(
              child: Text(
                count.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 8,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget createRatingBar(double rating) {
    return Row(
      children: [
        for (int i = 1; i <= rating; i++)
          Icon(Icons.star, color: Colors.yellow[700], size: 12),
        for (int i = 1; i <= (5 - rating); i++)
          Icon(Icons.star_border, color: Colors.yellow[700], size: 12),
      ],
    );
  }

  Widget buildProgressIndicator(lastData) {
    if (lastData == false) {
      return new Padding(
        padding: const EdgeInsets.all(8.0),
        child: new Center(
          child: new Opacity(
            opacity: 1,
            child: new Container(
              height: 20,
              width: 20,
              margin: EdgeInsets.all(5),
              child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(PRIMARY_COLOR),
                strokeWidth: 2.0,
              ),
            ),
          ),
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }

  Widget createDefaultLabel(context) {
    return Container(
      padding: EdgeInsets.fromLTRB(8, 2, 8, 2),
      decoration: BoxDecoration(
          color: SOFT_BLUE, borderRadius: BorderRadius.circular(2)),
      child: Row(
        children: [
          Text(AppLocalizations.of(context)!.translate('default')!,
              style: TextStyle(color: Colors.white, fontSize: 13)),
          SizedBox(
            width: 4,
          ),
          Icon(Icons.done, color: Colors.white, size: 11)
        ],
      ),
    );
  }

  Widget buildHorizontalProductCard(context, data) {
    final double boxImageSize = (MediaQuery.of(context).size.width / 3);
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
                          urlName: data.urlname,
                        )));
          },
          child: Column(
            children: <Widget>[
              ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  child: buildCacheNetworkImage(
                      width: boxImageSize + 10,
                      height: boxImageSize + 10,
                      url: "$BASE_IMAGE_URL${data.filename}")),
              Container(
                margin: EdgeInsets.fromLTRB(8, 8, 8, 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.name,
                      style: GlobalStyle.productName,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      child: Text('\$ ' + data.price.toString(),
                          style: GlobalStyle.productPrice),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      child: Row(
                        children: [
                          // createRatingBar(data.rating),
                          // Text('(' + data.review.toString() + ')',
                          //     style: GlobalStyle.productTotalReview)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildProductGrid(context, data) {
    final double boxImageSize =
        ((MediaQuery.of(context).size.width) - 24) / 2 - 12;
    return Container(
      height: 150,
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
                          urlName: data.urlname,
                        )));
          },
          child: Column(
            children: <Widget>[
              ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  child: buildCacheNetworkImage(
                      height: boxImageSize,
                      url: data.filename != null
                          ? "$BASE_IMAGE_URL${data.filename}"
                          : 'https://www.meroshopping.com/images/h3UBzaUEHSzXrvRUlkxyztnXdsHFD1q4tOgIXAwQ.jpg')),
              Container(
                margin: EdgeInsets.fromLTRB(8, 8, 8, 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.name,
                      style: GlobalStyle.productName,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Rs. ' + data.price.toString(),
                              style: GlobalStyle.productPrice),
                          Text("", style: GlobalStyle.productSale)
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      child: Row(
                        children: [
//Icon(Icons.location_on, color: SOFT_GREY, size: 12),
                          // Text("' ' + data.location",
                          //     style: GlobalStyle.productLocation)
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      child: Row(
                        children: [
                          createRatingBar(
                              data.rating != null && data.rating <= 5
                                  ? data.rating.toDouble()
                                  : 3.0),
                          // Text('(' + data.review.toString() + ')',
                          //     style: GlobalStyle.productTotalReview)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
