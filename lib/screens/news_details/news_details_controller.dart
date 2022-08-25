import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import 'package:news/models/get_all_slider.dart';
import 'package:news/models/get_news_details.dart';

import 'package:news/repository/api_repository.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:io' show Platform;

import 'package:news/utils/check_internet.dart';

class NewsDetailsController extends GetxController {
  BannerAd? bannerAd;
  int numBannerLoadAttempts = 0;
  // bool? isBannerAdReady = false;
  RxBool isBannerAdReady = false.obs;
  static final AdRequest request = AdRequest(
    keywords: <String>['foo', 'bar'],
    contentUrl: 'http://foo.com/bar.html',
    nonPersonalizedAds: true,
  );

  int maxFailedLoadAttempts = 3;

  final String newsId;
  final ApiRepositoryInterface apiRepositoryInterface;

  // RxString newsId = "".obs;
  RxBool isLoadingGetNewDetail = false.obs;
  RxBool isRefreshGetNewDetail = false.obs;
  var getNewsDetailsObj = GetNewsDetails().obs;

  NewsDetailsController({required this.apiRepositoryInterface, required this.newsId});


  void createBannerAd() {
    print("_createBannerAd --------------------------------");
    // bannerAd!.dispose();
    bannerAd = BannerAd(
      // TODO: replace these test ad units with your own ad unit.
      adUnitId: Platform.isAndroid
      // ? 'ca-app-pub-3940256099942544/6300978111'
      //     ? 'ca-app-pub-8498403144141675/9828738038'
          ? 'ca-app-pub-4354709352726050/1006106436'
      // ? 'ca-app-pub-4354709352726050/1006106436'
      //     : 'ca-app-pub-3940256099942544/2934735716',
          : 'ca-app-pub-4354709352726050/1669168991',
      size: AdSize.banner,
      request: request,
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          print('$ad loaded--------------: ${ad.responseInfo}');
          // setState(() {
            // When the ad is loaded, get the ad size and use it to set
            // the height of the ad container.
            bannerAd = ad as BannerAd;
            numBannerLoadAttempts = 0;
            isBannerAdReady(true);
            // update();
            // _isLoaded = true;
          // });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('Anchored adaptive banner failedToLoad: $error');
          numBannerLoadAttempts += 1;
          bannerAd = null;
          isBannerAdReady(false);
          if (numBannerLoadAttempts < maxFailedLoadAttempts) {
            createBannerAd();
          }
          // ad.dispose();
        },
      ),
    );
    bannerAd!.load();
  }


  getNewsDetail(String newsId,bool refreh) async {
    try {
      isLoadingGetNewDetail(true);
      isRefreshGetNewDetail(refreh);
      await apiRepositoryInterface.getNewsDetails(newsId).then((value) {
        getNewsDetailsObj(value);
      });
    } finally {
      isLoadingGetNewDetail(false);
    }
  }
}
