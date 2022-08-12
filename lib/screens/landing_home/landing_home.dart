import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/style.dart' as Style;
import 'package:get/get.dart';
import 'package:news/screens/category_details/category_details_controller.dart';
import 'package:news/screens/tabs/e_paper_screen.dart';
import 'package:news/screens/tabs/home_screen.dart';

import 'home_controller.dart';

class LandingHome extends StatefulWidget {
  const LandingHome({Key? key}) : super(key: key);

  @override
  State<LandingHome> createState() => _LandingHomeState();
}

class _LandingHomeState extends State<LandingHome> {



  final categoryDetailsController = Get.put(CategoryDetailsController(
      apiRepositoryInterface: Get.find(), categoryId: ''));
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(apiRepositoryInterface: Get.find(),context: context),
        builder: (homeController) {
          return Scaffold(
            //appBar: appBar(homeController),
            body: body(homeController),
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.black38, spreadRadius: 0, blurRadius: 10),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0)),
                child: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  onTap: homeController.changeTabIndex,
                  currentIndex: homeController.tabIndex,
                  items: [
                    BottomNavigationBarItem(
                      icon: Icon(CupertinoIcons.home),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(CupertinoIcons.square_grid_2x2_fill),
                      label: 'E-Peper',
                    ),
                    // BottomNavigationBarItem(
                    //   // icon: Icon(CupertinoIcons.cart, color: Style.Colors.appColor),
                    //   icon: Icon(CupertinoIcons.search),
                    //   label: 'Search',
                    // ),
                  ],
                  selectedItemColor: Colors.red,
                  unselectedItemColor: Colors.grey,
                  unselectedIconTheme: const IconThemeData(size: 30),
                  selectedIconTheme: const IconThemeData(size: 34),
                ),
              ),
            ),
          );
        });
  }

  appBar(HomeController homeController) {
    if (homeController.tabIndex == 0) {

      return Image.asset(
        'assets/logos/app_logo.png',
      );
      return AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Container(
            height: 100,
            width: 100,
            child: Image.asset(
              'assets/logos/app_logo.png',
            )),
        // actions: [
        //   // IconButton(
        //   //   onPressed: () {},
        //   //   icon: Icon(Icons.notifications_none),
        //   //   color: Style.Colors.appColor,
        //   // ),
        //   // IconButton(
        //   //     onPressed: () {},
        //   //     icon: Icon(Icons.favorite_border),
        //   //     color: Style.Colors.appColor),
        //   IconButton(
        //       onPressed: () async {
        //         Get.defaultDialog(
        //           title: "Logout?",
        //           barrierDismissible: false,
        //           middleText: "Are you sure you want to logout from this App?",
        //           titleStyle: TextStyle(color: Colors.black),
        //           middleTextStyle: TextStyle(color: Colors.black),
        //           confirm: Row(
        //             mainAxisAlignment: MainAxisAlignment.spaceAround,
        //             children: [
        //               TextButton(
        //                 // style: flatButtonStyle,
        //                 onPressed: () {
        //                   Get.back();
        //                 },
        //                 child: Text(
        //                   "Cancel",
        //                   style: TextStyle(color: Style.Colors.appColor),
        //                 ),
        //               ),
        //               TextButton(
        //                 // style: flatButtonStyle,
        //                 onPressed: () {
        //                   // homeController.logout();
        //                 },
        //                 child: Text(
        //                   "OK",
        //                   style: TextStyle(color: Style.Colors.appColor),
        //                 ),
        //               )
        //             ],
        //           ),
        //           // cancel: Text("Cancel"),
        //           // custom: Text("djdn",style: TextStyle(color: Style.Colors.appColor),)
        //         );
        //         // homeController.logout();
        //         // ShowAlertDialog.showAlertLogoutConfirm(context,"Logout?","Are you sure you want to logout from this App?",homeController);
        //       },
        //       icon: Icon(
        //         Icons.error,
        //         size: 30,
        //       ),
        //       color: Color(0xFFFC7663))
        // ],
      );
    }else  if (homeController.tabIndex == 0) {
      return null;
    }

    // else  if (homeController.tabIndex == 0) {
    //   return null;
    // }

  }

  body(HomeController homeController) {
    return PageView(
      //  physics: NeverScrollableScrollPhysics(),
      controller: homeController.pageController,
      onPageChanged: (pageIndex) {
        homeController.changeTabIndex(pageIndex);
      },
      children: [HomeScreen(), const EPaperScreen()],
    );
  }

}

