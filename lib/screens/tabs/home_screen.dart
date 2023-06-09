import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:news/constants/app_costants.dart';
import 'package:news/models/get_all_category.dart';
import 'package:news/models/get_today_news.dart';
import 'package:news/screens/category_details/category_details.dart';
import 'package:news/screens/category_details/category_details_controller.dart';
import 'package:news/screens/landing_home/home_controller.dart';
import 'package:news/screens/news_details/news_details_screen.dart';
import 'package:news/style/theme.dart' as Style;
import 'package:news/utils/alerts.dart';
import 'package:news/utils/check_internet.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeago/timeago.dart' as timeago;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final homeController = Get.find<HomeController>();

  @override
  void initState() {
    // homeController.openCustomDialog();
    // Obx(() {
    //   if (homeController.isLoadingGetSplashImage.value != true) {
    //     return homeController.openCustomDialog();
    //   } else {
    //     return const Center(
    //       child: CircularProgressIndicator(),
    //     );
    //   }
    // });
    CheckInternet.checkInternet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Obx(() {
    //   if (homeController.isLoadingGetSplashImage.value != true) {
    //     return homeController.openCustomDialog();
    //   } else {
    //     return const Center(
    //       child: CircularProgressIndicator(),
    //     );
    //   }
    // });

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Material(
              elevation: 10,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 70,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 3),
                        child: Image.asset(
                          'assets/logos/app_logo.png',
                        ),
                      ),
                    ),
                  ),
                  // Text("kwqdj"),
                  PopupMenuButton(
                      child: Container(
                        height: 26,
                        width: 40,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 17.41),
                        child: Icon(Icons.more_vert_outlined,color: Colors.grey,size: 35,),
                        // child: Image.asset(
                        //  "assets/img/menu.png",
                        //   color: Colors.red,
                        //   width: 23,
                        //   fit: BoxFit.contain,
                        // ),
                      ),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          child:  Text("About Us"),
                          value: 1,

                        ),
                        PopupMenuItem(
                          child: const Text("Contact Us"),
                          value: 2,
                        ),
                      ]

                  ,

                    onSelected: (result) {
                      if (result == 1) {
                        Alerts.showAlertDialog( "About Us", "વર્તમાન પ્રવાહ ગુજરાતી સમાચાર માટે શ્રેષ્ઠ વેબસાઈટ છે. નિયમિત અપડેટ્સ માટે અમને અનુસરો!");
                      }else  if (result == 2) {
                        Alerts.showAlertDialog( "Contact Us", "સરનામું: દમણ કાર્યાલય : કલેકટર ઓફિસ નજીક, વીઆયપી સર્કિટ હાઉસ ની સામે, ઢોલર, મોટી દમણ \n નામ: શ્રી મુકેશ ગોસાવીસ \n સંપર્ક: 9979619477");
                      }
                    },)
                ],
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                color: Style.Colors.appColor,
                onRefresh: () {
                  print("onRefresh ");
                  CheckInternet.checkInternet();
                  homeController.getSlider();
                  homeController.getAllCategory();
                  return homeController.getTodayNews(true);
                },
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Obx(() {
                        if (homeController.isLoadingGetTodayNews.value !=
                            true) {
                          return  Column(
                            children: [
                              Obx(() {
                                if (homeController.isLoadingGetTodayNews.value !=
                                    true) {
                                  return _buildSliderWidget(
                                      homeController.getTodayNewsObj.value);
                                } else {
                                  if (homeController.isRefreshGetTodayNews.value !=
                                      true) {
                                    return Container(
                                      height: 200,
                                      // child: Center(
                                      //     child: CircularProgressIndicator(
                                      //         color: Style.Colors.appColor))
                                    );
                                  } else {
                                    return Container(
                                      height: 200,
                                    );
                                  }
                                }
                              }),

                              Obx(() {
                                if (homeController.isLoadingGetCategory.value != true) {
                                  return Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8.0),
                                        child: Row(
                                          children: const <Widget>[
                                            Text(
                                              "Category",
                                              style: TextStyle(
                                                // color: Colors.black45,
                                                  color: Style.Colors.titleColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17.0),
                                            ),
                                          ],
                                        ),
                                      ),
                                      _buildCategoryWidget(
                                          homeController.getCategoryObj.value),
                                    ],
                                  );
                                } else {
                                  if (homeController.isRefreshGetTodayNews.value !=
                                      true) {
                                    return Container(
                                      height: 90,
                                      // child: Center(
                                      //     child: CircularProgressIndicator(
                                      //         color: Style.Colors.appColor))
                                    );
                                  } else {
                                    return Container(
                                      height: 90,
                                    );
                                  }
                                }
                              }),

                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Obx(() {
                                  if (homeController.isLoadingGetTodayNews.value !=
                                      true) {
                                    return Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8.0),
                                          child: Row(
                                            children: <Widget>[
                                              Text(
                                                "News",
                                                style: TextStyle(
                                                    color: Style.Colors.titleColor,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 17.0),
                                              ),
                                            ],
                                          ),
                                        ),
                                        _buildTodayNewsWidget(
                                            homeController.getTodayNewsObj.value),
                                      ],
                                    );
                                  } else {
                                    if (homeController.isRefreshGetTodayNews.value !=
                                        true) {
                                      return Container(
                                        height: 200,
                                        // child: Center(
                                        //     child: CircularProgressIndicator(
                                        //         color: Style.Colors.appColor))
                                      );
                                    } else {
                                      return Container(
                                        height: 200,
                                      );
                                    }
                                  }
                                }),
                              ),
                              // HotNewsWidget()
                            ],
                          );
                        } else {
                          if (homeController.isRefreshGetTodayNews.value !=
                              true) {
                            return Container(
                              height: MediaQuery.of(context).size.height-120,
                              child: Center(
                                  child: CircularProgressIndicator(
                                      color: Style.Colors.appColor))
                            );
                          } else {
                            return Container(
                              height: 200,
                            );
                          }
                        }
                      }),

                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSliderWidget(GetTodayNews getTodayNewsObj) {
    // List<SliderData>? sliderList =
    //     getAllSliderObj.sliderData != null ? getAllSliderObj.sliderData : [];
    // String? imagePathe = getAllSliderObj.imgPath;
    // String? message = getAllSliderObj.message != null
    //     ? getAllSliderObj.message
    //     : "No Data Found";
    List<Newsdata>? sliderList =
        getTodayNewsObj.newsdata != null ? getTodayNewsObj.newsdata : [];
    String? imagePath = getTodayNewsObj.imgPath;
    String? message = getTodayNewsObj.message ?? AppConstants.noInternetConn;
    if (sliderList!.length == 0) {
      return Container(
        width: MediaQuery.of(context).size.width,
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              message!,
              style: TextStyle(color: Colors.black45),
            ),
          ],
        ),
      );
    } else {
      return Container(
          child: CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                // enlargeCenterPage: false,
                height: 200.0,
                viewportFraction: 1.0,
              ),
              items: getExpenseSliders(sliderList, imagePath!)));
    }
  }

  getExpenseSliders(List<Newsdata> sliderList, String imagePathe) {
    return sliderList
        .map(
          (sliderObj) => GestureDetector(
            onTap: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => DetailNews(
              //           article: sliderList,
              //         )));
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NewsDetailScreen(
                        isBool: true,
                        newsData: sliderObj,
                        imagePath: imagePathe,
                        isPageCheck: true,
                        // article: articles[index],
                      )));
            },
            child: Container(
              padding: EdgeInsets.only(
                  left: 5.0, right: 5.0, top: 10.0, bottom: 5.0),
              child: Stack(
                children: <Widget>[
                  sliderObj.image! == null
                      ? Container(
                          decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          shape: BoxShape.rectangle,
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage("assets/img/placeholder.jpg")

                              //       image: article.img == null
                              //   ? AssetImage("assets/img/placeholder.jpg")
                              // : NetworkImage(article.img)
                              ),
                        ))
                      : Container(
                          decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          shape: BoxShape.rectangle,
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(imagePathe + sliderObj.image!)

                              //       image: article.img == null
                              //   ? AssetImage("assets/img/placeholder.jpg")
                              // : NetworkImage(article.img)
                              ),
                        )),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          stops: [
                            0.1,
                            0.9
                          ],
                          colors: [
                            Colors.black.withOpacity(0.9),
                            Colors.white.withOpacity(0.0)
                          ]),
                    ),
                  ),
                  Positioned(
                      bottom: 8.0,
                      child: Container(
                        padding: EdgeInsets.only(left: 8.0, right: 8.0),
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          sliderObj.newsTitle!,
                          style: TextStyle(
                              color: Colors.white,

                              fontWeight: FontWeight.bold,
                              fontSize: 12.0),
                        ),
                      )),
                  // Positioned(
                  //     bottom: 10.0,
                  //     left: 10.0,
                  //     child: Text(
                  //       "sliderObj",
                  //       style: TextStyle(color: Colors.white54, fontSize: 9.0),
                  //     )),
                  // Positioned(
                  //     bottom: 10.0,
                  //     right: 10.0,
                  //     child: Text("timeUntil",
                  //       // timeUntil(DateTime.parse(sliderObj.sliderId!)),
                  //       style: TextStyle(color: Colors.white54, fontSize: 9.0),
                  //     )),
                ],
              ),
            ),
          ),
        )
        .toList();
  }

  String timeUntil(DateTime date) {
    return timeago.format(date, allowFromNow: true, locale: 'en');
  }

  Widget _buildCategoryWidget(GetAllCategory getAllCategory) {
    List<Newscategory>? categoryList =
        getAllCategory.newscategory != null ? getAllCategory.newscategory : [];
    String? iconPath = getAllCategory.iconPath;
    String? message = getAllCategory.message != null
        ? getAllCategory.message
        : AppConstants.noInternetConn;
    if (categoryList!.length == 0) {
      return Container(
        height: 90.0,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  message!,
                  style: TextStyle(color: Colors.black45),
                )
              ],
            )
          ],
        ),
      );
    } else
      return Container(
        height: 75.0,
        margin: EdgeInsets.only(top: 5.0, left: 3.0),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categoryList.length,
          itemBuilder: (context, index) {
            return Container(
              // color: Colors.red,

              width: 60.0,
              child: GestureDetector(
                onTap: () async {
                  final sharedPreferences =
                      await SharedPreferences.getInstance();
                  sharedPreferences.setString(AppConstants.categoryId!,
                      categoryList[index].categoryId!);
                  sharedPreferences.setString(AppConstants.categoryName!,
                      categoryList[index].categoryName!);
                  // AppConstants.categoryId!=categoryList[index].categoryId;
                  // AppConstants.categoryName!=categoryList[index].categoryName;
                  // Get.toNamed(Routes.categoryDetails,
                  //     arguments:
                  //     [
                  //       {"categoryId": categoryList[index].categoryId},
                  //       {"categoryName": categoryList[index].categoryName},
                  //     ]
                  //
                  //     // categoryList[index]
                  //
                  // );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoryDetails(
                        categoryId: categoryList[index].categoryId,
                        categoryName: categoryList[index].categoryName,
                      ),
                    ),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    categoryList[index].catIcon! == null
                        ? Hero(
                            tag: categoryList[index].categoryId!,
                            child: Container(
                                width: 50.0,
                                height: 50.0,
                                decoration: new BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      width: 0.5, color: Colors.grey),
                                  //shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 5.0,
                                      spreadRadius: 1.0,
                                      offset: Offset(
                                        1.0,
                                        1.0,
                                      ),
                                    )
                                  ],
                                  image: new DecorationImage(
                                      fit: BoxFit.fill,
                                      image: AssetImage(
                                          "assets/img/placeholder.jpg")
                                      //AssetImage("assets/logos/abc-news.png")
                                      ),
                                )),
                          )
                        : Hero(
                            tag: categoryList[index].categoryId!,
                            child: Container(
                                width: 50.0,
                                height: 50.0,
                                decoration: new BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      width: 0.5, color: Colors.grey),
                                  //shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 5.0,
                                      spreadRadius: 1.0,
                                      offset: Offset(
                                        1.0,
                                        1.0,
                                      ),
                                    )
                                  ],
                                  image: new DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(iconPath! +
                                          categoryList[index].catIcon!)
                                      //AssetImage("assets/logos/abc-news.png")
                                      ),
                                )),
                          ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      categoryList[index].categoryName!,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          // height: 1.4,
                          color: Style.Colors.titleColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0),
                    ),
                    // SizedBox(
                    //   height: 3.0,
                    // ),
                    // Text(
                    //   sources[index].category!,
                    //   maxLines: 2,
                    //   textAlign: TextAlign.center,
                    //   style: TextStyle(
                    //       height: 1.4,
                    //       color: Style.Colors.titleColor,
                    //       fontWeight: FontWeight.bold,
                    //       fontSize: 9.0),
                    // ),
                  ],
                ),
              ),
            );
          },
        ),
      );
  }

  Widget _buildTodayNewsWidget(GetTodayNews getTodayNewsObj) {
    List<Newsdata>? newsList =
        getTodayNewsObj.newsdata != null ? getTodayNewsObj.newsdata : [];
    String? imagePath = getTodayNewsObj.imgPath;
    String? message = getTodayNewsObj.message ?? AppConstants.noInternetConn;
    if (newsList!.length == 0) {
      return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView(
          // physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 600,
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
      return Container(
        width: MediaQuery.of(context).size.width,
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              message,
              style: TextStyle(color: Colors.black45),
            ),
          ],
        ),
      );
    } else
      // return Wrap(children: newsList.map((e) {
      //
      //   var index = newsList.indexOf(e);
      //   print("newsList[index].image! ${newsList[index].newsId!}");
      //   return Padding(
      //     padding: const EdgeInsets.only(left: 5.0, right: 5.0, top: 10.0),
      //     child: GestureDetector(
      //       onTap: () {
      //         Get.toNamed(Routes.newsDetails,arguments: newsList[index]);
      //         // Navigator.push(
      //         //     context,
      //         //     MaterialPageRoute(
      //         //         builder: (context) => NewsDetailScreen(
      //         //           news: e,
      //         //         )));
      //       },
      //       child: Container(
      //        // width: 220.0,
      //         decoration: BoxDecoration(
      //           color: Colors.white,
      //           borderRadius: BorderRadius.all(Radius.circular(5.0)),
      //           boxShadow: [
      //             BoxShadow(
      //               color: Colors.grey,
      //               blurRadius: 1.5,
      //               spreadRadius: 1.0,
      //               offset: Offset(
      //                 1.0,
      //                 1.0,
      //               ),
      //             )
      //           ],
      //         ),
      //         child: Column(
      //           children: <Widget>[
      //             AspectRatio(
      //               aspectRatio: 16 / 9,
      //               child: Container(
      //                 decoration: BoxDecoration(
      //                     borderRadius: BorderRadius.only(
      //                         topLeft: Radius.circular(5.0),
      //                         topRight: Radius.circular(5.0)),
      //                     image: DecorationImage(
      //                         image:
      //                         //AssetImage("assets/img/placeholder.jpg"),
      //
      //                         // newsList[index].image == null
      //                         //     ? AssetImage("aseets/img/placeholder.jpg")
      //                         //     :
      //                         NetworkImage("${imagePath!+newsList[index].image!}"),
      //
      //
      //
      //                         fit: BoxFit.cover)),
      //               ),
      //             ),
      //             Container(
      //               padding: EdgeInsets.only(
      //                   left: 10.0, right: 10.0, top: 15.0, bottom: 15.0),
      //               child: Text(
      //                 e.newsTitle!,
      //                 textAlign: TextAlign.center,
      //                 maxLines: 2,
      //                 style: TextStyle(height: 1.3, fontSize: 15.0),
      //               ),
      //             ),
      //             Stack(
      //               alignment: Alignment.center,
      //               children: <Widget>[
      //                 Container(
      //                   padding: EdgeInsets.only(left: 10.0, right: 10.0),
      //                   width: 180,
      //                   height: 1.0,
      //                   color: Colors.black12,
      //                 ),
      //                 Container(
      //                   width: 30,
      //                   height: 3.0,
      //                   color: Style.Colors.mainColor,
      //                 ),
      //               ],
      //             ),
      //             Padding(
      //               padding: const EdgeInsets.all(10.0),
      //               child: Row(
      //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                 children: [
      //                   Text(
      //                     e.categoryName!,
      //                     style: TextStyle(
      //                         color: Style.Colors.mainColor, fontSize: 9.0),
      //                   ),
      //                   Text(
      //                     timeUntil(DateTime.parse(e.newsDate!)),
      //                     // "timeUntil",
      //                     style: TextStyle(
      //                         color: Colors.black54, fontSize: 9.0),
      //                   )
      //                 ],
      //               ),
      //             )
      //           ],
      //         ),
      //       ),
      //     ),
      //   );
      // }).toList(),);

      return Column(
        children: [
          Container(
            // height: articles.length / 2 * 210.0,
            padding: EdgeInsets.only(left: 3.0),
            child: new GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: newsList.length,
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,

                // childAspectRatio: 1.00
                // ,
                mainAxisExtent: 250,

              ),
              itemBuilder: (context, index) {
                final dt = DateTime.now().difference(DateTime.parse(newsList[index].newsDate!)).inDays;
                final String newsDate = DateFormat("dd-MMM-yyyy")
                    .format(DateTime.parse(newsList[index].newsDate!));
                print("newsList[index].videoUrl ${newsList[index].videoUrl}");
                return Padding(
                  padding: const EdgeInsets.only(
                      left: 5.0, right: 5.0, top: 5.0, bottom: 5.0),
                  child: GestureDetector(
                    onTap: () {
                      print("categoryId ${newsList[index].categoryId}");
                      print("categoryId ${newsList[index].categoryName}");
                      int? categoryId =
                          int.parse(newsList[index].categoryId!) - 1;
                      print("categoryId ${newsList[index].categoryName}");
                      final categoryDetailsController =
                      Get.find<CategoryDetailsController>();
                      // categoryDetailsController.getNewsByCategory(categoryId.toString(),"",false);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NewsDetailScreen(
                                isBool: true,
                                newsData: newsList[index],
                                imagePath: imagePath,
                                isPageCheck: true,
                                // article: articles[index],
                              )));
                      //Get.toNamed(Routes.newsDetails, arguments: newsList[index]);
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => NewsDetailScreen(
                      //           news: e,
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
                          newsList[index].videoUrl == null || newsList[index].videoUrl == ""
                              ?
                          newsList[index].image! == null
                              ? Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5.0),
                                    topRight: Radius.circular(5.0)),
                                image: DecorationImage(
                                    image: AssetImage(
                                        "assets/img/placeholder.jpg"),

                                    //AssetImage("assets/img/placeholder.jpg"),

                                    // articles[index].img! == null
                                    //     ? AssetImage("aseets/img/placeholder.jpg")
                                    //     : NetworkImage(articles[index].img!),

                                    fit: BoxFit.fill)),
                            height: 150,
                          )
                              : Container(

                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5.0),
                                    topRight: Radius.circular(5.0)),
                                image: DecorationImage(
                                    image: NetworkImage(
                                        "${imagePath! + newsList[index].image!}"),

                                    //AssetImage("assets/img/placeholder.jpg"),

                                    // articles[index].img! == null
                                    //     ? AssetImage("aseets/img/placeholder.jpg")
                                    //     : NetworkImage(articles[index].img!),

                                    fit: BoxFit.fill)),
                            height: 150,
                          )
                              :newsList[index].image! == null
                              ?
                          Container(
                            child: Stack(

                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(5.0),
                                          topRight: Radius.circular(5.0)),
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "assets/img/placeholder.jpg"),

                                          //AssetImage("assets/img/placeholder.jpg"),

                                          // articles[index].img! == null
                                          //     ? AssetImage("aseets/img/placeholder.jpg")
                                          //     : NetworkImage(articles[index].img!),

                                          fit: BoxFit.fill)),
                                ),
                                Container(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 5.0),
                                    child: Container(

                                      child: Image.asset("assets/img/youtube.png",),height: 40,width: 40,),
                                  )
                                  ,alignment: Alignment.center,)

                              ],
                            ),
                            height: 150,
                          )
                              : Container(
                            height: 150,
                            child: Stack(
                              children: [
                                Container(
                                  // height: 100,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(5.0),
                                          topRight: Radius.circular(5.0)),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              "${imagePath! + newsList[index].image!}"),

                                          //AssetImage("assets/img/placeholder.jpg"),

                                          // articles[index].img! == null
                                          //     ? AssetImage("aseets/img/placeholder.jpg")
                                          //     : NetworkImage(articles[index].img!),

                                          fit: BoxFit.fill)),
                                ),
                                Container(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 5.0),
                                    child: Container(

                                      child: Image.asset("assets/img/youtube.png",),height: 40,width: 40,),
                                  )
                                  ,alignment: Alignment.center,)

                                // Center(child: Text("YouTube",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.red),))
                              ],
                            ),
                          ),
                          Container(
                            height: 50,

                            padding: EdgeInsets.only(
                                left: 10.0,
                                right: 10.0,
                                top: 0.0,
                                bottom: 0.0),
                            child: Center(
                              child: Text(
                                newsList[index].newsTitle!,
                                // textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle( fontSize: 15.0),
                              ),
                            ),
                          ),
                          Container(
                            child: Column(children: [
                              Stack(
                                alignment: Alignment.center,
                                children: <Widget>[
                                  Container(
                                    padding:
                                    EdgeInsets.only(left: 10.0, right: 10.0),
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
                                padding: const EdgeInsets.all(9.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        newsList[index].categoryName!,
                                        style: TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            color: Style.Colors.mainColor,
                                            fontSize: 12.0),
                                      ),
                                    ),
                                    dt >= 6
                                        ?Text(
                                      newsDate,
                                      // "timeUntil",
                                      style: TextStyle(
                                          color: Colors.black54, fontSize: 12.0),
                                    )
                                        :
                                    Text(
                                      timeUntil(DateTime.parse(
                                          newsList[index].newsDate!)),
                                      // "timeUntil",
                                      style: TextStyle(
                                          color: Colors.black54, fontSize: 12.0),
                                    )
                                  ],
                                ),
                              )
                            ],),
                            height: 40,
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      );
  }
}
