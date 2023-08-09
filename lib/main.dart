import 'package:fashion_app/AddCard%20Screen/View/addcard_screen.dart';
import 'package:fashion_app/Address%20Screen/View/address_screen.dart';
import 'package:fashion_app/Cart%20screen/View/cart_screen.dart';
import 'package:fashion_app/Dash%20Screen/View/dash_screen.dart';
import 'package:fashion_app/Drawer%20Screen/View/coupon.dart';
import 'package:fashion_app/Drawer%20Screen/View/profile_screen.dart';
import 'package:fashion_app/Review%20screen/View/review_screen.dart';
import 'package:fashion_app/Search%20Screen/View/search_screen.dart';
import 'package:fashion_app/Signin%20Signup%20Screen/View/signin_screen.dart';
import 'package:fashion_app/Signin%20Signup%20Screen/View/splace_screen.dart';
import 'package:fashion_app/View%20Screen/View/view_screen.dart';
import 'package:fashion_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'Signin Signup Screen/View/signUp_screen.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    Sizer(
      builder: (context, orientation, deviceType) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/':(p0) => SplaceScreen(),
          'signin':(p0) => SignInScreen(),
          'signup':(p0) => SignUpScreen(),
           'dash':(p0) => DashScreen(),
          'view':(p0) => ViewScreen(),
          'cart':(p0) => CartScreen(),
          'address':(p0) => AddressScreen(),
          'review':(p0) => ReviewScreen(),
          'card':(p0) => AddCardScreen(),
          'search':(p0) => SearchScreen(),
          'coupon':(p0) => CouponScreen(),
          'profile':(p0) => ProfileScreen(),
        },
      ),
    ),
  );
}
