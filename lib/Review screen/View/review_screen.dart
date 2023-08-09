import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_app/Dash%20Screen/Model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../Dash Screen/View/dash_screen.dart';
import '../../Utils/firebase_helper.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({Key? key}) : super(key: key);

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {

  AddressModel m = Get.arguments;


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Container(
                height: 5.h,
                width: 5.h,
                margin: EdgeInsets.all(7.sp),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage('assets/images/back.png'),
                        fit: BoxFit.fill))),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 15.sp,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Delivery Adderess",
                style: TextStyle(
                    fontSize: 15.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.sp),
              Container(
                height: 25.h,
                width: 90.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.sp),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0, 0),
                          blurRadius: 2,
                          spreadRadius: 2)
                    ]),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildRow(name: "Street",data: m.street),
                      buildRow(name: 'City',data: m.city),
                      buildRow(name: 'State',data: m.state),
                      buildRow(name: 'Zip code',data: m.zipcod),
                      buildRow(name: 'Phone number',data: m.cno),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10.sp),
              Text("Product item",style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.bold,color: Colors.black),),
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
                     if(cartList==null)
                       {
                         FirebaseHelper.helper.add_history(m);

                       }

                      controller.total_price.value+=(price!*item_count!);

                    }
                    return  Column(
                      children: [
                        Expanded(
                          child: ListView.builder(itemBuilder: (context, index) {
                            return Container(
                              height: 13.h,
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
                                      height: 12.h,
                                      width: 12.h,
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
                                      padding:  EdgeInsets.symmetric(horizontal:5.sp),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                  width: 40.w,
                                                  child: Text("${cartList[index].name}",style: TextStyle(fontSize: 13.sp,color: Colors.black,fontWeight: FontWeight.bold),maxLines: 1,)),
                                             Text("Qty : ${cartList[index].item_count}",style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.bold),)
                                            ],
                                          ),
                                          Text("${cartList[index].desc}",style: TextStyle(fontSize: 11.sp,color: Colors.grey,fontWeight: FontWeight.bold),maxLines: 1,),
                                          Text("₹${(cartList[index].price!*cartList[index].item_count!)}",style: TextStyle(fontSize: 14.sp,color: Colors.black,fontWeight: FontWeight.bold))
                                        ],
                                      ),
                                    ),
                                  ),),
                                ],
                              ),
                            );
                          },itemCount: cartList.length,
                            physics: BouncingScrollPhysics(),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('Total pay',style: TextStyle(fontSize: 15.sp,color: Colors.grey),),
                                  Text("₹${controller.total_price}",style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.bold,color: Colors.black),),
                                ],
                              ),
                              InkWell(
                                onTap: () {
                                  Get.toNamed("card");
                                },
                                child: Container(
                                  height: 6.h,
                                  width: 40.w,
                                   alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.sp),
                                    color: Colors.black
                                  ),
                                  child: Text("Place Order",style: TextStyle(fontSize: 15.sp,color: Colors.white,fontWeight: FontWeight.bold),),
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
      ),
    );
  }

  Row buildRow({name,data}) {
    return Row(
      children: [
        Text(
          "$name : ",
          style: TextStyle(
              fontSize: 14.sp,
              color: Colors.black,
              fontWeight: FontWeight.bold),
        ),
        Text(
          "${data}",
          style: TextStyle(fontSize: 13.sp, color: Colors.black),
          maxLines: 1,
        ),
      ],
    );
  }
}
