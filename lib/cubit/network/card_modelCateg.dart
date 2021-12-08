import 'dart:convert';

List<CardModel> cardModelFromJson(String str) =>
    List<CardModel>.from(json.decode(str).map((x) => CardModel.fromJson(x)));

String cardModelToJson(List<CardModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CardModel {
  CardModel({
    this.id,
    this.name,
    this.picUrl,
    this.numBloggers,
    this.bloggers,
  });

  String? id;
  String? name;
  String? picUrl;
  int? numBloggers;
  List<dynamic>? bloggers;

  factory CardModel.fromJson(Map<String, dynamic> json) => CardModel(
        id: json["id"],
        name: json["name"],
        picUrl: json["picUrl"],
        numBloggers: json["numBloggers"],
        bloggers: List<dynamic>.from(json["bloggers"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "picUrl": picUrl,
        "numBloggers": numBloggers,
        // "bloggers": List<dynamic>.from(bloggers.map((x) => x)),
      };
}

List<BlogersModel> blogerModelFromJson(String str) => List<BlogersModel>.from(
    json.decode(str).map((x) => BlogersModel.fromJson(x)));

String blogerModelToJson(List<BlogersModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BlogersModel {
  BlogersModel({
    this.id,
    this.userName,
    this.fullName,
    this.picUrl,
    this.er,
  });

  String? id;
  String? userName;
  String? fullName;
  String? picUrl;
  double? er;

  factory BlogersModel.fromJson(Map<String, dynamic> json) => BlogersModel(
        id: json["id"],
        userName: json["userName"],
        fullName: json["fullName"],
        picUrl: json["picUrl"],
        er: json["er"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userName": userName,
        "fullName": fullName,
        "picUrl": picUrl,
        "er": er,
      };
}
