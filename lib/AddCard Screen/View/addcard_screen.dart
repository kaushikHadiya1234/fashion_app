import 'package:fashion_app/Utils/payment/razerpay.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../Utils/firebase_helper.dart';

class AddCardScreen extends StatefulWidget {
  const AddCardScreen({Key? key}) : super(key: key);

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {

  TextEditingController txtcardno = TextEditingController();
  TextEditingController txtexpdate = TextEditingController();
  TextEditingController txtcvv = TextEditingController();

  var  txtkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Form(
        key: txtkey,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading: InkWell(
              onTap: () {
                Get.back();
              },
              child: Container(
                  height: 5.h,
                  width: 5.h,
                  margin: EdgeInsets.all(7.sp),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage('assets/images/back.png'),
                          fit: BoxFit.fill))),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 10.sp),
                  child: Text("Payment",style: TextStyle(fontSize: 18.sp,color: Colors.black,fontWeight: FontWeight.bold),),
                ),
                Container(
                  height: 25.h,
                    width: 120.w,
                    child: Image.asset('assets/images/card.png',fit: BoxFit.cover,)),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 10.sp),
                  child: Text("Card Details",style: TextStyle(fontSize: 16.sp,color: Colors.black,fontWeight: FontWeight.bold),),
                ),
                buildPadding(hint: "Enter Card no",contro: txtcardno,keybordtype: TextInputType.number),
                buildPadding(hint: "Enter Exp date",contro: txtexpdate,keybordtype: TextInputType.number),
                buildPadding(hint: "cvv",contro: txtcvv,keybordtype: TextInputType.number),
                Padding(
                  padding: EdgeInsets.all(10.sp),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(onPressed: () {

                      }, child: Text("Cancel",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15.sp,color: Colors.grey),)),
                      InkWell(
                        onTap: () {
                          if(txtkey.currentState!.validate())
                            {
                              showDialog(context: context, builder: (context) {

                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(20.sp))),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        height: 7.h,
                                        width: 7.h,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            image: AssetImage("assets/images/ic.png"),
                                            fit: BoxFit.cover,
                                          )
                                        ),
                                      ),
                                      SizedBox(height: 10.sp,),
                                      Text("Successfully!",style: TextStyle(fontSize: 18.sp,color: Colors.black,fontWeight: FontWeight.bold),),
                                      SizedBox(height: 10.sp,),
                                      Text("you have successfully add card",style: TextStyle(fontSize: 15.sp,color: Colors.grey),),
                                      SizedBox(height: 10.sp,),
                                      InkWell(
                                        onTap: () {
                                          FirebaseHelper.helper.deleteallCartData();
                                          PaymentHelper.payment.setPayment(10);
                                        },
                                        child: Container(
                                          height: 6.5.h,
                                          width: 60.w,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20.sp),color:Colors.black
                                          ),
                                          child: Text("Continue Shopping",style: TextStyle(
                                              fontSize: 15.sp,color: Colors.white,fontWeight: FontWeight.bold
                                          ),),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },);
                            }
                        },
                        child: Container(
                          height: 6.h,
                          width: 30.w,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.sp),color:Colors.black
                          ),
                          child: Text("Conform",style: TextStyle(
                            fontSize: 15.sp,color: Colors.white,fontWeight: FontWeight.bold
                          ),),
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
    );
  }

  Padding buildPadding({contro,hint,preicon,keybordtype}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        validator: (value) {
          if(value!.isEmpty)
          {
            return "Enter the this Detail";
          }
        },
        keyboardType: keybordtype,
        textInputAction: TextInputAction.next,
        controller: contro,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.sp),
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.sp),
              borderSide: BorderSide(color: Colors.grey),
            ),
            hintText: "$hint",
            prefixIcon: preicon
        ),
      ),
    );
  }

}
