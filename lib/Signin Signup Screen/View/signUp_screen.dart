import 'package:fashion_app/Utils/firebase_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  TextEditingController txtname = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtpassword = TextEditingController();
  TextEditingController txtcpassword = TextEditingController();

  var txtkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Form(
      key: txtkey,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(alignment: Alignment.center,child: Image.asset('assets/images/fashion.png',width: 80.w,)),
                Text("Sign Up",style: TextStyle(fontSize: 15.sp,color: Colors.black,fontWeight: FontWeight.bold),),
                SizedBox(height: 10.sp),
                Text("Please Create new account",style: TextStyle(fontSize: 12.sp,color: Colors.black),),
                SizedBox(height: 25.sp),
                buildtextfiled(label: 'Username',contro: txtname,hide: false,hint: 'username'),
                SizedBox(height: 10.sp),
                buildtextfiled(label: 'Email',contro: txtEmail,hide: false,hint: 'Email'),
                SizedBox(height: 10.sp),
                buildtextfiled(label: 'Password',contro: txtpassword,hide: true,hint: 'Password'),
                SizedBox(height: 10.sp),
                buildtextfiled(label: 'Conform Password',contro: txtcpassword,hide: true,hint: 'cPassword'),
                SizedBox(height: 30.sp),
                InkWell(
                  onTap: () async {
                    if (txtkey.currentState!.validate()) {
                      String? msg = await FirebaseHelper.helper
                          .signUp(txtEmail.text, txtpassword.text);
                      if (msg == "Success") {
                        print('================================');
                        Get.snackbar('Success', 'Please quick login',
                            margin: EdgeInsets.all(10),
                            backgroundColor: Colors.red.shade100);
                        Get.offAllNamed('/');
                      }
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: Container(
                      height: 6.h,
                      width: 90.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.sp),
                          color: Colors.black
                      ),
                      child: Text("Sign Up",style: TextStyle(fontSize: 15.sp,color: Colors.white,fontWeight: FontWeight.bold),),
                    ),
                  ),
                ),
                SizedBox(height: 25.sp),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('You have already account?',style: TextStyle(fontSize: 11.sp,color: Color(0xff000000)),),
                    SizedBox(width: 5),
                    InkWell(
                        onTap: () {
                          Get.toNamed('/');
                        },
                        child: Text('Sign In',style: TextStyle(fontSize: 12.sp,color: Colors.black,fontWeight: FontWeight.bold),))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ),);
  }

  Widget buildtextfiled({label, contro, hide, hint}) {
    return TextFormField(
      validator: (value) {
        if (hint == "username") {
          if (value!.isEmpty) {
            return "Enter the user name";
          }
        } else if (hint == "Email") {
          if (value!.isEmpty) {
            return "Enter the Email";
          } else if (value.isEmail) {} else {
            return "Enter the valid Email";
          }
        } else if (hint == "Password") {
          if (value!.isEmpty) {
            return "Enter the Password";
          } else if (value.length < 8) {
            return "Enter the atlist 8 digit password";
          }
        } else if (hint == "cPassword") {
          if (value!.isEmpty) {
            return "Enter the conform Password";
          } else if (value != txtpassword.text) {
            return "Enter the same password";
          }
        }
      },
      obscureText: hide,
      controller: contro,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.sp),
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.sp),
            borderSide: BorderSide(color: Colors.grey),
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.sp),
              borderSide: BorderSide(color: Colors.grey)),
          label: Text("$label",style: TextStyle(fontSize: 13.sp,fontWeight: FontWeight.bold,color: Colors.black),)),
    );
  }
}
