class GetTodayNews {
  bool? status;
  String? message;
  String? imgPath;
  List<Newsdata>? newsdata;

  GetTodayNews({this.status, this.message, this.imgPath, this.newsdata});

  GetTodayNews.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    imgPath = json['imgPath'];
    if (json['newsdata'] != null) {
      newsdata = <Newsdata>[];
      json['newsdata'].forEach((v) {
        newsdata!.add(new Newsdata.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['imgPath'] = this.imgPath;
    if (this.newsdata != null) {
      data['newsdata'] = this.newsdata!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Newsdata {
  String? newsId;
  String? newsTitle;
  String? shortDescription;
  String? newsDate;
  String? image;
  String? videoUrl;
  String? categoryName;
  String? categoryId;

  Newsdata(
      {this.newsId,
        this.newsTitle,
        this.shortDescription,
        this.newsDate,
        this.image,
        this.videoUrl,
        this.categoryName,this.categoryId});

  Newsdata.fromJson(Map<String, dynamic> json) {
    newsId = json['news_id'];
    newsTitle = json['news_title'];
    shortDescription = json['short_description'];
    newsDate = json['news_date'];
    image = json['image'];
    videoUrl = json['video_url'];
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
    data['video_url'] = this.videoUrl;
    data['category_name'] = this.categoryName;
    data['category_id'] = this.categoryId;
    return data;
  }
}
