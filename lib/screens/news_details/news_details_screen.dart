import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
// import 'package:flutter_youtube_view/flutter_youtube_view.dart';

// import 'package:flutter_html/flutter_html.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';
import 'package:news/constants/app_costants.dart';
import 'package:news/models/get_all_category.dart';

// import 'package:html/parser.dart' show parse;
import 'package:news/models/get_news_details.dart';
import 'package:news/models/get_today_news.dart';

// import 'package:news/models/get_today_news.dart';
import 'package:news/models/news_by_category.dart';
import 'package:news/routes/navigation.dart';
import 'package:news/screens/category_details/category_details.dart';
import 'package:news/screens/category_details/category_details_controller.dart';

// import 'package:news/models/get_news_details.dart';
import 'package:news/screens/news_details/news_details_controller.dart';
import 'package:news/style/theme.dart' as Style;
import 'package:news/utils/check_internet.dart';
import 'package:news/widget/youtube_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeago/timeago.dart' as timeago;

class NewsDetailScreen extends StatefulWidget {
  final bool? isBool;
  final bool? isPageCheck;
  final Newsdata? newsData;

  // final List<Nextdata>? nextData;
  final String? imagePath;

  const NewsDetailScreen(
      {Key? key,
      required this.isBool,
      required this.newsData,
      required this.imagePath,
      required this.isPageCheck})
      : super(key: key);

  @override
  _NewsDetailScreenState createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  CategoryDetailsController? categoryDetailsController;
  NewsDetailsController? newsDetailsController;
  static final AdRequest request = AdRequest(
    keywords: <String>['foo', 'bar'],
    contentUrl: 'http://foo.com/bar.html',
    nonPersonalizedAds: true,
  );

  InterstitialAd? _interstitialAd;
  int _numInterstitialLoadAttempts = 0;
  int maxFailedLoadAttempts = 3;

  RewardedAd? _rewardedAd;
  int _numRewardedLoadAttempts = 0;

  // BannerAd? _bannerAd;
  // int _numBannerLoadAttempts = 0;
  // bool? _isBannerAdReady = false;
  Newsdata? newsdata;
  String? imagePath;

  @override
  void initState() {
    // _createInterstitialAd();
    // _createRewardedAd();
    // _createBannerAd();
    // showAds();

    CheckInternet.checkInternet();
    newsdata = widget.newsData;
    // List<Nextdata>? nextList = widget.nextData;
    imagePath = widget.imagePath;
    categoryDetailsController = Get.find<CategoryDetailsController>();
    newsDetailsController = Get.put(NewsDetailsController(
        apiRepositoryInterface: Get.find(), newsId: newsdata!.newsId!));
    newsDetailsController!.createBannerAd();
    super.initState();
  }


  @override
  void dispose() {
    // TODO: implement dispose
    categoryDetailsController!.onClose();
    newsDetailsController!.onClose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //if(widget.isBool != true){

    initNextData(categoryDetailsController!, newsdata!, widget.isPageCheck);
    // }

    // final Newsdata args =
    //     ModalRoute.of(context)!.settings.arguments as Newsdata;

    // dynamic argumentData = Get.arguments;
    // print(argumentData[0]['bool']);
    // print(argumentData[1]['newsData']);
    // print(argumentData[2]['nextData']);
    // print(argumentData[3]['imagePath']);

    // Newsdata? newsdata = argumentData[1]['newsData'];
    // List<Nextdata>? nextList = argumentData[2]['nextData'] != null ?argumentData[2]['nextData'] :[];
    // String? imagePath = argumentData[3]['imagePath'];

    // final newsDetailsController = Get.find<NewsDetailsController>();
    print("args.newsId! ${newsdata!.newsId!}");
    print("args.categoryId! ${newsdata!.categoryId!}");

    // newsDetailsController.getNewsDetail(newsdata.newsId!);
    // newsDetailsController.newsId(args.newsId!);
    initData(newsDetailsController!, newsdata!);

    return WillPopScope(
      onWillPop: () async {
        debugPrint("Will pop");
        final sharedPreferences = await SharedPreferences.getInstance();

        print(
            "AppConstants.categoryId ${sharedPreferences.getString(AppConstants.categoryId!)}");
        print(
            "AppConstants.categoryName ${sharedPreferences.getString(AppConstants.categoryName!)}");
        Get.back();
        //
        // Get.toNamed(Routes.categoryDetails,arguments: [
        //   {"categoryId": sharedPreferences.getString(AppConstants.categoryId!)},
        //   {"categoryName": sharedPreferences.getString(AppConstants.categoryName!)},
        // ]);
        if (widget.isBool!) {
          Get.toNamed(Routes.landingHome);
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => CategoryDetails(
                categoryId:
                    sharedPreferences.getString(AppConstants.categoryId!),
                categoryName:
                    sharedPreferences.getString(AppConstants.categoryName!),
              ),
            ),
          );
        }

        return true;
      },
      child: Obx(() {
        GetNewsDetails? getNewsDetails =
            newsDetailsController!.getNewsDetailsObj.value;
        List<NewsDetails>? newsDetailList = getNewsDetails.newsDetails != null
            ? getNewsDetails.newsDetails
            : [];
        if (newsDetailsController!.isLoadingGetNewDetail.value != true) {
          // return Text("tetete");

          // var document = parse(
          //     newsDetailList[0].description!);
          // print("document ${document.outerHtml}");
          return Scaffold(
              // bottomNavigationBar: GestureDetector(
              //       onTap: () {
              //        // launch(article.url);
              //       },
              //                 child: Container(
              //                   height: 48.0,
              //                   width: MediaQuery.of(context).size.width,
              //                   decoration: BoxDecoration(
              //                     color: Colors.white,
              //                     gradient: Style.Colors.primaryGradient
              //                   ),
              //                   child: Column(
              //                     mainAxisAlignment: MainAxisAlignment.center,
              //                     crossAxisAlignment: CrossAxisAlignment.center,
              //                     children: <Widget>[
              //                       Text("Read More", style: TextStyle(
              //                         color: Colors.white,
              //                         fontFamily: "SFPro-Bold",
              //                         fontSize: 15.0
              //                       ),),
              //                     ],
              //                   ),
              //                 ),
              //     ),
              appBar: AppBar(
                backgroundColor: Colors.white,
                leading: InkWell(
                    onTap: () async {
                      // initNextData(categoryDetailsController!,newsdata);
                      //  initData(newsDetailsController,newsdata);
                      final sharedPreferences =
                          await SharedPreferences.getInstance();

                      print(
                          "AppConstants.categoryId ${sharedPreferences.getString(AppConstants.categoryId!)}");
                      print(
                          "AppConstants.categoryName ${sharedPreferences.getString(AppConstants.categoryName!)}");
                      Get.back();
                      //
                      // Get.toNamed(Routes.categoryDetails,arguments: [
                      //   {"categoryId": sharedPreferences.getString(AppConstants.categoryId!)},
                      //   {"categoryName": sharedPreferences.getString(AppConstants.categoryName!)},
                      // ]);

                      if (widget.isBool!) {
                        Get.toNamed(Routes.landingHome);
                      } else {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CategoryDetails(
                              categoryId: sharedPreferences
                                  .getString(AppConstants.categoryId!),
                              categoryName: sharedPreferences
                                  .getString(AppConstants.categoryName!),
                            ),
                          ),
                        );
                      }
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.red,
                    )),
                title: Text(
                  newsdata!.newsTitle!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
              bottomNavigationBar: Obx(() {
                if (newsDetailsController!.isBannerAdReady.value == true) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      // color: Colors.green,
                      width: MediaQuery.of(context).size.width,
                      height: newsDetailsController!.bannerAd!.size.height
                          .toDouble(),
                      child: AdWidget(ad: newsDetailsController!.bannerAd!),
                    ),
                  );
                } else {
                  return Container(
                    height: 0,
                    // child: CircularProgressIndicator(color: Colors.red),
                  );
                }
              }),
              body: RefreshIndicator(
                color: Style.Colors.appColor,
                onRefresh: () {
                  int? categoryId;
                  if (widget.isPageCheck! == true) {
                    categoryId = int.parse(newsdata!.categoryId!) - 1;
                    print("categoryId if ${categoryId}");
                  } else {
                    categoryId = int.parse(newsdata!.categoryId!);
                    print("categoryId else ${categoryId}");
                  }

                  // print("categoryId ${categoryId}");
                  CheckInternet.checkInternet();

                  categoryDetailsController!
                      .getNewsByCategory(categoryId.toString(), "", false);
                  return newsDetailsController!
                      .getNewsDetail(newsdata!.newsId!, true);
                },
                child: _buildNewsDetailWidget(
                    newsDetailsController!.getNewsDetailsObj.value,
                    imagePath,
                    widget.isBool,
                    widget.isPageCheck,
                    newsDetailsController!,
                    categoryDetailsController: categoryDetailsController),
              ));
        } else {
          // return const Center(
          //   child: CircularProgressIndicator(),
          // );
          if (newsDetailsController!.isRefreshGetNewDetail.value != true) {
            return Scaffold(
              // bottomNavigationBar: GestureDetector(
              //       onTap: () {
              //        // launch(article.url);
              //       },
              //                 child: Container(
              //                   height: 48.0,
              //                   width: MediaQuery.of(context).size.width,
              //                   decoration: BoxDecoration(
              //                     color: Colors.white,
              //                     gradient: Style.Colors.primaryGradient
              //                   ),
              //                   child: Column(
              //                     mainAxisAlignment: MainAxisAlignment.center,
              //                     crossAxisAlignment: CrossAxisAlignment.center,
              //                     children: <Widget>[
              //                       Text("Read More", style: TextStyle(
              //                         color: Colors.white,
              //                         fontFamily: "SFPro-Bold",
              //                         fontSize: 15.0
              //                       ),),
              //                     ],
              //                   ),
              //                 ),
              //     ),
              appBar: AppBar(
                backgroundColor: Colors.white,
                leading: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.red,
                    )),
                title: new Text(
                  newsdata!.newsTitle!,
                  style: TextStyle(color: Colors.red),
                ),
              ),
              body: const Center(
                child: CircularProgressIndicator(color: Colors.red),
              ),
            );
          } else {
            return Scaffold(
              // bottomNavigationBar: GestureDetector(
              //       onTap: () {
              //        // launch(article.url);
              //       },
              //                 child: Container(
              //                   height: 48.0,
              //                   width: MediaQuery.of(context).size.width,
              //                   decoration: BoxDecoration(
              //                     color: Colors.white,
              //                     gradient: Style.Colors.primaryGradient
              //                   ),
              //                   child: Column(
              //                     mainAxisAlignment: MainAxisAlignment.center,
              //                     crossAxisAlignment: CrossAxisAlignment.center,
              //                     children: <Widget>[
              //                       Text("Read More", style: TextStyle(
              //                         color: Colors.white,
              //                         fontFamily: "SFPro-Bold",
              //                         fontSize: 15.0
              //                       ),),
              //                     ],
              //                   ),
              //                 ),
              //     ),
              appBar: AppBar(
                backgroundColor: Colors.white,
                leading: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.red,
                    )),
                title: new Text(
                  newsdata!.newsTitle!,
                  style: TextStyle(color: Colors.red),
                ),
              ),
              body: Center(
                child: Container(),
              ),
            );
          }
        }
      }),
    );

    // return GetBuilder<NewsDetailsController>(
    //     init: NewsDetailsController(
    //         apiRepositoryInterface: Get.find(), newsId: newsdata.newsId!),
    //     builder: (newsDetailsController) {
    //
    //     });
  }

  String timeUntil(DateTime date) {
    return timeago.format(date, allowFromNow: true);
  }

  showAds() async {
    await Future.delayed(Duration(seconds: 2));
    // _showInterstitialAd();
    _showRewardedAd();
  }

  // void _createBannerAd() {
  //   print("_createBannerAd --------------------------------");
  //   _bannerAd = BannerAd(
  //     // TODO: replace these test ad units with your own ad unit.
  //     adUnitId: Platform.isAndroid
  //         // ? 'ca-app-pub-3940256099942544/6300978111'
  //         ? 'ca-app-pub-8498403144141675/9828738038'
  //         // ? 'ca-app-pub-4354709352726050/1006106436'
  //         : 'ca-app-pub-3940256099942544/2934735716',
  //     size: AdSize.banner,
  //     request: request,
  //     listener: BannerAdListener(
  //       onAdLoaded: (Ad ad) {
  //         print('$ad loaded--------------: ${ad.responseInfo}');
  //         setState(() {
  //           // When the ad is loaded, get the ad size and use it to set
  //           // the height of the ad container.
  //           _bannerAd = ad as BannerAd;
  //           _numBannerLoadAttempts = 0;
  //           _isBannerAdReady = true;
  //           // _isLoaded = true;
  //         });
  //       },
  //       onAdFailedToLoad: (Ad ad, LoadAdError error) {
  //         print('Anchored adaptive banner failedToLoad: $error');
  //         _numBannerLoadAttempts += 1;
  //         _bannerAd = null;
  //         _isBannerAdReady = false;
  //         if (_numBannerLoadAttempts < maxFailedLoadAttempts) {
  //           _createBannerAd();
  //         }
  //         // ad.dispose();
  //       },
  //     ),
  //   );
  //   _bannerAd!.load();
  // }

  // Interstitial Ads
  void _createInterstitialAd() {
    print("_createInterstitialAd");
    InterstitialAd.load(
        adUnitId: Platform.isAndroid
            // ? 'ca-app-pub-3940256099942544/1033173712'
            ? 'ca-app-pub-8498403144141675/3844708210'
            : 'ca-app-pub-3940256099942544/4411468910',
        request: request,
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            print('$ad loaded');
            _interstitialAd = ad;
            _numInterstitialLoadAttempts = 0;
            _interstitialAd!.setImmersiveMode(true);
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error.');
            _numInterstitialLoadAttempts += 1;
            _interstitialAd = null;
            if (_numInterstitialLoadAttempts < maxFailedLoadAttempts) {
              _createInterstitialAd();
            }
          },
        ));
  }

  void _showInterstitialAd() {
    if (_interstitialAd == null) {
      print('Warning: attempt to show interstitial before loaded.');
      return;
    }
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        _createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createInterstitialAd();
      },
    );
    _interstitialAd!.show();
    _interstitialAd = null;
  }

  // Rewarded Ads
  void _createRewardedAd() {
    RewardedAd.load(
        adUnitId: Platform.isAndroid
            // ? 'ca-app-pub-3940256099942544/5224354917'
            ? 'ca-app-pub-8498403144141675/3763217083'
            : 'ca-app-pub-3940256099942544/1712485313',
        request: request,
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (RewardedAd ad) {
            print('$ad loaded.');
            _rewardedAd = ad;
            _numRewardedLoadAttempts = 0;
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('RewardedAd failed to load: $error');
            _rewardedAd = null;
            _numRewardedLoadAttempts += 1;
            if (_numRewardedLoadAttempts < maxFailedLoadAttempts) {
              _createRewardedAd();
            }
          },
        ));
  }

  void _showRewardedAd() {
    if (_rewardedAd == null) {
      print('Warning: attempt to show rewarded before loaded.');
      return;
    }
    _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        _createRewardedAd();
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createRewardedAd();
      },
    );

    _rewardedAd!.setImmersiveMode(true);
    _rewardedAd!.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
      print('$ad with reward $RewardItem(${reward.amount}, ${reward.type})');
    });
    _rewardedAd = null;
  }

  _buildNewsDetailWidget(
      GetNewsDetails getNewsDetails,
      String? imagePath,
      bool? isBool,
      bool? isPageCheck,
      NewsDetailsController newsDetailsController,
      {CategoryDetailsController? categoryDetailsController}) {
    List<NewsDetails>? newsDetailList =
        getNewsDetails.newsDetails != null ? getNewsDetails.newsDetails : [];
    String? imagePath = getNewsDetails.imgPath;
    String? message = getNewsDetails.message ?? AppConstants.noInternetConn;
    if (newsDetailList!.length == 0) {
      return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView(
          // physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 200,
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
    } else {
      final String newsDate = DateFormat("dd-MMM-yyyy")
          .format(DateTime.parse(newsDetailList[0].newsDate!));
      // final String newsDate = DateFormat("dd-MMM-yyyy").format(DateTime.parse("2019-09-09"));
      print("newsDate $newsDate");
      print("newsDetailList[0].videoUrl ${newsDetailList[0].videoUrl}");
      return ListView(
        children: <Widget>[
          newsDetailList[0].videoUrl == null || newsDetailList[0].videoUrl == ""
              ? newsDetailList[0].image! == null
                  ? AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Container(
                          padding: EdgeInsets.only(right: 10.0),
                          width: MediaQuery.of(context).size.width * 2 / 5,
                          height: 130,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                            shape: BoxShape.rectangle,
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image:
                                    // NetworkImage(imagePath! + newsDetailList[0].image!)
                                    AssetImage("assets/img/placeholder.jpg")

                                //       image: article.img == null
                                //   ? AssetImage("assets/img/placeholder.jpg")
                                // : NetworkImage(article.img)
                                ),
                          )),
                      //             FadeInImage.assetNetwork(
                      //   alignment: Alignment.topCenter,
                      //   placeholder: 'images/placeholder.png',
                      //   image:
                      //   // article.img == null
                      //   // ?
                      //   "http://to-let.com.bd/operator/images/noimage.png"
                      //   // :
                      //   // article.img
                      //   ,
                      //   fit: BoxFit.cover,
                      //   width: double.maxFinite,
                      //   height:  MediaQuery.of(context).size.height*1/3
                      // ),
                    )
                  : AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Container(
                          padding: EdgeInsets.only(right: 10.0),
                          width: MediaQuery.of(context).size.width * 2 / 5,
                          height: 130,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                            shape: BoxShape.rectangle,
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(
                                    imagePath! + newsDetailList[0].image!)
                                //AssetImage("assets/img/placeholder.jpg")

                                //       image: article.img == null
                                //   ? AssetImage("assets/img/placeholder.jpg")
                                // : NetworkImage(article.img)
                                ),
                          )),
                      //             FadeInImage.assetNetwork(
                      //   alignment: Alignment.topCenter,
                      //   placeholder: 'images/placeholder.png',
                      //   image:
                      //   // article.img == null
                      //   // ?
                      //   "http://to-let.com.bd/operator/images/noimage.png"
                      //   // :
                      //   // article.img
                      //   ,
                      //   fit: BoxFit.cover,
                      //   width: double.maxFinite,
                      //   height:  MediaQuery.of(context).size.height*1/3
                      // ),
                    )
              :

          // Container(
          //   height: 200,
          //         child: FlutterYoutubeView(
          //             // onViewCreated: _onYoutubeCreated,
          //             // listener: this,
          //             scaleMode: YoutubeScaleMode.none,
          //             // <option> fitWidth, fitHeight
          //             params: YoutubeParam(
          //                 videoId: "CHaF2Gdqxd8",
          //                 showUI: false,
          //                 startSeconds: 0.0, // <option>
          //                 autoPlay: false) // <option>
          //             ))

          Container(height: 220,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),),
            child: YoutubeView(youtubeUrl: '${newsDetailList[0].videoUrl}'),
          )
          ,
          Container(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(newsDate,
                        style: TextStyle(
                            color: Style.Colors.mainColor,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Text(newsDetailList[0].newsTitle!,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 20.0)),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  timeUntil(DateTime.parse(newsDetailList[0].newsDate!)),
                  style: TextStyle(color: Colors.grey, fontSize: 12.0),
                ),
                SizedBox(
                  height: 5.0,
                ),
                // HtmlParser()
                // Text(document.outerHtml)
                Html(
                  data: newsDetailList[0].description,
                  // renderNewlines: true,
                  // defaultTextStyle: TextStyle(
                  //     fontSize: 14.0,
                  //     color: Colors.black87),
                ),
                // _buildCategoryWidget(categoryDetailsController.getCategoryDetailsObj.value)
                isPageCheck == true
                    ? Padding(
                        padding: const EdgeInsets.only(
                            right: 8.0, left: 8.0, bottom: 3.0),
                        child: Material(
                          elevation: 10,
                          child: Container(
                            // color: Colors.grey.withOpacity(0.5),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.8),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
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
                            width: MediaQuery.of(context).size.width,
                            // height: 70,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                newsDetailList[0].categoryName!,
                                style: TextStyle(
                                    color: Style.Colors.mainColor,
                                    fontSize: 20.0),
                              ),
                            ),
                          ),
                        ),
                      )
                    : Container(),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: _bannerWidget(newsDetailsController),
                // ),
                // Obx(() {
                //   if (newsDetailsController.isBannerAdReady.value == true) {
                //     return  Padding(
                //       padding: const EdgeInsets.all(8.0),
                //       child: Container(
                //         // color: Colors.green,
                //         width: MediaQuery.of(context).size.width,
                //         height: newsDetailsController.bannerAd!.size.height.toDouble(),
                //         child: AdWidget(ad: newsDetailsController.bannerAd!),
                //
                //       ),
                //     );
                //   } else {
                //     return const Center(
                //       child: CircularProgressIndicator(color: Colors.red),
                //     );
                //   }
                // }),

                Obx(() {
                  if (categoryDetailsController
                          ?.isLoadingGetCategoryDetail.value !=
                      true) {
                    return _buildCategoryWidget(
                        imagePath, categoryDetailsController!, isPageCheck);
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.red),
                    );
                  }
                }),
              ],
            ),
          )
        ],
      );
    }
  }

  _buildCategoryWidget(String? imagePath,
      CategoryDetailsController categoryDetailsController, bool? isPageCheck) {
    GetNewsByCategory? getNewsByCategory =
        categoryDetailsController.getCategoryDetailsObj.value;
    String? nextCategoryName = getNewsByCategory.nextCategoryName != null
        ? getNewsByCategory.nextCategoryName
        : "";
    List<Nextdata>? nextDataList =
        getNewsByCategory.nextdata != null ? getNewsByCategory.nextdata : [];
    // print("nextDataList ${nextDataList![0].newsTitle}");

    //  String? imagePath = getNewsByCategory.imgPath;
    //  String? message = getNewsByCategory.message != null ?getNewsByCategory.message :"No Data Found";
    if (nextDataList!.isEmpty) {
      return Container();
    } else {
      return Container(
        //  height: articles.length / 2 * 210.0,
        padding: EdgeInsets.all(5.0),
        child: Column(
          children: [
            isPageCheck == true
                ? Container()
                : Padding(
                    padding: const EdgeInsets.only(
                        left: 5.0, right: 5.0, bottom: 8.0),
                    child: Material(
                      elevation: 10,
                      child: Container(
                        // color: Colors.grey.withOpacity(0.5),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
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
                        width: MediaQuery.of(context).size.width,
                        // height: 70,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            nextCategoryName!,
                            style: TextStyle(
                                color: Style.Colors.mainColor, fontSize: 20.0),
                          ),
                        ),
                      ),
                    ),
                  ),
            new GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: nextDataList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 0.85),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(
                      left: 5.0, right: 5.0, top: 5.0, bottom: 5.0),
                  child: GestureDetector(
                    onTap: () {
                      print("nextDataList ${nextDataList[index].newsId}");
                      print("nextDataList ${nextDataList[index].newsTitle}");
                      // Get.toNamed(Routes.newsDetails,arguments:
                      // // newsDetailList[index]
                      // [
                      //   {"bool": false},
                      //   {"newsData": nextList[index]},
                      //   {"nextData": nextDataList},
                      //   {"imagePath": imagePath}
                      // ]
                      // );
                      // Get.toNamed(Routes.newsDetails,arguments: newsDetailList[index]);
                      //  categoryDetailsController.getNewsByCategory(nextDataList[index].categoryId!,"",false);

                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NewsDetailScreen(
                                    isBool: widget.isBool,
                                    newsData: Newsdata(
                                      newsId: nextDataList[index].newsId,
                                      newsTitle: nextDataList[index].newsTitle,
                                      shortDescription:
                                          nextDataList[index].shortDescription,
                                      newsDate: nextDataList[index].newsDate,
                                      image: nextDataList[index].image,
                                      categoryName:
                                          nextDataList[index].categoryName,
                                      categoryId:
                                          nextDataList[index].categoryId,
                                    ),
                                    imagePath: imagePath,
                                    isPageCheck: false,

                                    // article: articles[index],
                                  )));
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
                          nextDataList[index].videoUrl == null || nextDataList[index].videoUrl == ""
                              ?
                          nextDataList[index].image! == null
                              ? Expanded(
                            child: Container(
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
                          )
                              : Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(5.0),
                                      topRight: Radius.circular(5.0)),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          "${imagePath! + nextDataList[index].image!}"),

                                      //AssetImage("assets/img/placeholder.jpg"),

                                      // articles[index].img! == null
                                      //     ? AssetImage("aseets/img/placeholder.jpg")
                                      //     : NetworkImage(articles[index].img!),

                                      fit: BoxFit.fill)),
                            ),
                          )
                              :nextDataList[index].image! == null
                              ?
                          Expanded(
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
                          )
                              : Expanded(
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
                                              "${imagePath! + nextDataList[index].image!}"),

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
                            padding: EdgeInsets.only(
                                left: 10.0,
                                right: 10.0,
                                top: 10.0,
                                bottom: 10.0),
                            child: Text(
                              nextDataList[index].newsTitle!,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              style: TextStyle(height: 1.3, fontSize: 15.0),
                            ),
                          ),
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
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(

                                    nextDataList[index].categoryName!,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        // overflow: TextOverflow.ellipsis,
                                        color: Style.Colors.mainColor,
                                        fontSize: 12.0),
                                  ),
                                ),
                                Text(
                                  timeUntil(DateTime.parse(
                                      nextDataList[index].newsDate!)),
                                  // "timeUntil",
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
          ],
        ),
      );
    }
  }

  initNextData(CategoryDetailsController categoryDetailsController,
      Newsdata newsdata, bool? isPageCheck) async {
    int? categoryId;
    if (isPageCheck == true) {
      categoryId = int.parse(newsdata.categoryId!) - 1;
      print("categoryId if ${categoryId}");
    } else {
      categoryId = int.parse(newsdata.categoryId!);
      print("categoryId else ${categoryId}");
    }

    await Future.delayed(const Duration(seconds: 0), () {
      categoryDetailsController.getNewsByCategory(
          categoryId!.toString(), "", false);
    });
  }

  Future<void> initData(
      NewsDetailsController newsDetailsController, Newsdata newsdata) async {
    print("newsdata.newsId! ${newsdata.newsId!}");
    await Future.delayed(const Duration(microseconds: 0), () {
      newsDetailsController.getNewsDetail(newsdata.newsId!, false);
    });
  }

// _bannerWidget(NewsDetailsController? newsDetailsController) {
//   if(newsDetailsController!.isBannerAdReady!){
//     return  Container(
//       // color: Colors.green,
//       width: MediaQuery.of(context).size.width,
//       height: newsDetailsController.bannerAd!.size.height.toDouble(),
//       child: AdWidget(ad: newsDetailsController.bannerAd!),
//
//     );
//   } else{
//    return Container(
//       color: Colors.red,
//       height: 100,
//     );
//   }
// }
}
