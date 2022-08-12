import 'package:get/get.dart';
import 'package:news/routes/navigation.dart';

class SplashController extends GetxController {

  @override
  void onInit() {
    validateSession();
    super.onInit();
  }

  void validateSession() async {
    await Future.delayed(
      const Duration(seconds: 5),
    );

    Get.offNamed(Routes.landingHome);

    // final token = await localRepositoryInterface.getToken();
    // if (token != null) {
    //   final result = await apiRepositoryInterface.getUserFromToken(token);
    //   if (result != null) {
    //     await localRepositoryInterface.saveUser(result.user);
    //     Get.offNamed(Routes.landingHome);
    //   } else {
    //     Get.offNamed(Routes.landingHome);
    //   }
    // } else{
    //   Get.offNamed(Routes.login);
    // }

  }



}
