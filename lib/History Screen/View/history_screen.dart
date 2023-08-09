import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_app/Utils/firebase_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../Dash Screen/Model/product_model.dart';
import '../../Dash Screen/View/dash_screen.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        // appBar: AppBar(
        //   leading: InkWell(
        //     onTap: () {
        //       Get.back();
        //     },
        //     child: Container(
        //         height: 5.h,
        //         width: 5.h,
        //         margin: EdgeInsets.all(7.sp),
        //         decoration: BoxDecoration(
        //             shape: BoxShape.circle,
        //             image: DecorationImage(
        //                 image: AssetImage('assets/images/back.png'),
        //                 fit: BoxFit.fill))),
        //   ),
        //   backgroundColor: Colors.white,
        //   elevation: 0,
        // ),
        body: Column(
          children: [
            Padding(
              padding:  EdgeInsets.all(10.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("My Order",style: TextStyle(fontSize: 16.sp,color: Colors.black,fontWeight: FontWeight.bold),),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      OutlinedButton(onPressed: (){}, child: Text("Ongoing",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),)),
                      SizedBox(width: 10.sp,),
                      ElevatedButton(onPressed: (){}, child: Text("Completed",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),style: ElevatedButton.styleFrom(backgroundColor: Colors.black)),
                    ],
                  )
                ],
              ),
            ),
            Expanded(child: StreamBuilder(stream: FirebaseHelper.helper.readHistoryData(),builder: (context, snapshot) {
              if(snapshot.hasError)
                {
                  return Center(child: Text("Something wrong"));
                }
              else if(snapshot.hasData)
                {
                  controller.total_price.value=0;
                  QuerySnapshot<Map<String, dynamic>>? qs = snapshot.data;
                  List qsList = qs!.docs;
                  List<ProductModel> historyList = [];

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
                    historyList.add(m);
                    print('=============${historyList.length}');
                    controller.total_price.value+=(price!*item_count!);
                    return ListView.builder(itemBuilder: (context, index) {
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
                                        image: NetworkImage("${historyList[index].img}")
                                    )
                                ),
                              ),
                            ),
                            Expanded(child: Container(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("${historyList[index].name}",style: TextStyle(fontSize: 14.sp,color: Colors.black,fontWeight: FontWeight.bold),),
                                        Text("Qty : ${historyList[index].item_count}",style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.bold),)
                                      ],
                                    ),
                                    Text("${historyList[index].desc}",style: TextStyle(fontSize: 11.sp,color: Colors.grey,fontWeight: FontWeight.bold),maxLines: 1,),
                                    Text("₹${(historyList[index].price!*historyList[index].item_count!)}",style: TextStyle(fontSize: 14.sp,color: Colors.black,fontWeight: FontWeight.bold))
                                  ],
                                ),
                              ),
                            ),),
                          ],
                        ),
                      );
                    },
                      itemCount: historyList.length,
                    );
                  }
                }
              return Center(child: CircularProgressIndicator(),);
            },))
          ],
        ),
      ),
    );
  }
}
