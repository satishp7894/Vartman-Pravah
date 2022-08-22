// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import 'splash_controller.dart';
//
// class SplashScreen extends GetWidget<SplashController> {
//   const SplashScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             CircleAvatar(
//               radius: 100,
//               backgroundColor: Colors.blue.withOpacity(0.2),
//               child: Padding(
//                 padding: const EdgeInsets.all(12.0),
//                 child: Image.asset('assets/logos/app_logo.png'),
//               ),
//             ),
//
//             const CircularProgressIndicator(color: Colors.red,)
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news/routes/navigation.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {

  AnimationController? animationController;
  Animation<double>? animation;

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration:  const Duration(seconds: 3));
    animation = CurvedAnimation(parent: animationController!,curve: Curves.easeOut);
    animation!.addListener( (){
      setState(() {

      });
    });
    animationController!.forward();
    initializeApp();
    super.initState();
  }

  void initializeApp() async {
    await Future.delayed(
      const Duration(seconds: 3),
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

  @override
  Widget build(BuildContext context) {
        return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 100,
              backgroundColor: Colors.blue.withOpacity(0.2),
              child: Container(
                width: animation!.value * 350,
                height: animation!.value * 350,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Image.asset('assets/logos/app_logo.png'),
                ),
              ),
            ),

            const CircularProgressIndicator(color: Colors.red,)
          ],
        ),
      ),
    );

  }
}

