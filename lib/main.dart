/*
this is the first pages of the apps
you can use logic to direct the pages to bottom_navigation_bar.dart or signin.dart
this demo is direct to login.dart
We use CupertinoPageTransitionsBuilder in this demo
If you want to use default transition, then remove ThemeData Widget below and delete theme attribute
If you want to show debug label, then change debugShowCheckedModeBanner to true

To use multiple language, wrap BlocBuilder with InitialWrapper
Initial wrapper is to get the language from shared preferences when first time you open the apps
in MaterialApp attribute : add supportedLocales, localizationsDelegates and locale

To use multi language in other page, this is the step :
open assets/lang/en.json and other language and add new 'word' language in the json field
add import 'package:meroshopping_flutter/ui/reuseable/app_localizations.dart'; in the page
and then use AppLocalizations.of(context)!.translate('word')!
for simple example, you could see lib/ui/default.dart => AppLocalizations.of(context)!.translate('default')!
 */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:meroshopping_flutter/bloc/account/accountinfo/bloc/account_bloc.dart';
import 'package:meroshopping_flutter/bloc/account/order_list/bloc.dart';
import 'package:meroshopping_flutter/bloc/auth/forgotpwdbloc/bloc/forgot_pwd_bloc.dart';
import 'package:meroshopping_flutter/bloc/auth/gmailregisterbloc/gmailregister_bloc.dart';
import 'package:meroshopping_flutter/bloc/auth/registerbloc/register_bloc.dart';
import 'package:meroshopping_flutter/bloc/auth/signinbloc/signin_bloc.dart';
import 'package:meroshopping_flutter/bloc/products/bloc/searchlist_bloc.dart';
import 'package:meroshopping_flutter/bloc/products/brands/brandproductbloc/brandproduct_bloc.dart';
import 'package:meroshopping_flutter/bloc/products/brands/brandsbloc/brands_bloc.dart';
import 'package:meroshopping_flutter/bloc/products/cart/cartbloc/cart_bloc.dart';
import 'package:meroshopping_flutter/bloc/products/categories/fetchcategoriesbloc/fetchcategories_bloc.dart';
import 'package:meroshopping_flutter/bloc/products/categories/getcategoryproductsbloc/getcategoryproducts_bloc.dart';
import 'package:meroshopping_flutter/bloc/products/categories/getsubcategoriesbloc/getsubcategories_bloc.dart';
import 'package:meroshopping_flutter/bloc/products/categories/getsubcategorybloc/getsubcategory_bloc.dart';
import 'package:meroshopping_flutter/bloc/products/categories/getsubcategoryproductsbloc/getsubcategoryproducts_bloc.dart';
import 'package:meroshopping_flutter/bloc/products/categories/getsubsubcategoryproductsbloc/getsubsubcategoryproducts_bloc.dart';
import 'package:meroshopping_flutter/bloc/products/checkout/checkoutbloc/checkout_bloc.dart';
import 'package:meroshopping_flutter/bloc/products/checkout/topsellingbloc/topselling_bloc.dart';
import 'package:meroshopping_flutter/bloc/products/fetchwishlistbloc/fetchwishlistbloc_bloc.dart';
import 'package:meroshopping_flutter/bloc/products/tags/tagbloc/tags_bloc.dart';
import 'package:meroshopping_flutter/bloc/products/tags/tagproductbloc/tagproduct_bloc.dart';
import 'package:meroshopping_flutter/config/constants.dart';
import 'package:meroshopping_flutter/cubit/language/language_cubit.dart';
import 'package:meroshopping_flutter/ui/reuseable/app_localizations.dart';
import 'package:meroshopping_flutter/ui/reuseable/initial_wrapper.dart';
import 'package:meroshopping_flutter/ui/splash_screen.dart';

import 'bloc/homebannerbloc/bloc/homebanner_bloc.dart';

void main() {
  // this function makes application always run in portrait mode
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // initialize bloc here
    return MultiBlocProvider(
      providers: [
        BlocProvider<LanguageCubit>(
          create: (BuildContext context) => LanguageCubit(),
        ),
        BlocProvider<SigninBloc>(
          create: (BuildContext context) => SigninBloc(),
        ),
        BlocProvider<RegisterBloc>(
          create: (BuildContext context) => RegisterBloc(),
        ),
        BlocProvider<FetchcategoriesBloc>(
          create: (BuildContext context) => FetchcategoriesBloc(),
        ),
        BlocProvider<GetsubcategoriesBloc>(
          create: (BuildContext context) => GetsubcategoriesBloc(),
        ),
        BlocProvider<GetsubcategoryBloc>(
          create: (BuildContext context) => GetsubcategoryBloc(),
        ),
        BlocProvider<GetsubsubcategoryproductsBloc>(
          create: (BuildContext context) => GetsubsubcategoryproductsBloc(),
        ),
        BlocProvider<GetsubcategoryproductsBloc>(
          create: (BuildContext context) => GetsubcategoryproductsBloc(),
        ),
        BlocProvider<OrderListBloc>(
          create: (BuildContext context) => OrderListBloc(),
        ),
        BlocProvider<GetcategoryproductsBloc>(
          create: (BuildContext context) => GetcategoryproductsBloc(),
        ),
        BlocProvider<TopsellingBloc>(
          create: (BuildContext context) => TopsellingBloc(),
        ),
        BlocProvider<GmailregisterBloc>(
          create: (BuildContext context) => GmailregisterBloc(),
        ),
        BlocProvider<FetchwishlistblocBloc>(
          create: (BuildContext context) => FetchwishlistblocBloc(),
        ),
        BlocProvider<TagsBloc>(
          create: (BuildContext context) => TagsBloc(),
        ),
        BlocProvider<TagproductBloc>(
          create: (BuildContext context) => TagproductBloc(),
        ),
        BlocProvider<BrandsBloc>(
          create: (BuildContext context) => BrandsBloc(),
        ),
        BlocProvider<BrandproductBloc>(
          create: (BuildContext context) => BrandproductBloc(),
        ),
        BlocProvider<CartBloc>(
          create: (BuildContext context) => CartBloc(),
        ),
        BlocProvider<HomebannerBloc>(
          create: (BuildContext context) => HomebannerBloc(),
        ),
        BlocProvider<AccountBloc>(
          create: (BuildContext context) => AccountBloc(),
        ),
        BlocProvider<CheckoutBloc>(
          create: (BuildContext context) => CheckoutBloc(),
        ),
        BlocProvider<ForgotPwdBloc>(
          create: (BuildContext context) => ForgotPwdBloc(),
        ),
        BlocProvider<SearchlistBloc>(
          create: (BuildContext context) => SearchlistBloc(),
        ),
      ],
      // if you want to change default language, go to lib/ui/reuseable/initial_wrapper.dart and change en US to your default language
      child: InitialWrapper(
        child: BlocBuilder<LanguageCubit, LanguageState>(
            builder: (context, state) {
          return MaterialApp(
            theme: ThemeData(
              pageTransitionsTheme: PageTransitionsTheme(builders: {
                TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
                TargetPlatform.android: CupertinoPageTransitionsBuilder(),
              }),
            ),
            supportedLocales: [
              Locale('en', 'US'),
              Locale('id', 'ID'),
              Locale('ar', 'DZ'),
              Locale('zh', 'HK'),
              Locale('hi', 'IN'),
              Locale('th', 'TH'),
            ],
            // These delegates make sure that the localization data for the proper language is loaded
            localizationsDelegates: [
              AppLocalizationsDelegate(),
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            // Returns a locale which will be used by the app
            locale: (state is ChangeLanguageSuccess)
                ? state.locale
                : Locale('en', 'US'),
            title: APP_NAME,
            debugShowCheckedModeBanner: false,
            builder: EasyLoading.init(),
            home: SplashScreenPage(),
          );
        }),
      ),
    );
  }
}
