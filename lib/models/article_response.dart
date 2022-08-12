import 'dart:convert';
import 'package:news/models/article.dart';


List<ArticleResponse> articleResponseFromJson(String str) =>
    List<ArticleResponse>.from(json.decode(str).map((x) => ArticleResponse.fromJson(x)));


class ArticleResponse {
  ArticleResponse({
    this.error,
    this.articles,
  });

  String? error;
  List<ArticleModel>? articles;

  factory ArticleResponse.fromJson(Map<String, dynamic> json) => ArticleResponse(
    error: json["error"],
    articles: List<ArticleModel>.from(
        json["articles"].map((x) => ArticleModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "articles": List<dynamic>.from(articles!.map((x) => x.toJson())),
  };
}