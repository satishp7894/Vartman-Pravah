import 'package:get/get.dart';
import 'package:news/network/api_repository_impl.dart';
import 'package:news/repository/api_repository.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiRepositoryInterface>(() => ApiRepositoryImpl());
  }
}
