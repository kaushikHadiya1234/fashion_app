import 'package:fashion_app/Dash%20Screen/Model/product_model.dart';
import 'package:fashion_app/Dash%20Screen/View/dash_screen.dart';
import 'package:fashion_app/Utils/firebase_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({Key? key}) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {

  TextEditingController txtstreet =TextEditingController();
  TextEditingController txtcity =TextEditingController();
  TextEditingController txtstate =TextEditingController();
  TextEditingController txtzipcod =TextEditingController();
  TextEditingController txtcno =TextEditingController();

  var txtkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Form(
      key: txtkey,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Add your Address Details",style: TextStyle(fontSize: 15.sp,color: Colors.black),),
          centerTitle: true,
          backgroundColor: Colors.white,
          leading:   InkWell(
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
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10.sp),
              buildPadding(hint: "Enter your Street..",contro: txtstreet,keybordtype: TextInputType.text),
              buildPadding(hint: "Enter your City..",contro: txtcity,keybordtype: TextInputType.text),
              buildPadding(hint: "Enter your State..",contro: txtstate,keybordtype: TextInputType.text),
              buildPadding(hint: "Enter your Zip cod..",contro: txtzipcod,keybordtype: TextInputType.number),
              buildPadding(hint: "Enter your contact no..",preicon: Padding(
                padding:  EdgeInsets.symmetric(horizontal: 8.0,vertical: 15.sp),
                child: Text("91+ |",style: TextStyle(fontSize: 12.sp,color: Colors.grey),),
              ),contro: txtcno,keybordtype: TextInputType.phone),
              SizedBox(height: 10.h,),
              InkWell(
                onTap: () {
                 if(txtkey.currentState!.validate())
                   {
                     AddressModel m = AddressModel(
                         street: txtstreet.text,
                         city: txtcity.text,
                         state: txtstate.text,
                         zipcod: txtzipcod.text,
                         cno: txtcno.text,
                     );
                     FirebaseHelper.helper.add_address_Data(m);
                     print('==================${m.street}');
                     // controller.addressDone.value=true;
                     Get.toNamed('review',arguments: m);
                   }
                },
                child: Container(
                  height: 5.h,
                  width: 30.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.sp),
                    color: Colors.black
                  ),
                  child: Text("Next",style: TextStyle(fontSize: 15.sp,color: Colors.white,fontWeight: FontWeight.bold),),
                ),
              )
            ],
          ),
        ),
      ),
    ),);
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
                borderRadius: BorderRadius.circular(20.sp),
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.sp),
                borderSide: BorderSide(color: Colors.grey),
              ),
              hintText: "$hint",
                prefixIcon: preicon
            ),
          ),
        );
  }
}
