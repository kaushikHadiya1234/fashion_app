import 'package:fashion_app/Dash%20Screen/Model/product_model.dart';
import 'package:fashion_app/Dash%20Screen/View/dash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../Utils/firebase_helper.dart';

class ViewScreen extends StatefulWidget {
  const ViewScreen({Key? key}) : super(key: key);

  @override
  State<ViewScreen> createState() => _ViewScreenState();
}

class _ViewScreenState extends State<ViewScreen> {
  ProductModel m = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Column(
        children: [
          Container(
            height: 40.h,
            width: 100.w,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Colors.grey.shade300,
              Colors.grey.shade200,
              Colors.grey.shade100,
              Colors.grey.shade50,
              Colors.grey.shade100,
              Colors.grey.shade200,
              Colors.grey.shade300,
            ])),
            child: Stack(
              children: [
                Center(
                    child: Container(
                        height: 30.h,
                        child: Image.network(
                          "${m.img}",
                          fit: BoxFit.fill,
                        ))),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Get.back();
                              controller.total_item.value=1;
                            },
                            child: Container(
                                height: 5.h,
                                width: 5.h,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/back.png'),
                                        fit: BoxFit.fill))),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed('cart');
                            },
                            child: Container(
                              height: 6.h,
                              width: 10.w,
                              child: Stack(
                                children: [
                                  Container(
                                    height: 5.h,
                                    width: 5.h,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/cart.png'),
                                          fit: BoxFit.fill),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment(1, -1.3),
                                    child: Container(
                                        height: 2.5.h,
                                        width: 2.5.h,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: Colors.black,
                                            shape: BoxShape.circle),
                                        child: Obx(() => Text(
                                              "${controller.cartList.length}",
                                              style: TextStyle(
                                                  fontSize: 10.sp,
                                                  color: Colors.white),
                                            ))),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () {
                            controller.fav.value=m.like!;
                            if(controller.fav.value==true)
                              {
                                controller.fav.value=false;
                              }
                            else
                              {
                                controller.fav.value=true;
                              }
                            ProductModel model = ProductModel(
                              name: m.name,
                              id: m.id,
                              price: m.price,
                              cate: m.cate,
                              img: m.img,
                              desc: m.desc,
                              like: controller.fav.value,
                            );
                            FirebaseHelper.helper.updateData(model);
                            print('=====view=============${controller.fav}');
                          },
                          child: Container(
                            height: 5.h,
                            width: 5.h,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white70),
                            child: Obx(
                              () => Icon(
                                controller.fav == true
                                    ? Icons.favorite
                                    : Icons.favorite_border_outlined,
                                color: controller.fav == true
                                    ? Colors.amber
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              height: 55.h,
              width: 100.w,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25.sp),
                      topRight: Radius.circular(25.sp))),
              child: Padding(
                padding: EdgeInsets.only(left: 15.sp, top: 10.sp, right: 15.sp),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 12.h,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "${m.name}",
                                    style: TextStyle(
                                        fontSize: 15.sp,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),maxLines: 2,
                                  ),
                                  Text(
                                    "Vado Odelle Dress",
                                    style: TextStyle(
                                        fontSize: 11.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.orange,
                                        size: 14.sp,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: Colors.orange,
                                        size: 14.sp,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: Colors.orange,
                                        size: 14.sp,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: Colors.orange,
                                        size: 14.sp,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: Colors.orange,
                                        size: 14.sp,
                                      ),
                                      Text(
                                        "(320 Review)",
                                        style: TextStyle(
                                          fontSize: 13.sp,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: 12.h,
                            width: 35.w,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  height: 5.h,
                                  width: 31.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15.sp),
                                      color: Colors.grey.shade200),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            if (controller.total_item > 1) {
                                              controller.total_item.value--;
                                            }
                                          },
                                          icon: Icon(
                                            Icons.remove_circle_outline,
                                            size: 20.sp,
                                          )),
                                      Obx(() => Text(
                                            '${controller.total_item}',
                                            style: TextStyle(
                                                fontSize: 15.sp,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          )),
                                      IconButton(
                                          onPressed: () {
                                            if (controller.total_item < 10) {
                                              controller.total_item.value++;
                                            }
                                          },
                                          icon: Icon(
                                            Icons.add_circle_outline,
                                            size: 20.sp,
                                          )),
                                    ],
                                  ),
                                ),
                                Text(
                                  "Avaliable in stok",
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Colors",
                        style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Container(
                        height: 7.h,
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return Container(
                              height: 4.h,
                              width: 4.h,
                              margin: EdgeInsets.only(right: 10),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: controller.colorList[index]),
                            );
                          },
                          itemCount: controller.colorList.length,
                          scrollDirection: Axis.horizontal,
                          physics: NeverScrollableScrollPhysics(),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Description",
                        style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "${m.desc}",
                        style: TextStyle(fontSize: 12.sp, color: Colors.black),
                         maxLines: 7,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Total Price",
                                  style: TextStyle(
                                      fontSize: 12.sp, color: Colors.grey),
                                ),
                                Obx(
                                  () =>  Text(
                                    "₹${(m.price)!*controller.total_item.value}",
                                    style: TextStyle(
                                        fontSize: 15.sp,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                ProductModel model = ProductModel(
                                    id: m.id,
                                    name: m.name,
                                    price: m.price,
                                    cate: m.cate,
                                    img: m.img,
                                    desc: m.desc,
                                    item_count: controller.total_item.value
                                );
                                FirebaseHelper.helper.add_cart_Data(model);
                                Get.snackbar('Successfully', 'your product add to cart',margin: EdgeInsets.all(10.sp));
                                // if(controller.myList.length>1)
                                //   {
                                //     for(int i=0;i<controller.myList.length;i++)
                                //     {
                                //       print("==========${controller.myList[i].name}==${m.name}");
                                //       if(controller.myList[i].name==m.name)
                                //       {
                                //         ProductModel model = ProductModel(
                                //             id: m.id,
                                //             name: m.name,
                                //             price: m.price,
                                //             cate: m.cate,
                                //             img: m.img,
                                //             desc: m.desc,
                                //             item_count: controller.total_item.value+1
                                //         );
                                //         FirebaseHelper.helper.updateCartData(model);
                                //         Get.snackbar('Update', 'already add your cart',margin: EdgeInsets.all(10.sp));
                                //       }
                                //       else
                                //       {
                                //
                                //         ProductModel model = ProductModel(
                                //             id: m.id,
                                //             name: m.name,
                                //             price: m.price,
                                //             cate: m.cate,
                                //             img: m.img,
                                //             desc: m.desc,
                                //             item_count: controller.total_item.value
                                //         );
                                //         FirebaseHelper.helper.add_cart_Data(model);
                                //         Get.snackbar('Successfully', 'your product add to cart',margin: EdgeInsets.all(10.sp));
                                //       }
                                //     }
                                //   }
                                // else
                                //   {
                                //     ProductModel model = ProductModel(
                                //         id: m.id,
                                //         name: m.name,
                                //         price: m.price,
                                //         cate: m.cate,
                                //         img: m.img,
                                //         desc: m.desc,
                                //         item_count: controller.total_item.value
                                //     );
                                //     FirebaseHelper.helper.add_cart_Data(model);
                                //     Get.snackbar('Successfully', 'your product add to cart',margin: EdgeInsets.all(10.sp));
                                //   }


                              },
                              child: Container(
                                height: 6.h,
                                width: 50.w,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.sp),
                                    color: Colors.black),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset('assets/images/bag.png'),
                                    SizedBox(
                                      width: 3.w,
                                    ),
                                    Text(
                                      "Add to cart",
                                      style: TextStyle(
                                          fontSize: 15.sp, color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    ));
  }
}
