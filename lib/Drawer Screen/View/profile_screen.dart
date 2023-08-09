import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../Dash Screen/View/dash_screen.dart';
import '../../Utils/firebase_helper.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  void initState() {
    controller.userDatails.value= FirebaseHelper.helper.userDetaile();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body:controller.userDatails['photo'] != null && controller.userDatails['email'] != null&& controller.userDatails['phone'] != null && controller.userDatails['name'] != null? Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: 3.h,
            ),
            controller.userDatails['photo'] != null ?
            CircleAvatar(
              radius: 50.sp,
              backgroundImage:
              NetworkImage("${controller.userDatails['photo']}"),
            )
                : Container(
              height: 50.h,
              width: 50.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.person,size: 50.sp,),
            ),
            SizedBox(
              height: 2.h,
            ),
            Container(
              height: controller.userDatails['name'] != null?18.sp:0,
              child: Text(
                controller.userDatails['name'] != null
                    ? "${controller.userDatails['name']}"
                    : "",
                style:
                TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Container(
              height: controller.userDatails['phone'] != null?18.sp:0,
              child: Text(
                controller.userDatails['phone'] != null
                    ? "${controller.userDatails['phone']}"
                    : "",
                style:
                TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: controller.userDatails['email'] != null?18.sp:0,
              alignment: Alignment.center,
              child: Text(
                controller.userDatails['email'] != null
                    ? "${controller.userDatails['email']}"
                    : "",
                style:
                TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ):Center(child: Text("Data not found",style: TextStyle(fontSize: 15.sp,color: Colors.grey),)),
    ));
  }
}
