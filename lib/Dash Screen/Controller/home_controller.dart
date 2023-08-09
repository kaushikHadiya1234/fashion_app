import 'package:fashion_app/Dash%20Screen/Model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxInt currentIndex = 0.obs;

  RxList colorList = [
    Colors.black,
    Colors.grey,
    Colors.red,
    Colors.purple,
    Colors.cyan,
    Colors.pink
  ].obs;

  RxInt total_item = 1.obs;

  RxInt total_item_price = 0.obs;
  RxInt total_price = 0.obs;
  RxBool fav = false.obs;

  RxList<ProductModel> favoriteList = <ProductModel>[].obs;

  List<ProductModel> myList = [];

  RxList<ProductModel> cartList = <ProductModel>[].obs;
  RxList<ProductModel> searchList = <ProductModel>[].obs;
  RxList<ProductModel> filterList = <ProductModel>[].obs;

  void filterSearchData(search) {
    filterList.clear();
    if (search.isEmpty) {
      searchList.value = List.from(cartList);
      print('searchList=====================${searchList.length}');
    } else {
      for (var c1 in cartList) {
        if (c1.name!.toLowerCase().contains(search.toLowerCase()) || c1.cate!.toLowerCase().contains(search.toLowerCase()) ) {
          filterList.add(c1);
        }
        searchList.value = List.from(filterList);
      }
    }
    update();
  }

  RxList<CouponModel> couponList = <CouponModel>[
    CouponModel(img: 'assets/images/of1.png',title:'Was Flat 7.2%' ,desc:'Upto 19.2% CD Cashback' ),
    CouponModel(img: 'assets/images/of2.png',title: 'Was Flat 33%',desc: 'Flat 41.2% CD Cashback'),
    CouponModel(img: 'assets/images/of3.png',title: 'Was Flat 10.5%',desc:'Flat 12.8% CD Cashback' ),
    CouponModel(img: 'assets/images/of4.jpg',title: 'Upto 1.7% CD Cashback',desc: 'Upto 1.7% CD Cashback'),
    CouponModel(img: 'assets/images/of5.jpg',title: 'Great Freedom Festival: Get Upto 80% Off Across Categories + 10% Off On SBI',desc:'Upto 7.8% CD Voucher Rewards' ),
    CouponModel(img: 'assets/images/of6.jpg',title:'Big Saving Days: Crazy Deals On Mobiles, Home Furnishing, Fashion & More (4th Aug,' ,desc: 'Upto 10.5% CD Rewards'),
    CouponModel(img: 'assets/images/of7.jpg',title: 'Right To Fashion Sale: Upto 50-80% Off On Fashion (3rd-8th Aug)',desc: 'Upto 7.5% CD Cashback'),
    CouponModel(img: 'assets/images/of8.jpg',title: 'Fashionation Sale: Get 50-90% Off On 5000+ Brands + Extra Upto 30% Off + Bank Discounts',desc: 'Flat 1.8% CD Cashback'),
  ].obs;

  RxMap userDatails = {}.obs;
}
