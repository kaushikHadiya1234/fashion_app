import 'package:fashion_app/Utils/firebase_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController txtemail = TextEditingController();
  TextEditingController txtpassword = TextEditingController();

  var txtkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(alignment: Alignment.center,child: Image.asset('assets/images/fashion.png',width: 80.w,)),
                Text("Welcome!",style: TextStyle(fontSize: 15.sp,color: Colors.black,fontWeight: FontWeight.bold),),
                SizedBox(height: 10.sp),
                Text("Please login and signup to continue Our app",style: TextStyle(fontSize: 12.sp,color: Colors.black),),
                SizedBox(height: 25.sp),
               TextFormField(
                    controller: txtemail,
                    validator: (value) {
                     if(value!.isEmpty)
                       {
                         return "Enter the email";
                       }
                     if(value.isEmail)
                       {
                       }
                     else{
                       return "Enter the valid Email ";
                     }

                    },
                    onChanged: (value) {
                     setState(() {
                       value=txtemail.text;
                     });
                    },
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.sp),
                            borderSide: BorderSide(color: Colors.grey)
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.sp),
                            borderSide: BorderSide(color: Colors.grey)
                        ),
                      label: Text("Email",style: TextStyle(fontSize: 13.sp,color: Colors.black,fontWeight: FontWeight.bold),),
                      suffixIcon: Visibility(visible: txtemail.text.isEmail,
                          child: Icon(Icons.cloud_done_rounded,color: Colors.black,))
                    ),
                  ),
                SizedBox(height: 20.sp),
                TextFormField(
                  controller: txtpassword,
                  validator: (value) {
                    if(value!.isEmpty)
                      {
                        return "Enter the password";
                      }
                    if(value.length>=8)
                      {
                        return "Password enter attlist 8 digit";
                      }
                  },
                  onChanged: (value) {
                    setState(() {
                      value=txtpassword.text;
                    });
                  },
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.sp),
                          borderSide: BorderSide(color: Colors.grey)
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.sp),
                          borderSide: BorderSide(color: Colors.grey)
                      ),
                      suffixIcon: Visibility(visible: txtpassword.text.length>=8,
                          child: Icon(Icons.cloud_done_rounded,color: Colors.black,)),
                    label: Text("Password",style: TextStyle(fontSize: 13.sp,color: Colors.black,fontWeight: FontWeight.bold),),
                  ),
                ),
                SizedBox(height: 30.sp),
                InkWell(
                  onTap: () async {
                    if(txtkey.currentState!.validate())
                    {
                      String? msg = await FirebaseHelper.helper.signIn(txtemail.text, txtpassword.text);

                      if(msg=="Success")
                      {
                        Get.offAllNamed('dash');
                        Get.snackbar('Success', 'Please quick login',
                            margin: EdgeInsets.all(10),
                            backgroundColor: Colors.red.shade100);
                      }
                      else
                      {
                        Get.snackbar('Wrong', 'Please check Email and Password',
                            margin: EdgeInsets.all(10),
                            backgroundColor: Colors.red.shade100);
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
                      child: Text("Login",style: TextStyle(fontSize: 15.sp,color: Colors.white,fontWeight: FontWeight.bold),),
                    ),
                  ),
                ),
                SizedBox(height: 20.sp),
                Container(alignment: Alignment.center,child: Text("or",style: TextStyle(fontSize: 12.sp,color: Colors.black),)),
                SizedBox(height: 25.sp),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () async {
                        String msg = await FirebaseHelper.helper.googleSignIn();

                        Get.snackbar('Success', 'Welcome to your app',margin: EdgeInsets.all(10));
                        if(msg=="Success")
                        {
                          print('=================');
                          Get.offAllNamed('dash');
                        }
                      },
                      child: Container(
                        height: 5.5.h,
                        width: 30.w,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.sp),
                          border: Border.all(color: Colors.black),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 5,

                              )
                            ]
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset('assets/images/g.png',height: 3.5.h),
                            Text("Google",style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.bold),)
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        String? msg=await FirebaseHelper.helper.SignInGuest();
                        print('=================$msg');

                        if(msg=="Success")
                        {
                          Get.offAllNamed('dash');
                          Get.snackbar('Success', 'Welcome to your app',margin: EdgeInsets.all(10));
                        }
                        else
                        {
                          Get.snackbar('Failed', 'Please try again',margin: EdgeInsets.all(10));
                        }
                      },
                      child: Container(
                        height: 5.5.h,
                        width: 30.w,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.sp),
                          border: Border.all(color: Colors.black),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 5,

                            )
                          ]
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(Icons.person,size: 20.sp,),
                            Text("Guest",style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.bold),)
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 25.sp),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Don’t have an account?',style: TextStyle(fontSize: 11.sp,color: Color(0xff000000)),),
                    SizedBox(width: 5),
                    InkWell(
                        onTap: () {
                          Get.toNamed('signup');
                        },
                        child: Text('Sign Up',style: TextStyle(fontSize: 12.sp,color: Colors.black,fontWeight: FontWeight.bold),))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
