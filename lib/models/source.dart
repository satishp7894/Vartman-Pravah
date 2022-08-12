class SourceModel {
  SourceModel({
    this.id,
    this.name,
    this.description,
    this.url,
    this.category,
    this.country,
    this.language,
  });

  final String? id;
  final String? name;
  final String? description;
  final String? url;
  final String? category;
  final String? country;
  final String? language;

  factory SourceModel.fromJson(Map<String, dynamic> json) => SourceModel(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    url: json["url"],
    category: json["category"],
    country: json["country"],
    language: json["language"],

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "url": url,
    "category": category,
    "country": country,
    "language": language,
  };
}
