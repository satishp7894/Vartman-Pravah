class GetEPaper {
  bool? status;
  String? message;
  String? pdfPath;
  String? imgPath;
  List<EPaperDetails>? ePaperDetails;

  GetEPaper(
      {this.status,
        this.message,
        this.pdfPath,
        this.imgPath,
        this.ePaperDetails});

  GetEPaper.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    pdfPath = json['pdf_path'];
    imgPath = json['img_path'];
    if (json['EPaperDetails'] != null) {
      ePaperDetails = <EPaperDetails>[];
      json['EPaperDetails'].forEach((v) {
        ePaperDetails!.add(new EPaperDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['pdf_path'] = this.pdfPath;
    data['img_path'] = this.imgPath;
    if (this.ePaperDetails != null) {
      data['EPaperDetails'] =
          this.ePaperDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EPaperDetails {
  String? epaperId;
  String? epaperTitle;
  String? fileAttechments;
  String? date;
  String? paperImg;

  EPaperDetails(
      {this.epaperId,
        this.epaperTitle,
        this.fileAttechments,
        this.date,
        this.paperImg});

  EPaperDetails.fromJson(Map<String, dynamic> json) {
    epaperId = json['epaper_id'];
    epaperTitle = json['epaper_title'];
    fileAttechments = json['file_attechments'];
    date = json['date'];
    paperImg = json['paper_img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['epaper_id'] = this.epaperId;
    data['epaper_title'] = this.epaperTitle;
    data['file_attechments'] = this.fileAttechments;
    data['date'] = this.date;
    data['paper_img'] = this.paperImg;
    return data;
  }
}
