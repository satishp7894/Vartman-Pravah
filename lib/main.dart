import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
// import 'package:news/utils/firebase_config.dart';
import 'bindings/main_binding.dart';
import 'routes/navigation.dart';

// FirebaseAnalytics analytics = FirebaseAnalytics.instance;
Future<void> main() async {
   // FirebaseAnalytics analytics = FirebaseAnalytics();
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(options: DefaultFirebaseConfig.platformOptions);
  MobileAds.instance.initialize();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {


  const MyApp({Key? key}) : super(key: key);


  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  // static FirebaseAnalyticsObserver observer =
  // FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // theme: Theme.of(context),
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.splash,
      getPages: Pages.pages,
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: analytics),

      ],
      // navigatorObservers: <NavigatorObserver>[observer],
     initialBinding: MainBinding(),
    );
  }
}


