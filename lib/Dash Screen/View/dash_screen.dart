import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_app/Cart%20screen/View/cart_screen.dart';
import 'package:fashion_app/Dash%20Screen/Controller/home_controller.dart';
import 'package:fashion_app/Favorite%20Screen/View/favorite_screen.dart';
import 'package:fashion_app/History%20Screen/View/history_screen.dart';
import 'package:fashion_app/Home%20Screen/View/home_screen.dart';
import 'package:fashion_app/Utils/firebase_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../Notification Screen/View/notification_screen.dart';
import '../Model/product_model.dart';

class DashScreen extends StatefulWidget {
  const DashScreen({Key? key}) : super(key: key);

  @override
  State<DashScreen> createState() => _DashScreenState();
}

HomeController controller = Get.put(HomeController());
class _DashScreenState extends State<DashScreen> {

  @override
  void initState() {
     FirebaseHelper.helper.userDetaile();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: IndexedStack(
          index: controller.currentIndex.value,
          children: [
            HomeScreen(),
            FavoriteScreen(),
            CartScreen(),
            NotificationScreen(),
          ],
        ),
        bottomNavigationBar: SalomonBottomBar(
          backgroundColor: Colors.white,
          currentIndex: controller.currentIndex.value,
          onTap: (value) {
           setState(() {
             controller.currentIndex.value = value;
           });
          },
          items: [
            SalomonBottomBarItem(
              icon: Icon(Icons.home_outlined),
              title: Text("Home"),
              selectedColor: Colors.purple,
            ),
            SalomonBottomBarItem(
              icon: Icon(Icons.favorite_border_outlined),
              title: Text("Favorite"),
              selectedColor: Colors.teal,
            ),
            SalomonBottomBarItem(
              icon: Icon(Icons.shopping_cart_outlined),
              title: Text("Cart"),
              selectedColor: Colors.pink,
            ),
            SalomonBottomBarItem(
              icon: Icon(Icons.notification_add_outlined),
              title: Text("Notification"),
              selectedColor: Colors.orange,
            ),
          ],
        ),
      ),
    );
  }
}
