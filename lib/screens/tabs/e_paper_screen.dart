// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:news/models/article.dart';
// import 'package:news/models/source.dart';
// import 'package:news/screens/news_details/e_paper_details_screen.dart';
// import 'package:news/screens/news_details/source_detail.dart';
// import 'package:news/screens/landing_home/home_controller.dart';
// import 'package:news/style/theme.dart' as Style;
// import 'package:timeago/timeago.dart' as timeago;
//
// class EPaperScreen extends StatefulWidget {
//   const EPaperScreen({Key? key}) : super(key: key);
//
//   @override
//   _EPaperScreenState createState() => _EPaperScreenState();
// }
//
// class _EPaperScreenState extends State<EPaperScreen> {
//   @override
//   Widget build(BuildContext context) {
//     final homeController = Get.find<HomeController>();
//
//     return Scaffold(
//       body: Column(
//         children: [
//
//           Obx(() {
//             if (homeController.isLoadingGetCategory.value != true) {
//               return _buildSourcesWidget(homeController.getCategoryList);
//             } else {
//               return const Center(
//                 child: CircularProgressIndicator(),
//               );
//             }
//           }),
//
//           // HotNewsWidget()
//         ],
//       ),
//     );
//   }
//
//   Widget _buildSourcesWidget(List<SourceModel> sources) {
//     if (sources.length == 0) {
//       return Container(
//         width: MediaQuery.of(context).size.width,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: <Widget>[
//             Column(
//               children: <Widget>[
//                 Text(
//                   "No More Sources",
//                   style: TextStyle(color: Colors.black45),
//                 )
//               ],
//             )
//           ],
//         ),
//       );
//     } else
//       return Expanded(
//         child: GridView.builder(
//           shrinkWrap: true,
//           itemCount: sources.length,
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 3, childAspectRatio: 0.86),
//           itemBuilder: (context, index) {
//             return Padding(
//               padding: const EdgeInsets.only(left: 5.0, right: 5.0, top: 10.0),
//               child: GestureDetector(
//                 onTap: () {
//
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => EPaperDetailsScreeen(
//
//                           )));
//                 },
//                 child: Card(
//                   child: Container(
//                     width: 100.0,
//                     decoration: BoxDecoration(
//                       // color: Style.Colors.background,
//                       borderRadius: BorderRadius.all(Radius.circular(5.0)),
//                       // boxShadow: [
//                       //   BoxShadow(
//                       //     color: Colors.white,
//                       //     blurRadius: 1,
//                       //     spreadRadius: 1.0,
//                       //     offset: Offset(
//                       //       1.0,
//                       //       1.0,
//                       //     ),
//                       //   )
//                       // ],
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//                         Hero(
//                           tag: sources[index].id!,
//                           child: Container(
//                             height: 40,
//                             width: 40,
//                             decoration: BoxDecoration(
//                                 image: DecorationImage(
//                                     image: AssetImage(
//                                         "assets/logos/${sources[index].id}.png"),
//                                     fit: BoxFit.fill)),
//                           ),
//                         ),
//                         Container(
//                           padding: EdgeInsets.only(
//                               left: 10.0, right: 10.0, top: 15.0, bottom: 15.0),
//                           child: Text(
//                             sources[index].name!,
//                             textAlign: TextAlign.center,
//                             maxLines: 2,
//                             style: TextStyle(
//                                 color: Style.Colors.titleColor,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 12.0),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:news/constants/app_costants.dart';
import 'package:news/models/get_e_paper.dart';
import 'package:news/routes/navigation.dart';
import 'package:news/screens/landing_home/home_controller.dart';
import 'package:news/style/theme.dart' as Style;
import 'package:news/utils/alerts.dart';
import 'package:news/utils/check_internet.dart';
import 'package:timeago/timeago.dart' as timeago;

class EPaperScreen extends StatefulWidget {
  const EPaperScreen({Key? key}) : super(key: key);

  @override
  State<EPaperScreen> createState() => _EPaperScreenState();
}

class _EPaperScreenState extends State<EPaperScreen> {
  final homeController = Get.find<HomeController>();
  DateTime selectedDate = DateTime.now();
  String? date = "";

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: selectedDate,
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        final DateFormat formatter = DateFormat('dd-MM-yyyy');
        date = formatter.format(picked);
        // selectedDate = picked;
        homeController.getEPaper(date!, false);
        print("selectedDate $date");
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    // CheckInternet.checkInternet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(homeController),
        body: RefreshIndicator(
          color: Style.Colors.appColor,
          // color: Colors.red,
          onRefresh: () {
            print("onRefresh $date");
            CheckInternet.checkInternet();
            return homeController.getEPaper(date!, true);
          },
          child: body(),
        ));
  }

  appBar(HomeController homeController) {
    return AppBar(
      backgroundColor: Colors.white,
      title: Text(
        "E-Paper",
        style: TextStyle(color:  Style.Colors.appColor),
      ),
      // leading: Icon(Icons.arrow_back,color: Colors.red,),
      actions: [
        // IconButton(
        //   onPressed: () {},
        //   icon: Icon(Icons.notifications_none),
        //   color: Colors.red,
        // ),
        // IconButton(
        //     onPressed: () {},
        //     icon: Icon(Icons.favorite_border),
        //     color: Colors.red),
        IconButton(
            onPressed: () async {
              _selectDate(context);
              // homeController.getEPaper("");
              // Alerts.showAlertAndBack(context, "No Internet Connection", "Please check your internet");
            },
            icon: Icon(
              Icons.today,
              size: 30,
            ),
            color: Style.Colors.appColor,)
      ],
    );
  }

  body() {
    // return _buildHotNewsWidget(homeController.getHotNewsList);
    return Obx(() {
      if (homeController.isLoadingEPaper.value != true) {
        return _buildHotNewsWidget(homeController.getEPaperObj.value);
      } else {
        if (homeController.isRefreshEPaper.value != true) {
          return Center(
            child: CircularProgressIndicator(color: Style.Colors.appColor),
            // child: Container(),
          );
        } else {
          return Center(
            // child: CircularProgressIndicator(color: Colors.red),
            child: Container(),
          );
        }
      }
    });
  }

  Widget _buildHotNewsWidget(GetEPaper getEPaperObj) {
    List<EPaperDetails>? ePaperDataList =
        getEPaperObj.ePaperDetails != null ? getEPaperObj.ePaperDetails : [];
    String? pdfPath = getEPaperObj.pdfPath;
    String? message =
        getEPaperObj.message ?? AppConstants.noInternetConn;
    String? imagePath = getEPaperObj.imgPath;
    if (ePaperDataList!.length == 0) {
      return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView(
          // physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height-200,
              //height: MediaQuery.of(context).size.height,
              alignment: Alignment.center,
              child: Center(
                child: Text(
                  message!,
                  style: TextStyle(color: Colors.black45),
                ),
              ),
            ),

          ],
        ),
      );
    } else
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          // height: articles.length / 2 * 210.0,
          // padding: EdgeInsets.all(5.0),
          child: new GridView.builder(
            // physics: NeverScrollableScrollPhysics(),
            itemCount: ePaperDataList.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 0.85),
            itemBuilder: (context, index) {
              final String newsDate = DateFormat("dd-MMM-yyyy").format(DateTime.parse(ePaperDataList[index].date!));
              print("newsDate $newsDate");
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.pdfScreen, arguments: [
                      {
                        "pdfPath":
                            pdfPath! + ePaperDataList[index].fileAttechments!
                      },
                      {"title": ePaperDataList[index].epaperTitle!}
                    ]);
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => PDFScreeen(
                    //             pdfLink: pdfPath!+ePaperDataList[index].fileAttechments!,
                    //         )));
                  },
                  child: Container(
                    width: 220.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 1.5,
                          spreadRadius: 1.0,
                          offset: Offset(
                            1.0,
                            1.0,
                          ),
                        )
                      ],
                    ),
                    child: Column(
                      children: <Widget>[
                        ePaperDataList[index].paperImg! == null
                            ? Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(5.0),
                                          topRight: Radius.circular(5.0)),
                                      image: DecorationImage(
                                          image:
                                              // NetworkImage(imagePath!+ePaperDataList[index].paperImg!),
                                              AssetImage(
                                                  "assets/img/placeholder.jpg"),

                                          // articles[index].img! == null
                                          //     ? AssetImage("aseets/img/placeholder.jpg")
                                          //     : NetworkImage(articles[index].img!),

                                          fit: BoxFit.fill)),
                                  // height: 150,
                                ),
                              )
                            : Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(5.0),
                                          topRight: Radius.circular(5.0)),
                                      image: DecorationImage(
                                          image: NetworkImage(imagePath! +
                                              ePaperDataList[index].paperImg!),
                                          //AssetImage("assets/img/placeholder.jpg"),

                                          // articles[index].img! == null
                                          //     ? AssetImage("aseets/img/placeholder.jpg")
                                          //     : NetworkImage(articles[index].img!),

                                          fit: BoxFit.fill)),
                                  // height: 150,
                                ),
                              ),
                        Container(
                          padding: EdgeInsets.only(
                              left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
                          child: Text(
                            ePaperDataList[index].epaperTitle!,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            style: TextStyle(
                                height: 1.3,
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(left: 10.0, right: 10.0),
                              width: 180,
                              height: 1.0,
                              color: Colors.black12,
                            ),
                            Container(
                              width: 30,
                              height: 3.0,
                              color: Style.Colors.mainColor,
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                newsDate,
                                style: TextStyle(
                                    color: Style.Colors.mainColor,
                                    fontSize: 12.0),
                              ),
                              Text(
                                timeUntil(DateTime.parse(
                                    ePaperDataList[index].date!)),
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 12.0),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      );
  }

  String timeUntil(DateTime date) {
    return timeago.format(date, allowFromNow: true, locale: 'en');
  }
}
