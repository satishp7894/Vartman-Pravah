import 'package:news/models/get_today_news.dart';

class GetNewsByCategory {
  bool? status;
  String? message;
  String? imgPath;
  List<Newsdata>? newsdata;
  String? nextCategoryName;
  List<Nextdata>? nextdata;

  GetNewsByCategory(
      {this.status, this.message, this.imgPath, this.newsdata,this.nextCategoryName, this.nextdata});

  GetNewsByCategory.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    imgPath = json['img_path'];
    if (json['newsdata'] != null) {
      newsdata = <Newsdata>[];
      json['newsdata'].forEach((v) {
        newsdata!.add(new Newsdata.fromJson(v));
      });
    }
    nextCategoryName = json['next_cat_name'];
    if (json['nextdata'] != null) {
      nextdata = <Nextdata>[];
      json['nextdata'].forEach((v) {
        nextdata!.add(new Nextdata.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['img_path'] = this.imgPath;
    if (this.newsdata != null) {
      data['newsdata'] = this.newsdata!.map((v) => v.toJson()).toList();
    }
    data['next_cat_name'] = this.nextCategoryName;
    if (this.nextdata != null) {
      data['nextdata'] = this.nextdata!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}



class Nextdata {
  String? newsId;
  String? newsTitle;
  String? shortDescription;
  String? newsDate;
  String? image;
  String? categoryName;
  String? categoryId;

  Nextdata(
      {this.newsId,
        this.newsTitle,
        this.shortDescription,
        this.newsDate,
        this.image,
        this.categoryName,
        this.categoryId});

  Nextdata.fromJson(Map<String, dynamic> json) {
    newsId = json['news_id'];
    newsTitle = json['news_title'];
    shortDescription = json['short_description'];
    newsDate = json['news_date'];
    image = json['image'];
    categoryName = json['category_name'];
    categoryId = json['category_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['news_id'] = this.newsId;
    data['news_title'] = this.newsTitle;
    data['short_description'] = this.shortDescription;
    data['news_date'] = this.newsDate;
    data['image'] = this.image;
    data['category_name'] = this.categoryName;
    data['category_id'] = this.categoryId;
    return data;
  }
}
