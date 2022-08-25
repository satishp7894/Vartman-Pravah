
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:news/constants/app_costants.dart';
import 'package:news/models/get_all_category.dart';
import 'package:news/models/get_today_news.dart';
import 'package:news/models/news_by_category.dart';
import 'package:news/screens/news_details/news_details_screen.dart';
import 'package:news/style/theme.dart' as Style;
import 'package:news/utils/check_internet.dart';
import 'category_details_controller.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:news/routes/navigation.dart';

class CategoryDetails extends StatefulWidget {
  final String? categoryId;
  final String? categoryName;
  const CategoryDetails({Key? key, required this.categoryId,required this.categoryName}) : super(key: key);

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {

  CategoryDetailsController? categoryDetailsController;

  // final Newscategory args =
  // ModalRoute.of(context)!.settings.arguments as Newscategory;

  // dynamic argumentData = Get.arguments;
  // print(argumentData[0]['categoryId']);
  // print(argumentData[1]['categoryName']);

  // dynamic argumentData = Get.arguments;
  // print(widget.categoryId);
  // print(widget.categoryName);



  // final newsDetailsController = Get.find<NewsDetailsController>();
  // print("args.categoryId! ${widget.categoryId}");
  @override
  void initState() {
    CheckInternet.checkInternet();
    print("args.categoryId! ${widget.categoryId}");
     categoryDetailsController = Get.put(CategoryDetailsController(
        apiRepositoryInterface: Get.find(), categoryId: widget.categoryId!));

    initData(categoryDetailsController!,widget.categoryId!);

    // TODO: implement initState
    super.initState();
  }

  DateTime selectedDate = DateTime.now();
  String? date="";
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2099, 8),

    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        final DateFormat formatter = DateFormat('dd-MM-yyyy');
        date = formatter.format(picked);
        selectedDate = picked;
        categoryDetailsController!.getNewsByCategory(widget.categoryId!,date!,false);
        print("selectedDate $date");
      });
    }
  }



  @override
  Widget build(BuildContext context) {


    return Obx(() {
      if (categoryDetailsController!.isLoadingGetCategoryDetail.value != true) {
        // GetNewsByCategory? getNewsByCategory = categoryDetailsController.getCategoryDetailsObj.value;

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: InkWell(onTap:(){

              Get.back();
            },child: Icon(Icons.arrow_back,color: Colors.red,)),
            title:  Text(widget.categoryName!,style: TextStyle(color: Colors.red),),
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
                  },
                  icon: Icon(
                    Icons.today,
                    size: 30,
                  ),
                  color: Color(0xFFFC7663))
            ],
          ),
          body: RefreshIndicator(
            color: Style.Colors.appColor,
            onRefresh: () {
              print("refresh ${date}");
              CheckInternet.checkInternet();
         return   categoryDetailsController!.getNewsByCategory(widget.categoryId!,date!, true);
          },
            child:  _buildCategoryWidget(categoryDetailsController!.getCategoryDetailsObj.value,categoryDetailsController!),
          )






        );
      } else {


        if (categoryDetailsController!.isRefreshGetCategoryDetail.value != true){
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              leading: InkWell(onTap:(){
                Get.back();
              },child: Icon(Icons.arrow_back,color: Style.Colors.appColor,)),
              title:  Text(widget.categoryName!,style: TextStyle(color: Colors.red),),
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
                    },
                    icon: Icon(
                      Icons.today,
                      size: 30,
                    ),
                    color: Style.Colors.appColor)
              ],
            ),
            body: Center(
              child: CircularProgressIndicator(color: Style.Colors.appColor),
            ),
          );
        }else{
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              leading: InkWell(onTap:(){
                Get.back();
              },child: Icon(Icons.arrow_back,color: Style.Colors.appColor,)),
              title:  Text(widget.categoryName!,style: TextStyle(color: Style.Colors.appColor),),
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
                    },
                    icon: Icon(
                      Icons.today,
                      size: 30,
                    ),
                    color: Style.Colors.appColor)
              ],
            ),
            body: Center(
              child: Container(),
            ),
          );
        }


      }
    });
  }
  String timeUntil(DateTime date) {
    return timeago.format(date, allowFromNow: true, locale: 'en');
  }

  _buildCategoryWidget(GetNewsByCategory getNewsByCategory, CategoryDetailsController categoryDetailsController) {
   List<Newsdata>? newsList = getNewsByCategory.newsdata != null ?getNewsByCategory.newsdata :[];
   List<Nextdata>? nextList = getNewsByCategory.nextdata != null ?getNewsByCategory.nextdata :[];
   String? imagePath = getNewsByCategory.imgPath;
   String? message = getNewsByCategory.message ?? AppConstants.noInternetConn;
    if(newsList!.isEmpty){
      return Container(
        width: MediaQuery.of(context).size.width,
         height: MediaQuery.of(context).size.height,
        child: ListView(
          // physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height-100,
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
    }else{
      return  Container(
        //  height: articles.length / 2 * 210.0,
        padding: EdgeInsets.all(5.0),
        child: new GridView.builder(
          // physics: NeverScrollableScrollPhysics(),
          itemCount: newsList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,

              // childAspectRatio: 0.85
            mainAxisExtent: 250,

          ),
          itemBuilder: (context, index) {
            final dt = DateTime.now().difference(DateTime.parse(newsList[index].newsDate!)).inDays;
            final String newsDate = DateFormat("dd-MMM-yyyy")
                .format(DateTime.parse(newsList[index].newsDate!));
            return Padding(
              padding: const EdgeInsets.only(left: 5.0, right: 5.0, top: 5.0,bottom: 5.0),
              child: GestureDetector(
                onTap: () {
                  // Get.toNamed(Routes.newsDetails,arguments:
                  // // newsDetailList[index]
                  // [
                  //   {"bool": false},
                  //   {"newsData": newsList[index]},
                  //   {"nextData": nextList},
                  //   {"imagePath": imagePath}
                  // ]
                  // );
                  // categoryDetailsController.getNewsByCategory(newsList[index].categoryId!,"",false);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NewsDetailScreen(isBool: false,newsData: newsList[index],imagePath: imagePath, isPageCheck: false,

                            // article: articles[index],
                          )));
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => DetailNews(
                  //           article: articles[index],
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
                      // newsList[index].videoUrl == null || newsList[index].videoUrl == ""
                      //     ?
                      // newsList[index].image! == null
                      //     ? Expanded(
                      //   child: Container(
                      //     decoration: BoxDecoration(
                      //         borderRadius: BorderRadius.only(
                      //             topLeft: Radius.circular(5.0),
                      //             topRight: Radius.circular(5.0)),
                      //         image: DecorationImage(
                      //             image: AssetImage(
                      //                 "assets/img/placeholder.jpg"),
                      //
                      //             //AssetImage("assets/img/placeholder.jpg"),
                      //
                      //             // articles[index].img! == null
                      //             //     ? AssetImage("aseets/img/placeholder.jpg")
                      //             //     : NetworkImage(articles[index].img!),
                      //
                      //             fit: BoxFit.fill)),
                      //   ),
                      // )
                      //     : Expanded(
                      //   child: Container(
                      //     decoration: BoxDecoration(
                      //         borderRadius: BorderRadius.only(
                      //             topLeft: Radius.circular(5.0),
                      //             topRight: Radius.circular(5.0)),
                      //         image: DecorationImage(
                      //             image: NetworkImage(
                      //                 "${imagePath! + newsList[index].image!}"),
                      //
                      //             //AssetImage("assets/img/placeholder.jpg"),
                      //
                      //             // articles[index].img! == null
                      //             //     ? AssetImage("aseets/img/placeholder.jpg")
                      //             //     : NetworkImage(articles[index].img!),
                      //
                      //             fit: BoxFit.fill)),
                      //   ),
                      // )
                      //     :newsList[index].image! == null
                      //     ?
                      // Expanded(
                      //   child: Stack(
                      //
                      //     children: [
                      //       Container(
                      //         decoration: BoxDecoration(
                      //             borderRadius: BorderRadius.only(
                      //                 topLeft: Radius.circular(5.0),
                      //                 topRight: Radius.circular(5.0)),
                      //             image: DecorationImage(
                      //                 image: AssetImage(
                      //                     "assets/img/placeholder.jpg"),
                      //
                      //                 //AssetImage("assets/img/placeholder.jpg"),
                      //
                      //                 // articles[index].img! == null
                      //                 //     ? AssetImage("aseets/img/placeholder.jpg")
                      //                 //     : NetworkImage(articles[index].img!),
                      //
                      //                 fit: BoxFit.fill)),
                      //       ),
                      //       Container(
                      //         child: Padding(
                      //           padding: const EdgeInsets.only(right: 5.0),
                      //           child: Container(
                      //
                      //             child: Image.asset("assets/img/youtube.png",),height: 40,width: 40,),
                      //         )
                      //         ,alignment: Alignment.center,)
                      //
                      //     ],
                      //   ),
                      // )
                      //     : Expanded(
                      //   child: Stack(
                      //     children: [
                      //       Container(
                      //         // height: 100,
                      //         decoration: BoxDecoration(
                      //             borderRadius: BorderRadius.only(
                      //                 topLeft: Radius.circular(5.0),
                      //                 topRight: Radius.circular(5.0)),
                      //             image: DecorationImage(
                      //                 image: NetworkImage(
                      //                     "${imagePath! + newsList[index].image!}"),
                      //
                      //                 //AssetImage("assets/img/placeholder.jpg"),
                      //
                      //                 // articles[index].img! == null
                      //                 //     ? AssetImage("aseets/img/placeholder.jpg")
                      //                 //     : NetworkImage(articles[index].img!),
                      //
                      //                 fit: BoxFit.fill)),
                      //       ),
                      //       Container(
                      //         child: Padding(
                      //           padding: const EdgeInsets.only(right: 5.0),
                      //           child: Container(
                      //
                      //             child: Image.asset("assets/img/youtube.png",),height: 40,width: 40,),
                      //         )
                      //         ,alignment: Alignment.center,)
                      //
                      //       // Center(child: Text("YouTube",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.red),))
                      //     ],
                      //   ),
                      // ),

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
                      // Container(
                      //   padding: EdgeInsets.only(
                      //       left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
                      //   child: Text(
                      //     newsList[index].newsTitle!,
                      //     textAlign: TextAlign.center,
                      //     maxLines: 2,
                      //     style: TextStyle(height: 1.3, fontSize: 15.0),
                      //   ),
                      // ),
                      // Stack(
                      //   alignment: Alignment.center,
                      //   children: <Widget>[
                      //     Container(
                      //       padding: EdgeInsets.only(left: 10.0, right: 10.0),
                      //       width: 180,
                      //       height: 1.0,
                      //       color: Colors.black12,
                      //     ),
                      //     Container(
                      //       width: 30,
                      //       height: 3.0,
                      //       color: Style.Colors.mainColor,
                      //     ),
                      //   ],
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.all(10.0),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       Text(
                      //         newsList[index].categoryName!,
                      //         style: TextStyle(
                      //             color: Style.Colors.mainColor, fontSize: 9.0),
                      //       ),
                      //       Text(
                      //         timeUntil(DateTime.parse(newsList[index].newsDate!)),
                      //         // "timeUntil",
                      //         style: TextStyle(
                      //             color: Colors.black54, fontSize: 9.0),
                      //       )
                      //     ],
                      //   ),
                      // )

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
      );
    }

  }
  // Future<void> initData(CategoryDetailsController categoryDetailsController, String categoryId) async {
  //   print("categoryId ${categoryId}");
  //   await  Future.delayed(const Duration(microseconds: 1), () {
  //     categoryDetailsController.getNewsByCategory(categoryId,"");
  //   } );
  // }

  Future<void> initData(CategoryDetailsController categoryDetailsController, String categoryId) async {
    print("categoryId ${categoryId}");
    await  Future.delayed(const Duration(microseconds: 1), () {
      categoryDetailsController.getNewsByCategory(categoryId,"",false);
    } );
  }
}
