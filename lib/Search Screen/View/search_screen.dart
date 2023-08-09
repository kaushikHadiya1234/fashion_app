import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../Dash Screen/View/dash_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  TextEditingController txtsearch = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: txtsearch,
                onChanged: (value) {
                  controller.filterSearchData(value);
                },
                autofocus: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.sp),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.sp),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  hintText: "Search...",
                  prefixIcon: Icon(Icons.search)
                ),
              ),
            ),
            Obx(
              () =>  Expanded(
                child: ListView.builder(itemBuilder: (context, index) {
                  return Container(
                    height: 13.h,
                    width: 100.w,
                    margin: EdgeInsets.all(5.sp),
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
                                    image: NetworkImage("${controller.searchList[index].img}")
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
                                Text("${controller.searchList[index].name}",style: TextStyle(fontSize: 14.sp,color: Colors.black,fontWeight: FontWeight.bold),maxLines: 1,),
                                Text("${controller.searchList[index].desc}",style: TextStyle(fontSize: 11.sp,color: Colors.grey,fontWeight: FontWeight.bold),maxLines: 1,),
                                Text("₹${(controller.searchList[index].price!)}",style: TextStyle(fontSize: 14.sp,color: Colors.black,fontWeight: FontWeight.bold))
                              ],
                            ),
                          ),
                        ),),
                      ],
                    ),
                  );
                },itemCount: controller.searchList.length,
                  physics: BouncingScrollPhysics(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
