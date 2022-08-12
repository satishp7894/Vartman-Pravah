class GetNewsDetails {
  bool? status;
  String? message;
  String? imgPath;
  List<NewsDetails>? newsDetails;

  GetNewsDetails({this.status, this.message, this.imgPath, this.newsDetails});

  GetNewsDetails.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    imgPath = json['imgPath'];
    if (json['newsDetails'] != null) {
      newsDetails = <NewsDetails>[];
      json['newsDetails'].forEach((v) {
        newsDetails!.add(new NewsDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['imgPath'] = this.imgPath;
    if (this.newsDetails != null) {
      data['newsDetails'] = this.newsDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NewsDetails {
  String? newsId;
  String? newsTitle;
  Null? shortCode;
  String? description;
  String? shortDescription;
  String? newsDate;
  String? categoryId;
  String? image;
  String? isActive;
  String? createdBy;
  String? modifiedBy;
  String? created;
  String? modified;
  String? categoryName;

  NewsDetails(
      {this.newsId,
        this.newsTitle,
        this.shortCode,
        this.description,
        this.shortDescription,
        this.newsDate,
        this.categoryId,
        this.image,
        this.isActive,
        this.createdBy,
        this.modifiedBy,
        this.created,
        this.modified,
        this.categoryName});

  NewsDetails.fromJson(Map<String, dynamic> json) {
    newsId = json['news_id'];
    newsTitle = json['news_title'];
    shortCode = json['short_code'];
    description = json['description'];
    shortDescription = json['short_description'];
    newsDate = json['news_date'];
    categoryId = json['category_id'];
    image = json['image'];
    isActive = json['is_active'];
    createdBy = json['created_by'];
    modifiedBy = json['modified_by'];
    created = json['created'];
    modified = json['modified'];
    categoryName = json['category_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['news_id'] = this.newsId;
    data['news_title'] = this.newsTitle;
    data['short_code'] = this.shortCode;
    data['description'] = this.description;
    data['short_description'] = this.shortDescription;
    data['news_date'] = this.newsDate;
    data['category_id'] = this.categoryId;
    data['image'] = this.image;
    data['is_active'] = this.isActive;
    data['created_by'] = this.createdBy;
    data['modified_by'] = this.modifiedBy;
    data['created'] = this.created;
    data['modified'] = this.modified;
    data['category_name'] = this.categoryName;
    return data;
  }
}
