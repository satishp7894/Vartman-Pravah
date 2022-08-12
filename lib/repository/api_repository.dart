


import 'package:news/models/get_all_category.dart';
import 'package:news/models/get_all_slider.dart';
import 'package:news/models/get_e_paper.dart';
import 'package:news/models/get_news_details.dart';
import 'package:news/models/get_splash_screen_image.dart';
import 'package:news/models/get_today_news.dart';
import 'package:news/models/news_by_category.dart';

abstract class ApiRepositoryInterface {

  Future<GetSlashScreenImage?> getSlashImage();
  Future<GetAllSlider?> getSlider();
  Future<GetNewsDetails?> getNewsDetails(String newsId);
  Future<GetTodayNews?> getTodayNews();
  Future<GetAllCategory?> getCategory();
  Future<GetEPaper?> ePaper(String date);
  Future<GetNewsByCategory?> getNewsByCategory(String categoryId, date);
  // Future<ArticleResponse?> getSourceNews(String sourceId);


}
