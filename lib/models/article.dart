import 'dart:convert';

import 'package:news/models/source.dart';


// List<ArticleModel> cartFromJson(String str) =>
//     List<ArticleModel>.from(json.decode(str).map((x) => ArticleModel.fromJson(x)));

class ArticleModel {
  ArticleModel({
    // this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.img,
    this.date,
    this.content,
  });

  // final SourceModel? source;
  final String? author;
  final String? title;
  final String? description;
  final String? url;
  final String? img;
  final String? date;
  final String? content;

  factory ArticleModel.fromJson(Map<String, dynamic> json) => ArticleModel(
    // source: json["source"],
    author: json["author"],
    title: json["title"],
    description: json["description"],
    url: json["url"],
    img: json["img"],
    date: json["date"],
    content: json["content"],

  );

  Map<String, dynamic> toJson() => {
    // "source": source!.toJson(),
    "author": author,
    "title": title,
    "description": description,
    "url": url,
    "img": img,
    "date": date,
    "content": content,
  };
}