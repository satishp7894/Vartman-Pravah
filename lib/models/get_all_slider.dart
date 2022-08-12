class GetAllSlider {
  bool? status;
  String? message;
  String? imgPath;
  List<SliderData>? sliderData;

  GetAllSlider({this.status, this.message, this.imgPath, this.sliderData});

  GetAllSlider.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    imgPath = json['imgPath'];
    if (json['sliderData'] != null) {
      sliderData = <SliderData>[];
      json['sliderData'].forEach((v) {
        sliderData!.add(new SliderData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['imgPath'] = this.imgPath;
    if (this.sliderData != null) {
      data['sliderData'] = this.sliderData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SliderData {
  String? sliderId;
  String? sliderImage;
  String? sliderTitle;
  String? shortDescription;
  String? position;

  SliderData(
      {this.sliderId,
        this.sliderImage,
        this.sliderTitle,
        this.shortDescription,
        this.position});

  SliderData.fromJson(Map<String, dynamic> json) {
    sliderId = json['slider_id'];
    sliderImage = json['slider_image'];
    sliderTitle = json['slider_title'];
    shortDescription = json['short_description'];
    position = json['position'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['slider_id'] = this.sliderId;
    data['slider_image'] = this.sliderImage;
    data['slider_title'] = this.sliderTitle;
    data['short_description'] = this.shortDescription;
    data['position'] = this.position;
    return data;
  }
}
