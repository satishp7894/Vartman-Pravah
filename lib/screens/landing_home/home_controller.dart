import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:news/models/article.dart';
import 'package:news/models/get_all_category.dart';
import 'package:news/models/get_all_slider.dart';
import 'package:news/models/get_e_paper.dart';
import 'package:news/models/get_splash_screen_image.dart';
import 'package:news/models/get_today_news.dart';
import 'package:news/models/source.dart';
import 'package:news/repository/api_repository.dart';
import 'package:news/utils/alerts.dart';
import 'package:news/utils/check_internet.dart';
import 'package:news/widget/custom_dialog.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class HomeController extends GetxController {
  final ApiRepositoryInterface apiRepositoryInterface;
  final BuildContext context;

  var tabIndex = 0;
  RxBool isLoadingGetSlider = false.obs;
  var getSliderObj = GetAllSlider().obs;
  RxBool isLoadingEPaper = false.obs;
  RxBool isRefreshEPaper = false.obs;
  var getEPaperObj = GetEPaper().obs;
  RxBool isLoadingGetCategory = false.obs;
  var getCategoryObj = GetAllCategory().obs;
  RxBool isLoadingGetSplashImage = false.obs;
  var getFlashImageObj = GetSlashScreenImage().obs;
  var getCategoryList = <SourceModel>[].obs;
  RxBool isLoadingGetTodayNews = false.obs;
  RxBool isRefreshGetTodayNews = false.obs;
  // var getTodayNewsList = <News>[].obs;
  // var getTodayNewsObj;
  var getTodayNewsObj = GetTodayNews().obs;
  RxBool isLoadingGetSearch = false.obs;
  var getSearchList = <ArticleModel>[].obs;
  RxBool isLoadingGetCategoryNews = false.obs;
  var getCategoryListNews = <ArticleModel>[].obs;
  PageController pageController = PageController();
  final searchController = TextEditingController();

  HomeController({required this.apiRepositoryInterface,required this.context});

  @override
  void onInit() {
    // checkInternet();

    initPlatformState();
    getSlashImage();
    getAllCategory();
    getSlider();
    getTodayNews(false);
    getEPaper("",false);
    super.onInit();
  }



  void changeTabIndex(int index) {
    tabIndex = index;
    pageController.jumpToPage(index);
    update();
  }

  Future<void> initPlatformState() async {
    // if (!mounted) return;

    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

    // await OneSignal.shared
    //     .setAppId("cb7c702e-bca3-40e7-9652-1d127ce0c139");

    await OneSignal.shared
        .setAppId("ff0d165c-4db8-4d67-a95a-56f03d237071");

    await OneSignal.shared.promptUserForPushNotificationPermission(
        fallbackToSettings: true);

    // OneSignal.shared.setRequiresUserPrivacyConsent(_requireConsent);
    //
    // OneSignal.shared
    //     .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
    //   print('NOTIFICATION OPENED HANDLER CALLED WITH: ${result}');
    //   // this.setState(() {
    //   //   _debugLabelString =
    //   //   "Opened notification: \n${result.notification.jsonRepresentation().replaceAll("\\n", "\n")}";
    //   // });
    // });

    // OneSignal.shared
    //     .setNotificationWillShowInForegroundHandler((OSNotificationReceivedEvent event) {
    //   print('FOREGROUND HANDLER CALLED WITH: ${event}');
    //   /// Display Notification, send null to not display
    //   event.complete(null);
    //
    //   // this.setState(() {
    //   //   _debugLabelString =
    //   //   "Notification received in foreground notification: \n${event.notification.jsonRepresentation().replaceAll("\\n", "\n")}";
    //   // });
    // });

    // OneSignal.shared
    //     .setInAppMessageClickedHandler((OSInAppMessageAction action) {
    //   // this.setState(() {
    //   //   _debugLabelString =
    //   //   "In App Message Clicked: \n${action.jsonRepresentation().replaceAll("\\n", "\n")}";
    //   // });
    // });

    OneSignal.shared
        .setSubscriptionObserver((OSSubscriptionStateChanges changes) {
      print("SUBSCRIPTION STATE CHANGED: ${changes.jsonRepresentation()}");
    });

    OneSignal.shared.setExternalUserId("12345678");
    //
    // OneSignal.shared.setPermissionObserver((OSPermissionStateChanges changes) {
    //   print("PERMISSION STATE CHANGED: ${changes.jsonRepresentation()}");
    // });

    // OneSignal.shared.setEmailSubscriptionObserver(
    //         (OSEmailSubscriptionStateChanges changes) {
    //       print("EMAIL SUBSCRIPTION STATE CHANGED ${changes.jsonRepresentation()}");
    //     });
    //
    // OneSignal.shared.setSMSSubscriptionObserver(
    //         (OSSMSSubscriptionStateChanges changes) {
    //       print("SMS SUBSCRIPTION STATE CHANGED ${changes.jsonRepresentation()}");
    //     });
    //
    // OneSignal.shared.setOnWillDisplayInAppMessageHandler((message) {
    //   print("ON WILL DISPLAY IN APP MESSAGE ${message.messageId}");
    // });
    //
    // OneSignal.shared.setOnDidDisplayInAppMessageHandler((message) {
    //   print("ON DID DISPLAY IN APP MESSAGE ${message.messageId}");
    // });
    //
    // OneSignal.shared.setOnWillDismissInAppMessageHandler((message) {
    //   print("ON WILL DISMISS IN APP MESSAGE ${message.messageId}");
    // });
    //
    // OneSignal.shared.setOnDidDismissInAppMessageHandler((message) {
    //   print("ON DID DISMISS IN APP MESSAGE ${message.messageId}");
    // });

    // NOTE: Replace with your own app ID from https://www.onesignal.com
    // await OneSignal.shared
    //     .setAppId("380dc082-5231-4cc2-ab51-a03da5a0e4c2");



    // iOS-only method to open launch URLs in Safari when set to false
    // OneSignal.shared.setLaunchURLsInApp(false);
    //
    // bool requiresConsent = await OneSignal.shared.requiresUserPrivacyConsent();

    // this.setState(() {
    //   _enableConsentButton = requiresConsent;
    // });

    // Some examples of how to use In App Messaging public methods with OneSignal SDK
    // oneSignalInAppMessagingTriggerExamples();

    // OneSignal.shared.disablePush(false);

    // Some examples of how to use Outcome Events public methods with OneSignal SDK
    // oneSignalOutcomeEventsExamples();

    // bool userProvidedPrivacyConsent = await OneSignal.shared.userProvidedPrivacyConsent();
    // print("USER PROVIDED PRIVACY CONSENT: $userProvidedPrivacyConsent");
  }


  getSlider() async {
    try {
      isLoadingGetSlider(true);
      await apiRepositoryInterface.getSlider().then((value) {
        getSliderObj(value);
      });
    } finally {

      isLoadingGetSlider(false);
    }
  }

  getAllCategory() async {
    try {
      isLoadingGetCategory(true);
      await apiRepositoryInterface.getCategory().then((value) {
        getCategoryObj(value);

      });
    } finally {
      isLoadingGetCategory(false);
    }

  }

  getSlashImage() async {
    try {
      isLoadingGetSplashImage(true);
      await apiRepositoryInterface.getSlashImage().then((value) {
       // getFlashImageObj(value);
        openCustomDialog(value);
      });
    } finally {
      isLoadingGetSplashImage(false);
    }

  }

  getTodayNews(bool refresh) async {
    try {
      isLoadingGetTodayNews(true);
      isRefreshGetTodayNews(refresh);
      await apiRepositoryInterface.getTodayNews().then((value) {
        getTodayNewsObj(value);
      });
    } finally {
      isLoadingGetTodayNews(false);
    }
  }

  getEPaper(String date, bool refresh) async {
    try {
      isLoadingEPaper(true);
      isRefreshEPaper(refresh);
      await apiRepositoryInterface.ePaper(date).then((value) {
        getEPaperObj(value);
      });
    } finally {
      isLoadingEPaper(false);
    }

  }

   openCustomDialog(GetSlashScreenImage? getSlashScreenImage) async {
     // await Future.delayed(
     //   const Duration(seconds: 3),
     // );



     // GetSlashScreenImage? getSlashScreenImage = getFlashImageObj.value;
     List<FlashData>? newsDetailList = getSlashScreenImage!.flashData ?? [] ;
     String? imagePath = getSlashScreenImage.imgPath;

     print("newsDetailList ${newsDetailList}");
     print("imagePath ${imagePath}");
     await  Future.delayed(const Duration(seconds: 3), () {
       if(newsDetailList.isEmpty){
         print("newsDetailList isEmpty ${newsDetailList}");
       }else{
         showGeneralDialog(
             barrierDismissible: false,
             context: context, pageBuilder: (BuildContext context, Animation animation,
             Animation secondaryAnimation) {
           return CustomDialog(flashDataList: newsDetailList,imagePath: imagePath);
         } );
       }

       // Your code

     });

  }

  Future<void> checkInternet() async {
    bool result = await InternetConnectionChecker().hasConnection;
    if(result == true) {
      print('YAY! Free cute dog pics!');
    } else {
      print('No internet :( Reason:');
      Alerts.showAlertAndBack( "No Internet Connection", "Please check your internet");
     // print(InternetConnectionChecker().lastTryResults);
    }
  }

  // search(String value) async {
  //   try {
  //     isLoadingGetSearch(true);
  //     await apiRepositoryInterface.search(value).then((value) {
  //       getSearchList(value?.articles);
  //     });
  //   } finally {
  //     isLoadingGetSearch(false);
  //   }
  // }
  //
  // getSourceNews(String sourceId) async {
  //   try {
  //     isLoadingGetCategoryNews(true);
  //     await apiRepositoryInterface.getSourceNews(sourceId).then((value) {
  //       getCategoryListNews(value?.articles);
  //     });
  //   } finally {
  //     isLoadingGetCategoryNews(false);
  //   }
  // }
}
