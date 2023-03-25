import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meroshopping_flutter/bloc/products/categories/fetchcategoriesbloc/fetchcategories_bloc.dart';
import 'package:meroshopping_flutter/config/constants.dart';
import 'package:meroshopping_flutter/config/global_style.dart';
import 'package:meroshopping_flutter/ui/home/category/product_category.dart';
import 'package:meroshopping_flutter/ui/reuseable/cache_image_network.dart';
import 'package:meroshopping_flutter/ui/reuseable/shimmer_loading.dart';

class AllcategoryPage extends StatefulWidget {
  const AllcategoryPage({Key? key}) : super(key: key);

  @override
  State<AllcategoryPage> createState() => _AllcategoryPageState();
}

class _AllcategoryPageState extends State<AllcategoryPage> {
  List categoryData = [];
  late FetchcategoriesBloc _fetchcategoriesBloc;
  bool _lastDataCategory = false;
  final _shimmerLoading = ShimmerLoading();
  @override
  void initState() {
    _fetchcategoriesBloc = BlocProvider.of<FetchcategoriesBloc>(context);
    _fetchcategoriesBloc.add(FetchAllcategoriesEvent());
    // Timer(Duration(seconds: 3),()){

    // }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'All Categories',
          style: GlobalStyle.appBarTitle,
        ),
        backgroundColor: GlobalStyle.appBarBackgroundColor,
        systemOverlayStyle: GlobalStyle.appBarSystemOverlayStyle,
        iconTheme: IconThemeData(
          color: GlobalStyle.appBarIconThemeColor,
        ),
        elevation: GlobalStyle.appBarElevation,
      ),
      body: BlocListener<FetchcategoriesBloc, FetchcategoriesState>(
          listener: (context, state) {
        if (state is FetchcategoriesError) {}
        if (state is FetchcategoriesSuccess) {
          if (state.data.length == 0) {
            _lastDataCategory = true;
          } else {
            categoryData.addAll(state.data);
          }
        }
      }, child: BlocBuilder<FetchcategoriesBloc, FetchcategoriesState>(
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
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      GridView.count(
                        padding: EdgeInsets.fromLTRB(16, 20, 16, 0),
                        primary: false,
                        childAspectRatio: 1.1,
                        shrinkWrap: true,
                        crossAxisSpacing: 0,
                        mainAxisSpacing: 0,
                        crossAxisCount: 4,
                        children: List.generate(categoryData.length, (index) {
                          return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ProductCategoryPage(
                                                categoryId:
                                                    categoryData[index].id,
                                                categoryName:
                                                    categoryData[index]
                                                        .title)));
                              },
                              child: Column(children: [
                                buildCacheNetworkImage(
                                    width: 25,
                                    height: 25,
                                    url: categoryData[index].icon != null
                                        ? "$BASE_IMAGE_URL${categoryData[index].icon}"
                                        : "https://hamrowholesale.com/front/assets/image/catalog/demo/logo/logo-old.png",
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
                  ),
                );
              }
            }
          }
        },
      )),
    );
  }
}
