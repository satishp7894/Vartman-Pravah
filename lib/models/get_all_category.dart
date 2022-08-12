class GetAllCategory {
  bool? status;
  String? message;
  String? iconPath;
  List<Newscategory>? newscategory;

  GetAllCategory({this.status, this.message, this.iconPath, this.newscategory});

  GetAllCategory.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    iconPath = json['icon-path'];
    if (json['newscategory'] != null) {
      newscategory = <Newscategory>[];
      json['newscategory'].forEach((v) {
        newscategory!.add(new Newscategory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['icon-path'] = this.iconPath;
    if (this.newscategory != null) {
      data['newscategory'] = this.newscategory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Newscategory {
  String? categoryId;
  String? categoryName;
  String? catIcon;

  Newscategory({this.categoryId, this.categoryName, this.catIcon});

  Newscategory.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    catIcon = json['cat_icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['category_name'] = this.categoryName;
    data['cat_icon'] = this.catIcon;
    return data;
  }
}
