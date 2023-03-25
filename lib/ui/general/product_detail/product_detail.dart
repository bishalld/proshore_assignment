/*
This is product detail page

include file in reuseable/global_function.dart to call function from GlobalFunction
include file in reuseable/global_widget.dart to call function from GlobalWidget
include file in reuseable/cache_image_network.dart to use cache image network
include file in reuseable/shimmer_loading.dart to use shimmer loading

include file in model/general/related_product_model.dart to get wishlistData
include file in model/general/review_model.dart to get wishlistData

install plugin in pubspec.yaml
- fluttertoast => to show toast (https://pub.dev/packages/fluttertoast)

Don't forget to add all images and sound used in this pages at the pubspec.yaml
 */
import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meroshopping_flutter/bloc/products/cart/cartbloc/cart_bloc.dart';
import 'package:meroshopping_flutter/bloc/products/checkout/topsellingbloc/topselling_bloc.dart';
import 'package:meroshopping_flutter/config/constants.dart';
import 'package:meroshopping_flutter/config/global_style.dart';
import 'package:meroshopping_flutter/config/shared_pref.dart';
import 'package:meroshopping_flutter/ui/general/product_detail/delivery_estimated.dart';
import 'package:meroshopping_flutter/ui/general/product_detail/product_description.dart';
import 'package:meroshopping_flutter/ui/home/category/product_category.dart';
import 'package:meroshopping_flutter/ui/reuseable/app_localizations.dart';
import 'package:meroshopping_flutter/ui/reuseable/global_widget.dart';
import 'package:meroshopping_flutter/ui/shopping_cart/shopping_cart.dart';

import '../../../bloc/products/fetchwishlistbloc/fetchwishlistbloc_bloc.dart';

class ProductDetailPage extends StatefulWidget {
  final String urlName;

  const ProductDetailPage({Key? key, required this.urlName}) : super(key: key);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final _globalWidget = GlobalWidget();

  var singleProductData;
  List relatedProductsData = [];
  List shoppingCartData = [];

  late TopsellingBloc _topsellingBloc;

  late FetchwishlistblocBloc _fetchwishlistblocBloc;
  late CartBloc _cartBloc;

  CancelToken apiToken = CancelToken(); // used to cancel fetch data from API

  List<String> _sizeList = ['XS', 'S', 'M', 'L', 'XL', 'XXL'];
  int _sizeIndex = 0;

  // color data
  List<String> _colorList = [];
  int _colorIndex = 0;

  // shopping cart count
  int _shoppingCartCount = 3;

  bool isFavourite = true;

  List wishData = [];

  bool cartEnabled = true;
  int stock = 0;
  int price = 100;

  @override
  void initState() {
    print(userToken);
    _topsellingBloc = BlocProvider.of<TopsellingBloc>(context);
    _cartBloc = BlocProvider.of<CartBloc>(context);
    _topsellingBloc.add(SingleProductDataEvent(urlname: widget.urlName));
    _cartBloc.add(GetCartItemsEvent());
    _shoppingCartCount = shoppingCartData.length;
    _fetchwishlistblocBloc = BlocProvider.of<FetchwishlistblocBloc>(context);

    _fetchwishlistblocBloc = BlocProvider.of<FetchwishlistblocBloc>(context);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _initForLang();
    });

    super.initState();
  }

  void _initForLang() {
    setState(() {
      _colorList = [
        AppLocalizations.of(context)!.translate('red')!,
        AppLocalizations.of(context)!.translate('black')!,
        AppLocalizations.of(context)!.translate('green')!,
        AppLocalizations.of(context)!.translate('white')!,
        AppLocalizations.of(context)!.translate('blue')!,
        AppLocalizations.of(context)!.translate('yellow')!,
        AppLocalizations.of(context)!.translate('pink')!
      ];
    });
  }

  @override
  void dispose() {
    apiToken.cancel("cancelled"); // cancel fetch data from API
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: GlobalStyle.appBarIconThemeColor,
          ),
          elevation: GlobalStyle.appBarElevation,
          titleSpacing: 0.0,
          backgroundColor: GlobalStyle.appBarBackgroundColor,
          systemOverlayStyle: GlobalStyle.appBarSystemOverlayStyle,
          actions: [
            IconButton(
                padding: EdgeInsets.all(8),
                constraints: BoxConstraints(),
                icon: _customShoppingCart(_shoppingCartCount),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ShoppingCartPage()));
                }),
          ],
          bottom: _globalWidget.bottomAppBar(),
        ),
        body: WillPopScope(
          onWillPop: () {
            Navigator.pop(context);
            return Future.value(true);
          },
          child: MultiBlocListener(
            listeners: [
              BlocListener<TopsellingBloc, TopsellingState>(
                  listener: (context, state) {
                if (state is TopsellingWaiting) {
                  EasyLoading.show(status: 'Loading...');
                }
                if (state is TopsellingError) {
                  EasyLoading.showError(state.errorMessage);
                }
                //print('state atas : '+state.toString());
                if (state is TopsellingError) {
                  EasyLoading.showError(state.errorMessage);
                  print(state.errorMessage);
                }
                if (state is SingleProductSuccess) {
                  EasyLoading.dismiss();
                  singleProductData = state.singleData;
                  price = state.singleData.price;
                  isFavourite = state.singleData.isFavourite;
                  stock = state.singleData.stock;
                  // print(state.singleData.isFavourite);

                  relatedProductsData.addAll(state.relatedproducts);
                  setState(() {});
                }
              }),

              BlocListener<FetchwishlistblocBloc, FetchwishlistblocState>(
                  listener: (context, state) {
                if (state is FetchWishListWaiting) {
                  EasyLoading.show(status: 'Loading...');
                }
                //print('state atas : '+state.toString());
                if (state is PostWishListError) {
                  EasyLoading.showError(state.errorMessage);
                  print(state.errorMessage);
                }
                // if (state is PostWishListSuccess) {
                //   EasyLoading.showSuccess(state.successMessage);
                // }
                // if (state is DeleteWishListSuccess) {
                //   EasyLoading.showSuccess("Deleted Sucessfully");
                // }
              }),

              BlocListener<CartBloc, CartState>(listener: (context, state) {
                if (state is CartWaiting) {
                  EasyLoading.show(status: 'Loading...');
                }

                if (state is GetCartItemSuccess) {
                  shoppingCartData.addAll(state.data);
                  _shoppingCartCount = shoppingCartData.length;
                }

                if (state is AddToCartSuccess) {
                  EasyLoading.dismiss();
                  EasyLoading.showSuccess(state.message);

                  setState(() {});
                }
              }),
              // BlocListener<ReviewBloc, ReviewState>(
              //   listener: (context, state) {
              //     if (state is ReviewProductError) {
              //       _globalFunction.showToast(
              //           type: 'error', message: state.errorMessage);
              //     }
              //     if (state is GetReviewProductSuccess) {
              //       if (state.relatedProductsData.length == 0) {
              //         _lastDataReview = true;
              //       } else {
              //         reviewData.addAll(state.reviewData);
              //       }
              //     }
              //   },
              // ),
            ],
            child: Column(
              children: [
                Flexible(
                  child: ListView(
                    children: [
                      _createProductSlider(),
                      _createProductPriceTitleEtc(),
                      _createProductVariant(),
                      _createDeliveryEstimated(),
                      _createProductInformation(),
                      _createProductDescription(),
                      // _createProductRelated(boxImageSize),
                      //_createProductReview(),
                      SizedBox(height: 16)
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 1.0), //(x,y)
                        blurRadius: 2.0,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      // Container(
                      //   child: GestureDetector(
                      //     onTap: () {
                      //       Navigator.push(
                      //           context,
                      //           MaterialPageRoute(
                      //               builder: (context) => ChatUsPage()));
                      //     },
                      //     child: ClipOval(
                      //       child: Container(
                      //           color: SOFT_BLUE,
                      //           padding: EdgeInsets.all(9),
                      //           child: Icon(Icons.chat,
                      //               color: Colors.white, size: 16)),
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(
                      //   width: 10,
                      // ),

                      stock == 0
                          ? Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                                margin: EdgeInsets.only(right: 8),
                                decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    border:
                                        Border.all(width: 1, color: SOFT_BLUE),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            10) //         <--- border radius here
                                        )),
                                child: Text(
                                    AppLocalizations.of(context)!
                                        .translate('out_of_stock')!,
                                    style: TextStyle(
                                        color: Colors.grey[600],
                                        fontWeight: FontWeight.bold)),
                              ),
                            )
                          : Expanded(
                              child: GestureDetector(
                                onTap: cartEnabled
                                    ? () {
                                        _cartBloc.add(AddToCartEvent(
                                            colorId: 0,
                                            productId: singleProductData.id,
                                            quantity: 1,
                                            sizeId: 0));

                                        setState(() {
                                          _shoppingCartCount++;
                                          cartEnabled = false;
                                        });

                                        //

                                        Fluttertoast.showToast(
                                            msg: AppLocalizations.of(context)!
                                                .translate(
                                                    'shopping_cart_added')!,
                                            toastLength: Toast.LENGTH_SHORT);
                                      }
                                    : () {
                                        Fluttertoast.showToast(
                                            msg: "Already added to cart",
                                            toastLength: Toast.LENGTH_SHORT);
                                      },
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                                  margin: EdgeInsets.only(right: 8),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          width: 1, color: SOFT_BLUE),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              10) //         <--- border radius here
                                          )),
                                  child: Text(
                                      AppLocalizations.of(context)!
                                          .translate('add_to_shopping_cart')!,
                                      style: TextStyle(
                                          color: SOFT_BLUE,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Widget _customShoppingCart(int count) {
    return Stack(
      children: <Widget>[
        Icon(Icons.shopping_cart, color: BLACK_GREY),
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

  Widget _createProductSlider() {
    return BlocBuilder<TopsellingBloc, TopsellingState>(
      builder: (context, state) {
        return state is SingleProductSuccess
            ? Container(
                height: 300,
                padding: EdgeInsets.fromLTRB(4, 4, 4, 4),
                child: CachedNetworkImage(
                    imageUrl: "$BASE_IMAGE_URL${state.singleData.filename}",
                    fit: BoxFit.fill),
                // child: Text(
                //     (_currentImageSlider + 1).toString() +
                //         '/' +
                //         _imgProductSlider.length.toString(),
                //     style: TextStyle(color: Colors.white, fontSize: 11)),
              )
            : Container();
      },
    );
  }

  Widget _createProductPriceTitleEtc() {
    return BlocBuilder<TopsellingBloc, TopsellingState>(
        bloc: _topsellingBloc,
        builder: (context, state) {
          EasyLoading.dismiss();
          return Container(
            color: Colors.white,
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('\Rs. ' + price.toString(),
                        style: GlobalStyle.detailProductPrice),
                    // BlocBuilder<FetchwishlistblocBloc, FetchwishlistblocState>(
                    //     bloc: _fetchwishlistblocBloc,
                    //     builder: (context, state) {
                    // return
                    GestureDetector(
                        child: isFavourite
                            ? const Icon(
                                Icons.favorite,
                                color: Colors.red,
                                size: 28,
                              )
                            : const Icon(Icons.favorite,
                                color: Colors.grey, size: 28),
                        onTap: () {
                          if (isFavourite == false) {
                            _fetchwishlistblocBloc.add(PostWishListEvent(
                                wishlistId: singleProductData.id));
                            setState(() {
                              isFavourite = true;
                              Fluttertoast.showToast(
                                  msg: AppLocalizations.of(context)!
                                      .translate('item_added_wishlist')!,
                                  toastLength: Toast.LENGTH_LONG);
                            });
                          } else if (isFavourite == true) {
                            setState(() {
                              //   _fetchwishlistblocBloc.add(DeleteWishListEvent(
                              //       wishlistId: singleProductData.id));
                              //   // print(isFavourite);
                              //isFavourite = false;
                              Fluttertoast.showToast(
                                  msg: "Product is already added to wishlist",
                                  toastLength: Toast.LENGTH_LONG);
                            });
                          }
                        })
                  ],
                ),
                SizedBox(height: 12),
                if (state is SingleProductSuccess)
                  Text("${state.singleData.name}",
                      style: TextStyle(
                        fontSize: 14,
                      )),
                SizedBox(height: 12),
                IntrinsicHeight(
                  child: Row(
                    children: [
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => ProductReviewPage()));
                        },
                        child: Row(
                          children: [
                            Icon(Icons.star,
                                color: Colors.yellow[700], size: 18),
                            SizedBox(
                              width: 3,
                            ),
                            if (state is SingleProductSuccess)
                              Text(
                                  state.singleData.ratingCnt != null
                                      ? state.singleData.ratingCnt.toString()
                                      : "3",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14)),
                            SizedBox(
                              width: 3,
                            ),
                            // Text('(' + singleProductData.review.toString() + ')',
                            //     style: TextStyle(fontSize: 13, color: BLACK_GREY)),
                          ],
                        ),
                      ),
                      VerticalDivider(
                        width: 30,
                        thickness: 1,
                        color: Colors.grey[300],
                      ),
                      if (state is SingleProductSuccess)
                        Text(state.singleData.stock.toString() + ' ' + "stock",
                            style: TextStyle(fontSize: 13, color: BLACK_GREY)),
                      VerticalDivider(
                        width: 30,
                        thickness: 1,
                        color: Colors.grey[300],
                      ),
                      // Icon(Icons.location_on, color: SOFT_GREY, size: 16),
                      // Text('Brooklyn',
                      //     style: TextStyle(fontSize: 13, color: SOFT_GREY))
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  Widget _createProductVariant() {
    return Container(
        margin: EdgeInsets.only(top: 12),
        padding: EdgeInsets.all(16),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppLocalizations.of(context)!.translate('variant')!,
                style: GlobalStyle.sectionTitle),
            SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Text(AppLocalizations.of(context)!.translate('size')! + ' : ',
                    style: TextStyle(color: BLACK_GREY, fontSize: 14)),
                Text(_sizeList[_sizeIndex],
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            Wrap(
              children: List.generate(_sizeList.length, (index) {
                return radioSize(_sizeList[index], index);
              }),
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Text(AppLocalizations.of(context)!.translate('color')! + ' : ',
                    style: TextStyle(color: BLACK_GREY, fontSize: 14)),
                (_colorList.length != 0)
                    ? Text(_colorList[_colorIndex],
                        style: TextStyle(fontWeight: FontWeight.bold))
                    : SizedBox.shrink(),
              ],
            ),
            (_colorList.length != 0)
                ? Wrap(
                    children: List.generate(_colorList.length, (index) {
                      return radioColor(_colorList[index], index);
                    }),
                  )
                : SizedBox.shrink(),
          ],
        ));
  }

  Widget radioSize(String txt, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _sizeIndex = index;
        });
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
        margin: EdgeInsets.only(right: 8, top: 8),
        decoration: BoxDecoration(
            color: _sizeIndex == index ? SOFT_BLUE : Colors.white,
            border: Border.all(
                width: 1,
                color: _sizeIndex == index ? SOFT_BLUE : Colors.grey[300]!),
            borderRadius: BorderRadius.all(
                Radius.circular(10) //         <--- border radius here
                )),
        child: Text(txt,
            style: TextStyle(
                color: _sizeIndex == index ? Colors.white : CHARCOAL)),
      ),
    );
  }

  Widget radioColor(String txt, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _colorIndex = index;
        });
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
        margin: EdgeInsets.only(right: 8, top: 8),
        decoration: BoxDecoration(
            color: _colorIndex == index ? SOFT_BLUE : Colors.white,
            border: Border.all(
                width: 1,
                color: _colorIndex == index ? SOFT_BLUE : Colors.grey[300]!),
            borderRadius: BorderRadius.all(
                Radius.circular(10) //         <--- border radius here
                )),
        child: Text(txt,
            style: TextStyle(
                color: _colorIndex == index ? Colors.white : CHARCOAL)),
      ),
    );
  }

  Widget _createDeliveryEstimated() {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => DeliveryEstimatedPage()));
      },
      child: Container(
          margin: EdgeInsets.only(top: 12),
          padding: EdgeInsets.all(16),
          color: Colors.white,
          child: Row(
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppLocalizations.of(context)!.translate('delivery')!,
                        style: GlobalStyle.sectionTitle),
                    SizedBox(
                      height: 16,
                    ),
                    RichText(
                      text: new TextSpan(
                        // Note: Styles for TextSpans must be explicitly defined.
                        // Child text spans will inherit styles from parent
                        style: new TextStyle(
                          fontSize: 15.5,
                          color: BLACK_GREY,
                        ),
                        children: <TextSpan>[
                          new TextSpan(
                              text: AppLocalizations.of(context)!
                                  .translate('calculated_message')!),
                          new TextSpan(
                              text: 'West New York, NJ',
                              style:
                                  new TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, size: 36, color: CHARCOAL)
            ],
          )),
    );
  }

  Widget _createProductInformation() {
    return Container(
        margin: EdgeInsets.only(top: 12),
        padding: EdgeInsets.all(16),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppLocalizations.of(context)!.translate('information')!,
                style: GlobalStyle.sectionTitle),
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppLocalizations.of(context)!.translate('weight')!,
                    style: TextStyle(color: BLACK_GREY)),
                Text('300 ' + AppLocalizations.of(context)!.translate('gram')!,
                    style: TextStyle(color: BLACK_GREY))
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppLocalizations.of(context)!.translate('condition')!,
                    style: TextStyle(color: BLACK_GREY)),
                Text(AppLocalizations.of(context)!.translate('second')!,
                    style: TextStyle(color: BLACK_GREY))
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppLocalizations.of(context)!.translate('category')!,
                    style: TextStyle(color: BLACK_GREY)),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductCategoryPage(
                                  categoryId: 3,
                                  categoryName: AppLocalizations.of(context)!
                                      .translate('electronic')!,
                                )));
                  },
                  child: Text(
                      AppLocalizations.of(context)!.translate('electronic')!,
                      style: TextStyle(color: SOFT_BLUE)),
                )
              ],
            ),
          ],
        ));
  }

  Widget _createProductDescription() {
    return Container(
        margin: EdgeInsets.only(top: 12),
        padding: EdgeInsets.all(16),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppLocalizations.of(context)!.translate('description')!,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(
              height: 16,
            ),
            Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit.\n\nQuisque tortor tortor, ultrices id scelerisque a, elementum id elit. Maecenas feugiat tellus sed augue malesuada, id tempus ex sodales.'),
            SizedBox(
              height: 16,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProductDescriptionPage(
                            name: singleProductData.name != null
                                ? singleProductData.name
                                : "name",
                            image: singleProductData.filename)));
              },
              child: Center(
                child: Text(
                    AppLocalizations.of(context)!.translate('read_more')!,
                    style: TextStyle(color: SOFT_BLUE)),
              ),
            ),
          ],
        ));
  }

  // Widget _createProductRelated(boxImageSize) {
  //   return Container(
  //       margin: EdgeInsets.only(top: 12),
  //       padding: EdgeInsets.only(bottom: 16),
  //       color: Colors.white,
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Container(
  //             margin: EdgeInsets.all(16),
  //             child: Text(
  //                 AppLocalizations.of(context)!.translate('related_product')!,
  //                 style: GlobalStyle.sectionTitle),
  //           ),
  //           Container(
  //             height: boxImageSize *
  //                 GlobalStyle.horizontalProductHeightMultiplication,
  //             child: BlocBuilder<RelatedProductBloc, RelatedProductState>(
  //               builder: (context, state) {
  //                 //print('state bawah : '+state.toString());
  //                 if (state is RelatedProductError) {
  //                   return Container(
  //                       child: Center(
  //                           child: Text(ERROR_OCCURED,
  //                               style: TextStyle(
  //                                   fontSize: 14, color: BLACK_GREY))));
  //                 } else {
  //                   if (_lastDataRelated) {
  //                     return Container(
  //                         child: Center(
  //                             child: Text(
  //                                 AppLocalizations.of(context)!
  //                                     .translate('no_related_product')!,
  //                                 style: TextStyle(
  //                                     fontSize: 14, color: BLACK_GREY))));
  //                   } else {
  //                     if (relatedProductsData.length == 0) {
  //                       return _shimmerLoading
  //                           .buildShimmerRelatedProduct(boxImageSize + 10);
  //                     } else {
  //                       return ListView.builder(
  //                         padding: EdgeInsets.only(left: 12, right: 12),
  //                         scrollDirection: Axis.horizontal,
  //                         itemCount: relatedProductsData.length,
  //                         itemBuilder: (BuildContext context, int index) {
  //                           return _globalWidget.buildHorizontalProductCard(
  //                               context, relatedProductsData[index]);
  //                         },
  //                       );
  //                     }
  //                   }
  //                 }
  //               },
  //             ),
  //           ),
  //         ],
  //       ));
  // }

  // Widget _createProductReview() {
  //   return Container(
  //       margin: EdgeInsets.only(top: 12),
  //       padding: EdgeInsets.all(16),
  //       color: Colors.white,
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               Text(AppLocalizations.of(context)!.translate('review')!,
  //                   style: GlobalStyle.sectionTitle),
  //               GestureDetector(
  //                 onTap: () {
  //                   Navigator.push(
  //                       context,
  //                       MaterialPageRoute(
  //                           builder: (context) => ProductReviewPage()));
  //                 },
  //                 child: Text(
  //                     AppLocalizations.of(context)!.translate('view_all')!,
  //                     style: GlobalStyle.viewAll.copyWith(color: SOFT_BLUE),
  //                     textAlign: TextAlign.end),
  //               )
  //             ],
  //           ),
  //           SizedBox(
  //             height: 8,
  //           ),
  //           Row(
  //             children: [
  //               // _globalWidget.createRatingBar(singleProductData.ratingCnt),
  //               // Text('(' + widget.review.toString() + ')',
  //               //     style: TextStyle(fontSize: 11, color: SOFT_GREY))
  //             ],
  //           ),
  //           BlocBuilder<ReviewBloc, ReviewState>(
  //             builder: (context, state) {
  //               if (state is ReviewProductError) {
  //                 return Container(
  //                     child: Center(
  //                         child: Text(ERROR_OCCURED,
  //                             style:
  //                                 TextStyle(fontSize: 14, color: BLACK_GREY))));
  //               } else {
  //                 if (_lastDataRelated) {
  //                   return Container(
  //                       child: Center(
  //                           child: Text(
  //                               AppLocalizations.of(context)!
  //                                   .translate('no_review')!,
  //                               style: TextStyle(
  //                                   fontSize: 14, color: BLACK_GREY))));
  //                 } else {
  //                   if (relatedProductsData.length == 0) {
  //                     return _shimmerLoading.buildShimmerReviewProduct();
  //                   } else {
  //                     return Column(
  //                         children: List.generate(relatedProductsData.length,
  //                             (index) {
  //                       return Column(
  //                         children: [
  //                           Divider(
  //                             height: 32,
  //                             color: Colors.grey[400],
  //                           ),
  //                           Container(
  //                               child: Column(
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             children: [
  //                               Text(relatedProductsData[index].date,
  //                                   style: TextStyle(
  //                                       fontSize: 13, color: SOFT_GREY)),
  //                               SizedBox(height: 4),
  //                               Row(
  //                                 mainAxisAlignment:
  //                                     MainAxisAlignment.spaceBetween,
  //                                 children: [
  //                                   Text("${relatedProductsData[index].name}",
  //                                       style: TextStyle(
  //                                           fontSize: 14,
  //                                           fontWeight: FontWeight.bold)),
  //                                   _globalWidget.createRatingBar(
  //                                       relatedProductsData[index].rating),
  //                                 ],
  //                               ),
  //                               SizedBox(height: 4),
  //                               Text(relatedProductsData[index].review)
  //                             ],
  //                           ))
  //                         ],
  //                       );
  //                     }));
  //                   }
  //                 }
  //               }
  //             },
  //           ),
  //         ],
  //       ));
  // }

}
