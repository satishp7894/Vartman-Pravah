// import 'package:dio/dio.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:news/constants/app_costants.dart';
import 'package:news/models/get_all_category.dart';
import 'package:news/models/get_all_slider.dart';
import 'package:news/models/get_e_paper.dart';
import 'package:news/models/get_news_details.dart';
import 'package:news/models/get_splash_screen_image.dart';
import 'package:news/models/get_today_news.dart';
import 'package:news/models/news_by_category.dart';
import 'package:news/repository/api_repository.dart';

class ApiRepositoryImpl extends ApiRepositoryInterface {
  static var client = http.Client();

  // final Dio _dio = Dio();
  static String mainUrls = "https://newsapi.org/v2/";
  static String mainUrl = "https://proactii.com/VartmanPravah/Api/NewsApi/";
  final String apiKey = "79d8d218f0f74cfa947f481fa20d9b1f";
  final String secretKey = "nE18wQkXjb@0!0&1";

  var getSourcesUrl = '$mainUrls/sources';
  var getTopHeadlinesUrl = '$mainUrls/top-headlines';
  var everythingUrl = "$mainUrls/everything";


  //

  // var getSourcesUrl = '$mainUrl/sources';
  // var getTopHeadlinesUrl = '$mainUrl/top-headlines';
  var allTodayNews = "$mainUrl/getAllTodayNews";
  var allSlider = "$mainUrl/getAllSlider";
  var newsDetail = "$mainUrl/getNewsDetail";
  var allNewscategory = "$mainUrl/getAllNewscategory";
  var dateWisePaper = "$mainUrl/getDateWisePaper/";
  var newsByCategory = "$mainUrl/getNewsByCategory";
  var getFlashScreenImage = "$mainUrl/getFlashScreenImage";

  @override
  Future<GetSlashScreenImage?> getSlashImage() async {

    print("url getSlashImage $getFlashScreenImage");
    print("url getSlashImage $secretKey");
    try {
      var response = await http.post(Uri.parse(getFlashScreenImage), body: {
        'secret_key': secretKey,
      });

      var decodedData = json.decode(response.body);
      print("decodedData['status'] ${decodedData['status']}");
      if (decodedData['status'] == true) {
        print("getSlashImage ${response.body}");
        return GetSlashScreenImage.fromJson(decodedData);
      } else {
        print("getSlashImage else");
        return GetSlashScreenImage.fromJson(decodedData);
      }
    } on Exception catch (e) {
      print("getSlashImage error ${e}");
      return GetSlashScreenImage(message: e.toString());
    }
  }

  @override
  Future<GetAllSlider?> getSlider() async {
    print("url getSlider $allSlider");
    print("url getSlider $secretKey");

    bool result = await InternetConnectionChecker().hasConnection;
    if(result == true){
    try {
      var response = await http.post(Uri.parse(allSlider), body: {
        'secret_key': secretKey,
      });

      var decodedData = json.decode(response.body);
      print("decodedData['status'] ${decodedData['status']}");
      if (decodedData['status'] == true) {
        print("getSlider ${response.body}");
        return GetAllSlider.fromJson(decodedData);
      } else {
        print("getSlider else");
        return GetAllSlider.fromJson(decodedData);
      }
    } on Exception catch (e) {
      print("getSlider error ${e}");
      return GetAllSlider(status : false,message: e.toString());
    }}else{
      return GetAllSlider(status : false,message: AppConstants.noInternetConn);
    }
  }

  @override
  Future<GetTodayNews?> getTodayNews() async {
    print("url getTodayNews $allTodayNews");
    print("url getTodayNews $secretKey");

    bool result = await InternetConnectionChecker().hasConnection;
    if(result == true){
    try {
      var response = await http.post(Uri.parse(allTodayNews), body: {
        'secret_key': secretKey,
      });
      var decodedData = json.decode(response.body);
      print("decodedData['status'] ${decodedData['status']}");
      if (decodedData['status'] == true) {
        print("getAllTodayNews ${response.body}");
        return GetTodayNews.fromJson(decodedData);
      } else {
        print("getAllTodayNews else");
        return GetTodayNews.fromJson(decodedData);
      }
    } on Exception catch (e) {
      print("getAllTodayNews error ${e}");
      return GetTodayNews(status : false, message: e.toString());
    }}else{
      return GetTodayNews(status : false, message: AppConstants.noInternetConn);
    }
  }

  @override
  Future<GetNewsDetails?> getNewsDetails(String newsId) async {
    print("url getNewsDetails $newsDetail");
    print("url getNewsDetails $secretKey");
    print("url getNewsDetails $newsId");

    bool result = await InternetConnectionChecker().hasConnection;
    if(result == true){
    try {
      var response = await http.post(Uri.parse(newsDetail), body: {
        'secret_key': secretKey,
        'news_id': newsId,
      });
      var decodedData = json.decode(response.body);
      print("decodedData['status'] ${decodedData['status']}");
      if (decodedData['status'] == true) {
        print("getNewsDetails ${response.body}");
        return GetNewsDetails.fromJson(decodedData);
      } else {
        print("getNewsDetails else");
        return GetNewsDetails.fromJson(decodedData);
      }
    } on Exception catch (e) {
      print("getNewsDetails error ${e}");
      return GetNewsDetails(status : false,message: e.toString());
    }}else{
      return GetNewsDetails(status : false,message: AppConstants.noInternetConn);
    }
  }

  @override
  Future<GetAllCategory?> getCategory() async {
    print("url getCategory $allNewscategory");
    print("url getCategory $secretKey");

    bool result = await InternetConnectionChecker().hasConnection;
    if(result == true){
    try {
      var response = await http.post(Uri.parse(allNewscategory), body: {
        'secret_key': secretKey,
      });
      var decodedData = json.decode(response.body);
      print("decodedData['status'] ${decodedData['status']}");
      if (decodedData['status'] == true) {
        print("getCategory ${response.body}");
        return GetAllCategory.fromJson(decodedData);
      } else {
        print("getCategory else");
        return GetAllCategory.fromJson(decodedData);
      }
    }  on Exception catch (e) {
      print("getCategory error ${e}");
      return GetAllCategory(status : false,message: e.toString());
    }}else{
      return GetAllCategory(status : false,message: AppConstants.noInternetConn);
    }
  }

  @override
  Future<GetEPaper?> ePaper(String date) async {
    print("url ePaper $dateWisePaper");
    print("url ePaper $secretKey");
    print("url ePaper $date");

    bool result = await InternetConnectionChecker().hasConnection;
    if(result == true){
    try {
      var response = await http.post(Uri.parse(dateWisePaper), body: {
        'secret_key': secretKey,
        'date': date,
      });
      var decodedData = json.decode(response.body);
      print("decodedData['status'] ${decodedData['status']}");
      if (decodedData['status'] == true) {
        print("getCategory ${response.body}");
        return GetEPaper.fromJson(decodedData);
      } else {
        print("getCategory else");
        return GetEPaper.fromJson(decodedData);
      }
    } on Exception catch (e) {
      print("getCategory error ${e}");
      return GetEPaper(status : false, message: e.toString());
    }}else{
      return GetEPaper(status : false, message: AppConstants.noInternetConn);
    }
  }

  @override
  Future<GetNewsByCategory?> getNewsByCategory(String categoryId, date) async {
    print("url getNewsByCategory $newsByCategory");
    print("url getNewsByCategory $secretKey");
    print("url getNewsByCategory $categoryId");
    print("url getNewsByCategory $date");

    bool result = await InternetConnectionChecker().hasConnection;
    if(result == true){
    try {
      var response = await http.post(Uri.parse(newsByCategory), body: {
        'secret_key': secretKey,
        'date': date,
        'category_id': categoryId,
      });
      var decodedData = json.decode(response.body);
      print("decodedData['status'] ${decodedData['status']}");
      if (decodedData['status'] == true) {
        print("getNewsByCategory ${response.body}");
        return GetNewsByCategory.fromJson(decodedData);
      } else {
        // print("getNewsByCategory else");
        return GetNewsByCategory.fromJson(decodedData);
      }
    } on Exception catch (e) {
      print("getNewsByCategory error ${e}");
      return GetNewsByCategory(status : false,message: e.toString());
    }}else{
      return GetNewsByCategory(status : false,message: AppConstants.noInternetConn);
    }
  }
}
