

import 'package:get/get.dart';
import 'package:news/bindings/main_binding.dart';
import 'package:news/screens/category_details/category_details.dart';
import 'package:news/screens/news_details/news_details_screen.dart';
import 'package:news/widget/pdf_screen.dart';
import 'package:news/screens/landing_home/home_binding.dart';
import 'package:news/screens/landing_home/landing_home.dart';
import 'package:news/screens/splash/splash_binding.dart';
import 'package:news/screens/splash/splash_screen.dart';

class Routes {
  static final String splash = '/splash';
  static final String home = '/tabs';
  static final String login = '/login';
  static final String landingHome = '/landingHome';
  static final String productDetails = '/productDetails';
  static final String newsDetails = '/newsDetails';
  static final String pdfScreen = '/pdfScreen';
  static final String categoryDetails = '/categoryDetails';
  static final String cart = '/cart';
  static final String myOrder = '/myOrder';
  static final String editProfile = '/editProfile';
  static final String myOrderDetails = '/myOrderDetails';
  static final String categoryProduct = '/categoryProduct';
  static final String imageScreen = '/imageScreen';
  static final String checkAccount = '/checkAccount';
  static final String sendCodeScreen = '/sendCodeScreen';
  static final String createNewPassword = '/createNewPassword';
}

class Pages {
  static final pages = [
    GetPage(
        name: Routes.splash,
        page: () => const SplashScreen(),
        binding: SplashBinding()
    ),
    GetPage(
      name: Routes.landingHome,
      page: () => LandingHome(),
     // bindings: [HomeBinding(), MainBinding()],
    ),
    // GetPage(
    //   name: Routes.newsDetails,
    //   page: () => const NewsDetailScreen(),
    //  // bindings: [NewsDetailsBinding(), MainBinding()],
    // ),
    GetPage(
      name: Routes.pdfScreen,
      page: () => const PDFScreeen(),
      // bindings: [NewsDetailsBinding(), MainBinding()],
    ),
    // GetPage(
    //   name: Routes.categoryDetails,
    //   page: () => const CategoryDetails(),
    //   // bindings: [NewsDetailsBinding(), MainBinding()],
    // ),
    // GetPage(
    //     name: Routes.landingHome,
    //     page: () => const LandingHome(),
    //     bindings: [
    //       HomeBinding(),
    //       MainBinding(),
    //       CategoriesBinding(),
    //     ]),
    // GetPage(
    //     name: Routes.productDetails,
    //     page: () => const ProductDetailsScreen(),
    //     bindings: [ProductDetailsBinding(), MainBinding()]),
    // GetPage(
    //     name: Routes.cart,
    //     page: () => CartScreen(0,true),
    //     bindings: [MainBinding(), CartBinding()]),
    // GetPage(
    //     name: Routes.categoryProduct,
    //     page: () => CategoryProducts(),
    //     bindings: [MainBinding(), CategoriesBinding(), HomeBinding()]),
    // GetPage(
    //     name: Routes.myOrder,
    //     page: () => MyOrderScreen(),
    //     bindings: [MainBinding(), MyOrderBinding()]),
    // GetPage(
    //     name: Routes.myOrderDetails,
    //     page: () => OrderDetaisScreen(),
    //     bindings: [MainBinding(), MyOrderBinding()]),
    // GetPage(
    //     name: Routes.editProfile,
    //     page: () => EditProfileScreen(),
    //     bindings: [MainBinding(), ProfileBinding()]),
    //  yasle garda suru maa Yo controller  initiaze hunxa
    // GetPage(name: SajiloDokanRoutes.home, page: () => Home()),
    // GetPage(
    //     name: SajiloDokanRoutes.login,
    //     page: () => LoginScreen(),
    //     bindings: [LoginBinding(), MainBinding()],
    //     binding: LoginBinding()),
    // GetPage(
    //     name: SajiloDokanRoutes.landingHome,
    //     page: () => LandingHome(),
    //     binding: HomeBinding(),
    //     bindings: [
    //       MainBinding(),
    //       HomeBinding(),
    //       CategoriesBinding(),
    //       CartBinding()
    //     ]),
    // GetPage(
    //     name: SajiloDokanRoutes.productDetails,
    //     page: () => ProductDetailsScreen(),
    //     binding: ProductDetailsBinding(),
    //     bindings: [ProductDetailsBinding(), MainBinding()]),
    // GetPage(
    //     name: SajiloDokanRoutes.cart,
    //     page: () => CartScreen(0),
    //     bindings: [MainBinding(), CartBinding()]),
    // GetPage(
    //     name: SajiloDokanRoutes.categoryProduct,
    //     page: () => CategoryProducts(),
    //     bindings: [MainBinding(), CategoriesBinding(), HomeBinding()]),
    //
    // GetPage(
    //     name: SajiloDokanRoutes.imageScreen,
    //     page: () => ImageScreen(),
    //     bindings: [
    //       ProductDetailsBinding(),
    //     ]),
    // GetPage(
    //     name: SajiloDokanRoutes.checkAccount,
    //     page: () => CheckAccountScreen(),
    //     bindings: [MainBinding(), ForgotPasswordBinding()]),
    // GetPage(
    //     name: SajiloDokanRoutes.sendCodeScreen, page: () => SendCodeScreen()),
    // GetPage(
    //     name: SajiloDokanRoutes.createNewPassword,
    //     page: () => CreateNewPassword())
  ];
}
