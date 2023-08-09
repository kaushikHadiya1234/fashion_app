import 'package:fashion_app/Dash%20Screen/View/dash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../Dash Screen/Model/product_model.dart';
import '../../Utils/firebase_helper.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(alignment:Alignment.centerLeft,child: Text("My Favorite product",style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.bold,color: Colors.black),)),
            ),
            SizedBox(height: 10.sp,),
            Expanded(child: GridView.builder(
              physics: BouncingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,mainAxisExtent: 35.h),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    ProductModel m = ProductModel(
                        name: controller.favoriteList[index].name,
                        img: controller.favoriteList[index].img,
                        price: controller.favoriteList[index].price,
                        cate: controller.favoriteList[index].cate,
                        desc: controller.favoriteList[index].desc,
                        like: controller.favoriteList[index].like
                    );
                    Get.toNamed("view",arguments: m);
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 25.h,
                        width: 40.w,
                        alignment: Alignment.topLeft,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.sp),
                            image: DecorationImage(
                                image: NetworkImage("${controller.favoriteList[index].img}")
                            ),
                            color: Colors.grey.shade100),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                ProductModel model =ProductModel(
                                  name: controller.favoriteList[index].name,
                                  id: controller.favoriteList[index].id,
                                  price: controller.favoriteList[index].price,
                                  cate: controller.favoriteList[index].cate,
                                  img: controller.favoriteList[index].img,
                                  desc: controller.favoriteList[index].desc,
                                  like: controller.favoriteList[index].like==false?true:false,
                                );
                                FirebaseHelper.helper.updateData(model);
                                print('==================${model.like}');
                              },
                              child: Container(
                                height: 4.h,
                                width: 4.h,
                                margin: EdgeInsets.all(10),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey.shade300),
                                child:   Icon(
                                  controller.favoriteList[index].like==true?Icons.favorite:Icons.favorite_border_outlined,
                                  color: controller.favoriteList[index].like==true?Colors.amber.shade700:Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 20.sp),
                        child: Text(
                          "${controller.favoriteList[index].name}",
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold),maxLines: 1,
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 20.sp),
                        child: Text(
                          "${controller.favoriteList[index].desc}",
                          style: TextStyle(
                              fontSize: 10.sp,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500),maxLines: 1,
                        ),
                      ),
                      Text(
                        "₹${controller.favoriteList[index].price}",
                        style: TextStyle(
                            fontSize: 13.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                );
              },
              itemCount: controller.favoriteList.length,
            ),)
          ],
        ),
      ),
    ),);
  }
}
