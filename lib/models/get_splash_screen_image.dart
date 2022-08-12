class GetSlashScreenImage {
  bool? status;
  String? message;
  String? imgPath;
  List<FlashData>? flashData;

  GetSlashScreenImage(
      {this.status, this.message, this.imgPath, this.flashData});

  GetSlashScreenImage.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    imgPath = json['img_path'];
    if (json['FlashData'] != null) {
      flashData = <FlashData>[];
      json['FlashData'].forEach((v) {
        flashData!.add(new FlashData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['img_path'] = this.imgPath;
    if (this.flashData != null) {
      data['FlashData'] = this.flashData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FlashData {
  String? flashScreenId;
  String? flashImg;
  String? isActive;

  FlashData({this.flashScreenId, this.flashImg, this.isActive});

  FlashData.fromJson(Map<String, dynamic> json) {
    flashScreenId = json['flash_screen_id'];
    flashImg = json['flash_img'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['flash_screen_id'] = this.flashScreenId;
    data['flash_img'] = this.flashImg;
    data['is_active'] = this.isActive;
    return data;
  }
}
