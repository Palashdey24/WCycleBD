class NewsModel {
  NewsModel({
    this.newsStatus,
    this.linkType,
    this.newsTittle,
    this.newsLink,
    this.ltSrc,
    this.userId,
    this.newsDescription,
  });

  NewsModel.fromJson(dynamic json) {
    newsStatus = json['newsStatus'] ?? false;
    linkType = json['linkType'] ?? "";
    newsTittle = json['newsTittle'] ?? "N/A";
    newsLink = json['newsLink'] ?? "N/A";
    ltSrc = json['ltSrc'] ?? "N/A";
    userId = json['userId'] ?? "N/A";
    newsDescription = json['newsDescription'] ?? "N/A";
  }
  bool? newsStatus;
  String? linkType;
  String? newsTittle;
  String? newsLink;
  String? ltSrc;
  String? userId;
  String? newsDescription;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['newsStatus'] = newsStatus;
    map['linkType'] = linkType;
    map['newsTittle'] = newsTittle;
    map['newsLink'] = newsLink;
    map['ltSrc'] = ltSrc;
    map['userId'] = userId;
    map['newsDescription'] = newsDescription;
    return map;
  }
}
