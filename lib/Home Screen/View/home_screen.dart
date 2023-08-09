import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_app/Dash%20Screen/View/dash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../Dash Screen/Model/product_model.dart';
import '../../Utils/firebase_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white60,
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Builder(
              builder: (context) {
                return InkWell(
                  onTap: () {
                    Scaffold.of(context).openDrawer();
                  },
                  child: Container(
                    height: 4.h,
                    width: 4.h,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage(
                              "assets/images/menu.png",
                            ),
                            fit: BoxFit.fill)),
                  ),
                );
              }
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 5.h,
                width: 5.h,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage(
                          "assets/images/pro.png",
                        ),
                        fit: BoxFit.fill)),
              ),
            ),
          ],
          backgroundColor: Colors.white60,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Welcome",style: TextStyle(fontSize: 20.sp,color: Colors.black,fontWeight: FontWeight.bold),),
              Text("Our Fashions App",style: TextStyle(fontSize: 14.sp,color: Colors.grey,fontWeight: FontWeight.bold),),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child : InkWell(
                      onTap: () {
                        Get.toNamed('search');
                      },
                      child: Container(
                        height: 7.h,
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.sp),
                          border: Border.all(color: Colors.grey)
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(10.sp),
                          child: Row(
                            children: [
                              Icon(Icons.search,color: Colors.grey,),
                              SizedBox(width: 10.sp,),
                              Text("Search...",style: TextStyle(fontSize: 13.sp,color: Colors.grey),)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 6.h,
                    width: 6.h,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage("assets/images/filtter.png"),fit: BoxFit.fill
                      )
                    ),
                  )
                ],
              ),
              SizedBox(height: 10),
              Text("Category",style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.bold,color: Colors.black),),
              SizedBox(height: 10),
             SizedBox(
               height: 5.h,
               child: ListView.builder(itemBuilder: (context, index) {
                 return  Container(
                   height: 6.h,
                   width: 20.w,
                   margin: EdgeInsets.all(5),
                   alignment: Alignment.center,
                   decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(5.sp),
                       color: Colors.black
                   ),
                   child: Text("Phone",style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.bold,color: Colors.white,),),
                 );
               },itemCount: 10,scrollDirection: Axis.horizontal,),
             ),
              Expanded(child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: StreamBuilder(
                  stream: FirebaseHelper.helper.readProductData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text("${snapshot.error}"),
                      );
                    }
                    else if (snapshot.hasData) {
                      QuerySnapshot<Map<String, dynamic>>? qs = snapshot.data;
                      List qsList = qs!.docs;
                      List<ProductModel> productList = [];
                      controller.favoriteList.clear();
                      // List catList = [];

                      // for(int i=0;i<productList.length;i++)
                      //   {
                      //     catList.add(productList.);
                      //     print("================${catList.length}");
                      //   }

                      for (var x in qsList) {
                        Map m1 = x.data();
                        String? id = x.id;
                        String? name = m1['name'];
                        int? price = m1['price'];
                        String? category = m1['category'];
                        String? image = m1['image'];
                        String? desc = m1['desc'];
                        bool? like = m1['like'];
                        int? item_no = m1['item_count'];
                        ProductModel m = ProductModel(
                            name: name,
                            price: price,
                            cate: category,
                            img: image,id: id,
                            desc: desc,
                          like: like,
                          item_count: item_no
                        );
                        if(like==true)
                        {
                            controller.favoriteList.add(m);
                        }
                        productList.add(m);
                        controller.cartList.value = productList;
                        print(controller.cartList.length);
                      }
                      return GridView.builder(
                        physics: BouncingScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,mainAxisExtent: 35.h),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              ProductModel m = ProductModel(
                                 name: productList[index].name,
                                 img: productList[index].img,
                                 price: productList[index].price,
                                 cate: productList[index].cate,
                                desc: productList[index].desc,
                                like: productList[index].like,
                                item_count: 1, id: productList[index].id
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
                                          image: NetworkImage("${productList[index].img}")
                                      ),
                                      color: Colors.grey.shade100),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          ProductModel model =ProductModel(
                                            name: productList[index].name,
                                            id: productList[index].id,
                                            price: productList[index].price,
                                            cate: productList[index].cate,
                                            img: productList[index].img,
                                            desc: productList[index].desc,
                                            like: productList[index].like==false?true:false,
                                          );
                                          FirebaseHelper.helper.updateData(model);
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
                                            productList[index].like==true?Icons.favorite:Icons.favorite_border_outlined,
                                              color: productList[index].like==true?Colors.amber.shade700:Colors.black,
                                            ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:  EdgeInsets.symmetric(horizontal: 20.sp),
                                  child: Text(
                                    "${productList[index].name}",
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.bold),maxLines: 1,
                                  ),
                                ),
                                Padding(
                                  padding:  EdgeInsets.symmetric(horizontal: 20.sp),
                                  child: Text(
                                    "${productList[index].desc}",
                                    style: TextStyle(
                                        fontSize: 10.sp,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w500),maxLines: 1,
                                  ),
                                ),
                                Text(
                                  "₹${productList[index].price}",
                                  style: TextStyle(
                                      fontSize: 13.sp,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          );
                        },
                        itemCount: productList.length,
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ))
            ],
          ),
        ),
        drawer: Drawer(
          width: 60.w,
          child:Column(
            children: [
              InkWell(
                onTap: () {
                  Get.toNamed('profile');
                },
                child: ListTile(
                  leading: Container(
                    height: 6.h,
                    width: 6.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.sp),
                      color: Colors.grey.shade200,
                    ),
                    child: Icon(Icons.person),
                  ),
                  title: Text("Profile",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13.sp,color: Colors.black),),
                  trailing: Icon(Icons.arrow_forward_ios,size: 15.sp,),
                ),
              ),
              ListTile(
                leading: Container(
                  height: 6.h,
                  width: 6.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.sp),
                    color: Colors.grey.shade200,
                  ),
                  child: Icon(Icons.language),
                ),
                title: Text("Language",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13.sp,color: Colors.black),),
                trailing: Icon(Icons.arrow_forward_ios,size: 15.sp,),
              ),
              ListTile(
                leading: Container(
                  height: 6.h,
                  width: 6.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.sp),
                    color: Colors.grey.shade200,
                  ),
                  child: Icon(Icons.settings),
                ),
                title: Text("Setting",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13.sp,color: Colors.black),),
                trailing: Icon(Icons.arrow_forward_ios,size: 15.sp,),
              ),
              ListTile(
                leading: Container(
                  height: 6.h,
                  width: 6.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.sp),
                    color: Colors.grey.shade200,
                  ),
                  child: Icon(Icons.credit_card_outlined),
                ),
                title: Text("My card",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13.sp,color: Colors.black),),
                trailing: Icon(Icons.arrow_forward_ios,size: 15.sp,),
              ),
              InkWell(
                onTap: () {
                  Get.toNamed('coupon');
                },
                child: ListTile(
                  leading: Container(
                    height: 6.h,
                    width: 6.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.sp),
                      color: Colors.grey.shade200,
                    ),
                    child: Icon(Icons.discount_outlined),
                  ),
                  title: Text("My Coupon",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13.sp,color: Colors.black),),
                  trailing: Icon(Icons.arrow_forward_ios,size: 15.sp,),
                ),
              ),
              ListTile(
                onTap: () {
                  FirebaseHelper.helper.logOut();
                  Get.snackbar('Successfully Logout', '',
                      margin: EdgeInsets.all(10));
                  Get.offAllNamed("signin");
                },
                leading: Container(
                  height: 6.h,
                  width: 6.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.sp),
                    color: Colors.grey.shade200,
                  ),
                  child: Icon(Icons.logout),
                ),
                title: Text("Log Out",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13.sp,color: Colors.red),),
                trailing: Icon(Icons.arrow_forward_ios,size: 15.sp,),
              )
            ],
          ),
        ),
      ),
    );
  }
}
