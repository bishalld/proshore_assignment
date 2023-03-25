/*
This is search page

include file in reuseable/global_function.dart to call function from GlobalFunction
include file in reuseable/shimmer_loading.dart to use shimmer loading
include file in reuseable/cache_image_network.dart to use cache image network
include file in model/account/last_seen_model.dart to get lastSeenData
include file in model/home/search/search_model.dart to get LsearchDataList

Don't forget to add all images and sound used in this pages at the pubspec.yaml
 */

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meroshopping_flutter/config/constants.dart';
import 'package:meroshopping_flutter/config/global_style.dart';
import 'package:meroshopping_flutter/model/home/search/search_model.dart';
import 'package:meroshopping_flutter/ui/general/product_detail/product_detail.dart';
import 'package:meroshopping_flutter/ui/reuseable/app_localizations.dart';
import 'package:meroshopping_flutter/ui/reuseable/cache_image_network.dart';
import 'package:meroshopping_flutter/ui/reuseable/global_function.dart';
import 'package:meroshopping_flutter/ui/reuseable/shimmer_loading.dart';
import '../../../bloc/products/bloc/searchlist_bloc.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  // initialize global function and shimmer loading
  final _globalFunction = GlobalFunction();
  final _shimmerLoading = ShimmerLoading();

  List<SearchModel> LsearchDataList = [];
  late SearchlistBloc _searchlistBloc;

  bool _lastDataSearch = false;

  CancelToken apiToken = CancelToken(); // used to cancel fetch data from API

  TextEditingController _etSearch = TextEditingController();

  List<dynamic> searchDataList = [];

  bool _lastData = false;

  @override
  void initState() {
    _searchlistBloc = BlocProvider.of<SearchlistBloc>(context);
  }

  @override
  void dispose() {
    apiToken.cancel("cancelled"); // cancel fetch data from API
    _etSearch.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double boxImageSize = (MediaQuery.of(context).size.width / 7);
    return Scaffold(
      appBar: AppBar(
          titleSpacing: 0.0,
          iconTheme: IconThemeData(
            color: GlobalStyle.appBarIconThemeColor,
          ),
          elevation: GlobalStyle.appBarElevation,
          backgroundColor: GlobalStyle.appBarBackgroundColor,
          systemOverlayStyle: GlobalStyle.appBarSystemOverlayStyle,
          // create search text field in the app bar
          title: Container(
            margin: EdgeInsets.only(right: 16),
            height: kToolbarHeight - 20,
            child: TextField(
              controller: _etSearch,
              autofocus: true,
              textInputAction: TextInputAction.search,
              onSubmitted: (textValue) {
                _searchlistBloc.add(SearchProductEvent(productName: textValue));
                setState(() {});
              },
              maxLines: 1,
              style: TextStyle(fontSize: 13, color: Colors.grey[600]),
              decoration: InputDecoration(
                prefixIcon:
                    Icon(Icons.search, color: Colors.grey[500], size: 18),
                suffixIcon: (_etSearch.text == '')
                    ? null
                    : GestureDetector(
                        onTap: () {
                          _searchlistBloc.add(
                              SearchProductEvent(productName: _etSearch.text));
                          setState(() {
                            ///search here
                          });
                        },
                        child: Icon(Icons.search_outlined,
                            color: Colors.grey[500], size: 18)),
                contentPadding: EdgeInsets.all(0),
                isDense: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                filled: true,
                fillColor: Colors.grey[200],
                hintText: AppLocalizations.of(context)!
                    .translate('search_product_small')!,
              ),
            ),
          )),
      body: BlocListener<SearchlistBloc, SearchlistState>(
          listener: (context, state) {
            if (state is SearchListFailed) {
              print(state.errorMessage);
              _globalFunction.showToast(
                  type: 'error', message: state.errorMessage);
            }
            // if (state is SearchListWaiting) {
            //   EasyLoading.show(status: "Loading");
            // }
            if (state is SearchListSuccess) {
              if (state.searchData.length == 0) {
                _lastDataSearch = true;
                // print(searchDataList);
              } else {
                // EasyLoading.dismiss();

                setState(() {
                  searchDataList.addAll(state.searchData);
                });
              }
            }
          },
          child: searchDataList.length == 0
              ? Container(
                  child: Center(child: Text("Searched items will appear here")),
                )
              : CustomScrollView(
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
                            childCount: searchDataList.length,
                          ),
                        ),
                      ),
                    ])),
    );
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
                          urlName: searchDataList[index].urlname,
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
                              "$BASE_IMAGE_URL${searchDataList[index].filename}")),
                ],
              ),
              Container(
                margin: EdgeInsets.fromLTRB(8, 8, 8, 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      searchDataList[index].name,
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
                              'Rs.  ' + searchDataList[index].price.toString(),
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

  void refresh() {
    searchDataList.clear();
    _searchlistBloc.add(SearchProductEvent(productName: _etSearch.text));
  }
}
