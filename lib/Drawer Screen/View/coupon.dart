import 'package:fashion_app/Dash%20Screen/View/dash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class CouponScreen extends StatefulWidget {
  const CouponScreen({Key? key}) : super(key: key);

  @override
  State<CouponScreen> createState() => _CouponScreenState();
}

class _CouponScreenState extends State<CouponScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          title: Text("My Coupon",style: TextStyle(color: Colors.black),),
          leading:  InkWell(
            onTap: () {
              Get.back();
            },
            child: Container(
                height: 5.h,
                width: 5.h,
                margin: EdgeInsets.all(8.sp),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage('assets/images/back.png'),
                        fit: BoxFit.fill))),
          ),
          backgroundColor: Colors.white,
        ),
        body: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisExtent: 37.h), itemBuilder: (context, index) {
          return Container(
            height: 30.h,
            width: 50.w,
            margin: EdgeInsets.all(5.sp),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.sp),
              border: Border.all(color: Colors.grey.shade200)
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset('${controller.couponList[index].img}'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("${controller.couponList[index].title}",style: TextStyle(color: Colors.grey),),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("${controller.couponList[index].desc}",style: TextStyle(color: Colors.green),),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 5.h,
                    width: 35.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.sp),
                      color: Colors.black
                    ),
                    child: Text("View Coupon",style: TextStyle(fontSize: 12.sp,color: Colors.white,fontWeight: FontWeight.bold),),
                  ),
                )
              ],
            ),
          );
        },
        itemCount: controller.couponList.length,
          physics: BouncingScrollPhysics(),
        ),
      ),
    );
  }
}
