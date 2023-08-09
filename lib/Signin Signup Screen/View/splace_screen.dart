import 'dart:async';

import 'package:fashion_app/Utils/firebase_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class SplaceScreen extends StatefulWidget {
  const SplaceScreen({Key? key}) : super(key: key);

  @override
  State<SplaceScreen> createState() => _SplaceScreenState();
}

class _SplaceScreenState extends State<SplaceScreen> {
  bool? islogin;
  @override
  void initState() {
    super.initState();
    islogin =  FirebaseHelper.helper.checkuser();
  }

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 3), () =>islogin==true?Get.offAllNamed('dash'):Get.offAllNamed('signin'));
    return SafeArea(child: Scaffold(
      body: Center(
        child: Image.asset('assets/images/splace.png',height: 30.h,),
      ),
    ),);
  }
}