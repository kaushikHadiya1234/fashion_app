import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            "Notification",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: ListView.builder(itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: Container(
                height: 5.h,
                width: 5.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black12,
                  image: DecorationImage(
                    image: NetworkImage("https://cdn.dribbble.com/users/9472246/avatars/normal/136ad2e53211004d2ffb34048c225136.png?1634124897")
                  )
                ),
              ),
              title: Text("App Update"),
              subtitle: Text("These are usually single push notifications sent to update customers about their subscription status, shipping details, or even delivery process."),
            ),
          );
        },
          itemCount: 10,
          physics: BouncingScrollPhysics(),
        ),
      ),
    );
  }
}
