import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_app/Utils/firebase_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../Dash Screen/Model/product_model.dart';
import '../../Dash Screen/View/dash_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text("My Cart",style: TextStyle(color: Colors.black),),
            backgroundColor: Colors.white,
            elevation: 0,
          ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: StreamBuilder(stream: FirebaseHelper.helper.readCartData(),builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text("${snapshot.error}"),
                  );
                }
                else if(snapshot.hasData)
                  {
                    controller.total_price.value=0;
                    QuerySnapshot<Map<String, dynamic>>? qs = snapshot.data;
                    List qsList = qs!.docs;
                    List<ProductModel> cartList = [];
                    controller.favoriteList.clear();
                    controller.myList.clear();

                    for (var x in qsList) {
                      Map m1 = x.data();
                      String? id = x.id;
                      String? name = m1['name'];
                      int? price = m1['price'];
                      String? category = m1['category'];
                      String? image = m1['image'];
                      String? desc = m1['desc'];
                      bool? like = m1['like'];
                      int? item_count=m1['item_count'];

                      ProductModel m = ProductModel(
                          name: name,
                          price: price,
                          cate: category,
                          img: image,id: id,
                          desc: desc,
                          like: like,
                        item_count: item_count
                      );
                      if(like==true)
                      {
                        controller.favoriteList.add(m);
                      }
                      cartList.add(m);
                      controller.myList.add(m);

                      print('====cartList==============${cartList.length}');
                      print('====mylist==============${controller.myList.length}');


                      controller.total_price.value+=(price!*item_count!);
                      FirebaseHelper.helper.add_history(m);
                    }
                    return  Column(
                      children: [
                       cartList.isEmpty?SizedBox(height: 70.h,child: Center(child: Image.asset('assets/images/cartemty.png',color: Colors.grey.shade300,height: 30.h,))): Expanded(
                          child: ListView.builder(itemBuilder: (context, index) {
                            return GestureDetector(
                              onLongPress: () {
                                ProductModel m = ProductModel(
                                  name: cartList[index].name,
                                  price: cartList[index].price,
                                  cate: cartList[index].cate,
                                  img: cartList[index].img,
                                  desc: cartList[index].desc,
                                  id: cartList[index].id,
                                   item_count: cartList[index].item_count,
                                );
                                Get.toNamed('view',arguments: m);
                              },
                              child: Container(
                                height: 15.h,
                                width: 100.w,
                                margin: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.sp),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 3,
                                          color: Colors.grey.shade200,
                                          spreadRadius: 2,offset: Offset(0, 0.5)
                                      )
                                    ]
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 30.w,
                                      alignment: Alignment.center,
                                      child: Container(
                                        height: 14.h,
                                        width: 14.h,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15.sp),
                                            color: Colors.grey.shade200,
                                            image: DecorationImage(
                                                image: NetworkImage("${cartList[index].img}")
                                            )
                                        ),
                                      ),
                                    ),
                                    Expanded(child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(
                                                    width: 40.w,
                                                    child: Text("${cartList[index].name}",style: TextStyle(fontSize: 13.sp,color: Colors.black,fontWeight: FontWeight.bold),maxLines: 1,)),
                                                IconButton(onPressed: () {
                                                  FirebaseHelper.helper.deleteCartData(cartList[index].id);
                                                },icon: Icon(Icons.delete))
                                              ],
                                            ),
                                            Text("${cartList[index].desc}",style: TextStyle(fontSize: 11.sp,color: Colors.grey,fontWeight: FontWeight.bold),maxLines: 1,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text("₹${(cartList[index].price!*cartList[index].item_count!)}",style: TextStyle(fontSize: 14.sp,color: Colors.black,fontWeight: FontWeight.bold)),
                                                Container(
                                                  height: 5.h,
                                                  width: 31.w,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(15.sp),
                                                      color: Colors.grey.shade200
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    children: [
                                                      Padding(
                                                        padding:  EdgeInsets.only(bottom: 18.0),
                                                        child: IconButton(onPressed: () {
                                                          ProductModel m = ProductModel(
                                                              name: cartList[index].name,
                                                              price: cartList[index].price,
                                                              cate: cartList[index].cate,
                                                              img: cartList[index].img,
                                                              desc: cartList[index].desc,
                                                              id: cartList[index].id,
                                                              item_count: cartList[index].item_count!-1
                                                          );

                                                          print(m.item_count);

                                                        if(m.item_count!>0)
                                                          {
                                                            FirebaseHelper.helper.updateCartData(m);
                                                          }
                                                          if(m.item_count!<=0)
                                                          {
                                                            Get.snackbar('Sorry', "minimum 1 product order",margin: EdgeInsets.all(10));

                                                          }
                                                        },icon: Icon(Icons.remove_circle_outline,size: 20.sp,)),
                                                      ),
                                                      Text('${cartList[index].item_count!}',style: TextStyle(fontSize: 15.sp,color: Colors.black,fontWeight: FontWeight.bold),),
                                                      IconButton(onPressed: () {
                                                        ProductModel m = ProductModel(
                                                          name: cartList[index].name,
                                                          price: cartList[index].price,
                                                          cate: cartList[index].cate,
                                                          img: cartList[index].img,
                                                          desc: cartList[index].desc,
                                                          id: cartList[index].id,
                                                          item_count: cartList[index].item_count!+1
                                                        );

                                                        print(m.item_count);

                                                        if(m.item_count!<=5)
                                                          {
                                                            FirebaseHelper.helper.updateCartData(m);

                                                          }
                                                        if(m.item_count!>5)
                                                        {
                                                          Get.snackbar('Sorry', "maximum 5 product order",margin: EdgeInsets.all(10));

                                                        }

                                                      },icon: Icon(Icons.add_circle_outline,size: 20.sp,)),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),),
                                  ],
                                ),
                              ),
                            );
                          },itemCount: cartList.length,
                            physics: BouncingScrollPhysics(),
                          ),
                        ),
                        Visibility(
                          visible: cartList.isNotEmpty,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextField(
                                maxLength: 8,
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.grey.shade300,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15.sp),
                                        borderSide: BorderSide(color: Colors.grey)
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15.sp),
                                        borderSide: BorderSide(color: Colors.grey)
                                    ),
                                    hintText: "Promo code..",
                                    suffixIcon: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Container(
                                        height: 5.h,
                                        width: 20.w,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10.sp),
                                            color: Colors.black
                                        ),
                                        child: Text("Apply",style: TextStyle(fontSize: 15.sp,color: Colors.white,fontWeight: FontWeight.bold),),
                                      ),
                                    )
                                ),
                              ),
                              SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Total(${cartList.length} item)",style: TextStyle(fontSize: 15.sp,color: Colors.grey,fontWeight: FontWeight.bold),),
                                    Text("₹${controller.total_price}",style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.bold,color: Colors.black),),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: InkWell(
                                  onTap: () {
                                    Get.toNamed('address');
                                  },
                                  child: Container(
                                    height: 6.5.h,
                                    width: 90.w,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.sp),
                                        color: Colors.black
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text("Proceed to Continue",style: TextStyle(fontSize: 15.sp,color: Colors.white,fontWeight: FontWeight.bold)),
                                        Image.asset('assets/images/next.png',height: 5.h,)
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                return Center(child: CircularProgressIndicator(),);
              },),
            ),
          ],
        ),
      ),
    ));
  }
  @override
  void deactivate() {
    controller.total_price.value=0;
    super.deactivate();
  }
}
