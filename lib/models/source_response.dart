import 'dart:convert';

import 'package:news/models/source.dart';


List<SourceResponse> sourceResponseFromJson(String str) =>
    List<SourceResponse>.from(json.decode(str).map((x) => SourceResponse.fromJson(x)));


class SourceResponse {
  SourceResponse({
    this.error,
    this.sources,
  });

  String? error;
  List<SourceModel>? sources;

  factory SourceResponse.fromJson(Map<String, dynamic> json) => SourceResponse(
    error: json["error"],
    sources: List<SourceModel>.from(
        json["sources"].map((x) => SourceModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "sources": List<dynamic>.from(sources!.map((x) => x.toJson())),
  };
}