import 'dart:math';

import 'package:flutter/material.dart';
import 'package:news/models/get_splash_screen_image.dart';

class CustomDialog extends StatelessWidget {
  final List<FlashData>? flashDataList;
  final String? imagePath;

  const CustomDialog({required this.flashDataList, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    // return AlertDialog (
    //   actionsPadding: const EdgeInsets.all(0.0),
    //   titlePadding: const EdgeInsets.all(0.0),
    //   contentPadding: const EdgeInsets.all(0.0),
    //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
    //   elevation: 0.0,
    //   backgroundColor: Colors.transparent,
    //   content: dialogContent(context),
    // );

    return Container(
      alignment: Alignment.center,
      // actionsPadding: const EdgeInsets.all(0.0),
      // titlePadding: const EdgeInsets.all(0.0),
      // contentPadding: const EdgeInsets.all(0.0),
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      // elevation: 0.0,
      // backgroundColor: Colors.transparent,

      width: MediaQuery.of(context).size.width - 10,
      height: MediaQuery.of(context).size.height - 80,
      padding: EdgeInsets.only(left: 20, right: 8, top: 8, bottom: 20),
      child: dialogContent(context),
    );
  }

  int random(min, max) {
    return min + Random().nextInt(max - min);
  }

  Widget dialogContent(BuildContext context) {
    print(
        "random(0, flashDataList!.length) ${random(0, flashDataList!.length)}");
    return Container(
      margin: EdgeInsets.only(left: 0.0, right: 0.0),
      child: Stack(
        children: <Widget>[
          Container(
            // padding: EdgeInsets.only(
            //   top: 18.0,
            // ),
            margin: EdgeInsets.only(top: 20.0, right: 20.0),
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 0.0,
                    offset: Offset(0.0, 0.0),
                  ),
                ]),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              //  crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // SizedBox(
                //   height: 20.0,
                // ),
                Container(
                  height: 300,
                  //  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16.0),
                        topRight: Radius.circular(16.0),
                        bottomLeft: Radius.circular(16.0),
                        bottomRight: Radius.circular(16.0),
                      ),
                      image: DecorationImage(
                          image: NetworkImage(imagePath! +
                              flashDataList![random(0, flashDataList!.length)]
                                  .flashImg!),
                          //AssetImage("assets/img/placeholder.jpg"),

                          // articles[index].img! == null
                          //     ? AssetImage("aseets/img/placeholder.jpg")
                          //     : NetworkImage(articles[index].img!),

                          fit: BoxFit.fill)),
                ),
                // Center(
                //     child: Padding(
                //       padding: const EdgeInsets.all(10.0),
                //       child: new Text("Sorry please try \n again tomorrow", style:TextStyle(fontSize: 30.0,color: Colors.white)),
                //     )//
                // ),
                // SizedBox(height: 24.0),
                // InkWell(
                //   child: Container(
                //     padding: EdgeInsets.only(top: 15.0,bottom:15.0),
                //     decoration: BoxDecoration(
                //       color:Colors.white,
                //       borderRadius: BorderRadius.only(
                //           bottomLeft: Radius.circular(16.0),
                //           bottomRight: Radius.circular(16.0)),
                //     ),
                //     child:  Text(
                //       "OK",
                //       style: TextStyle(color: Colors.blue,fontSize: 25.0),
                //       textAlign: TextAlign.center,
                //     ),
                //   ),
                //   onTap:(){
                //     Navigator.pop(context);
                //   },
                // )
              ],
            ),
          ),
          Positioned(
            right: 3.0,
            top: 3.0,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Align(
                alignment: Alignment.topRight,
                child: Container(
                  height: 40,
                  width: 40,

                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all()),
                  // radius: 14.0,
                  // backgroundColor: Colors.white,
                  child: Icon(Icons.close, color: Colors.red),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
