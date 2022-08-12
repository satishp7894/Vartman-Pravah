

import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:news/models/get_all_slider.dart';
import 'package:news/models/get_news_details.dart';
import 'package:news/models/news_by_category.dart';
import 'package:news/repository/api_repository.dart';
import 'package:news/utils/check_internet.dart';

class CategoryDetailsController extends GetxController {
  final String categoryId;
  final ApiRepositoryInterface apiRepositoryInterface;

  // RxString newsId = "".obs;
  RxBool isLoadingGetCategoryDetail = false.obs;
  RxBool isRefreshGetCategoryDetail = false.obs;
  var getCategoryDetailsObj = GetNewsByCategory().obs;

  CategoryDetailsController({required this.apiRepositoryInterface, required this.categoryId});

  @override
  void onInit() {

    // print("onInit $categoryId");
    // getNewsByCategory(categoryId,"");
    // CheckInternet.checkInternet(this);
    super.onInit();
  }

  getNewsByCategory(String categoryId,date, bool refresh) async {
    try {
      isLoadingGetCategoryDetail(true);
      isRefreshGetCategoryDetail(refresh);
      await apiRepositoryInterface.getNewsByCategory(categoryId, date).then((value) {
        getCategoryDetailsObj(value);
      });
    } finally {
      isLoadingGetCategoryDetail(false);
    }
  }
}
