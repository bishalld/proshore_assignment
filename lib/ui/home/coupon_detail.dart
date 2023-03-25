// /*
// This is coupon detail page

// include file in reuseable/global_function.dart to call function from GlobalFunction
// include file in reuseable/global_widget.dart to call function from GlobalWidget
// include file in reuseable/shimmer_loading.dart to use shimmer loading
// include file in model/home/coupon_model.dart to get couponData

// install plugin in pubspec.yaml
// - fluttertoast => to show toast (https://pub.dev/packages/fluttertoast)
//  */

// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:meroshopping_flutter/config/constants.dart';
// import 'package:meroshopping_flutter/config/global_style.dart';
// import 'package:meroshopping_flutter/model/home/coupon_model.dart';
// import 'package:meroshopping_flutter/ui/reuseable/app_localizations.dart';
// import 'package:meroshopping_flutter/ui/reuseable/global_function.dart';
// import 'package:meroshopping_flutter/ui/reuseable/global_widget.dart';
// import 'package:meroshopping_flutter/ui/reuseable/shimmer_loading.dart';

// class CouponDetailPage extends StatefulWidget {
//   final int couponId;

//   const CouponDetailPage({Key? key, this.couponId = 0}) : super(key: key);

//   @override
//   _CouponDetailPageState createState() => _CouponDetailPageState();
// }

// class _CouponDetailPageState extends State<CouponDetailPage> {
//   // initialize global function, global widget and shimmer loading
//   final _globalFunction = GlobalFunction();
//   final _globalWidget = GlobalWidget();
//   final _shimmerLoading = ShimmerLoading();

//   late CouponBloc _couponBloc;

//   CouponModel? couponData;
//   CancelToken apiToken = CancelToken(); // used to cancel fetch data from API

//   @override
//   void initState() {
//     // get data when initState
//     _couponBloc = BlocProvider.of<CouponBloc>(context);
//     _couponBloc.add(GetCouponDetail(
//         sessionId: SESSION_ID, id: widget.couponId, apiToken: apiToken));

//     super.initState();
//   }

//   @override
//   void dispose() {
//     apiToken.cancel("cancelled"); // cancel fetch data from API
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           iconTheme: IconThemeData(
//             color: GlobalStyle.appBarIconThemeColor,
//           ),
//           elevation: GlobalStyle.appBarElevation,
//           title: Text(
//             AppLocalizations.of(context)!.translate('coupon_detail')!,
//             style: GlobalStyle.appBarTitle,
//           ),
//           backgroundColor: GlobalStyle.appBarBackgroundColor,
//           systemOverlayStyle: GlobalStyle.appBarSystemOverlayStyle,
//           bottom: _globalWidget.bottomAppBar(),
//         ),
//         body: BlocListener<CouponBloc, CouponState>(
//           listener: (context, state) {
//             if (state is CouponDetailError) {
//               _globalFunction.showToast(
//                   type: 'error', message: state.errorMessage);
//             }
//             if (state is GetCouponDetailSuccess) {
//               couponData = state.couponData;
//             }
//           },
//           child: BlocBuilder<CouponBloc, CouponState>(
//             builder: (context, state) {
//               if (state is CouponDetailError) {
//                 return Container(
//                     child: Center(
//                         child: Text(ERROR_OCCURED,
//                             style:
//                                 TextStyle(fontSize: 14, color: BLACK_GREY))));
//               } else {
//                 if (couponData == null) {
//                   return _shimmerLoading.buildShimmerContent();
//                 } else {
//                   return ListView(
//                     padding: EdgeInsets.fromLTRB(24, 20, 24, 24),
//                     children: [
//                       _buildCouponCard(couponData!),
//                       Container(
//                         margin: EdgeInsets.only(top: 24),
//                         child: Text(
//                             AppLocalizations.of(context)!
//                                 .translate('terms_conditions')!,
//                             style: TextStyle(
//                                 fontSize: 16, fontWeight: FontWeight.bold)),
//                       ),
//                       Container(
//                         margin: EdgeInsets.only(top: 12),
//                         child: Text(couponData!.term),
//                       ),
//                       Container(
//                         margin: EdgeInsets.only(top: 12),
//                         child: TextButton(
//                             style: ButtonStyle(
//                               backgroundColor:
//                                   MaterialStateProperty.resolveWith<Color>(
//                                 (Set<MaterialState> states) => PRIMARY_COLOR,
//                               ),
//                               overlayColor:
//                                   MaterialStateProperty.all(Colors.transparent),
//                               shape: MaterialStateProperty.all(
//                                   RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(3.0),
//                               )),
//                             ),
//                             onPressed: () {
//                               Fluttertoast.showToast(
//                                   msg: AppLocalizations.of(context)!
//                                       .translate('coupon_applied')!,
//                                   toastLength: Toast.LENGTH_LONG);
//                               Navigator.pop(context);
//                               Navigator.pop(context);
//                             },
//                             child: Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(vertical: 5.0),
//                               child: Text(
//                                 AppLocalizations.of(context)!.translate('use')!,
//                                 style: TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.white),
//                                 textAlign: TextAlign.center,
//                               ),
//                             )),
//                       ),
//                     ],
//                   );
//                 }
//               }
//             },
//           ),
//         ));
//   }

//   Widget _buildCouponCard(CouponModel couponData) {
//     return Card(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(4),
//       ),
//       elevation: 2,
//       color: Colors.white,
//       child: Container(
//         padding: EdgeInsets.all(24),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Text(couponData.name,
//                 style: GlobalStyle.couponName.copyWith(fontSize: 18)),
//             SizedBox(height: 12),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Container(
//                   margin: EdgeInsets.only(top: 5),
//                   padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
//                   decoration: BoxDecoration(
//                       color: SOFT_BLUE,
//                       borderRadius: BorderRadius.circular(5)), //
//                   child: Text(
//                       AppLocalizations.of(context)!.translate('limited_offer')!,
//                       style: GlobalStyle.couponLimitedOffer),
//                 ),
//                 Row(
//                   children: [
//                     GlobalStyle.iconTime,
//                     SizedBox(
//                       width: 4,
//                     ),
//                     Text(
//                         AppLocalizations.of(context)!
//                                 .translate('expiring_in')! +
//                             ' ' +
//                             couponData.day +
//                             ' ' +
//                             AppLocalizations.of(context)!.translate('days')!,
//                         style: GlobalStyle.couponExpired),
//                   ],
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
