import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Alerts{
  static showAlertAndBack( String title, String message) {



    Get.defaultDialog(
        title: '',
        content:
        Container(
          height: 135,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(title,style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              Text(message,style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.normal),),
              Divider(thickness: 1, color: Colors.grey,),
              SizedBox(height: 10,),
              TextButton(
                  onPressed: ()async{
                    Get.back();
                    // Navigator.pop(context);
                  },
                  child: Text("Okay", style: TextStyle(color: Colors.red, fontSize: 18, fontWeight: FontWeight.normal), textAlign: TextAlign.center,))
            ],
          ),
        ),
        radius: 10.0);

    // showDialog(context: context,
    //   builder: (BuildContext c) {
    //     return
    //       Container(
    //       height: 150,
    //       width: 80,
    //       alignment: Alignment.center,
    //       decoration:BoxDecoration(
    //           color: Colors.transparent,
    //           borderRadius: BorderRadius.circular(30)
    //       ),
    //       child: CupertinoAlertDialog(
    //         content: Column(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           crossAxisAlignment: CrossAxisAlignment.center,
    //           children: [
    //             Text(title,style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
    //             SizedBox(height: 10,),
    //             Text(message,style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.normal),),
    //             Divider(thickness: 1, color: Colors.grey,),
    //             SizedBox(height: 10,),
    //             TextButton(
    //                 onPressed: ()async{
    //                   Get.back();
    //                   // Navigator.pop(context);
    //                 },
    //                 child: Text("Okay", style: TextStyle(color: Colors.red, fontSize: 18, fontWeight: FontWeight.normal), textAlign: TextAlign.center,))
    //           ],
    //         ),
    //       ),
    //     );
    //   },
    // );
  }
}