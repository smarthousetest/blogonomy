import 'dart:convert';

<<<<<<< HEAD
import 'package:blogonomy/cubit/panel_controller_cubit.dart';

=======
>>>>>>> 50d9cf1265dc3f4d79fd3d70e05476ded861adcf
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
  });

  String? id;
  String? name;
  String? picUrl;
  int? numBloggers;

  factory CardModel.fromJson(Map<String, dynamic> json) => CardModel(
        id: json["id"],
        name: json["name"],
        picUrl: json["picUrl"],
        numBloggers: json["numBloggers"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "picUrl": picUrl,
        "numBloggers": numBloggers,
      };
}

List<BlogersModel> blogersModelFromJson(String str) => List<BlogersModel>.from(
    json.decode(str).map((x) => BlogersModel.fromJson(x)));

String blogersModelToJson(List<BlogersModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BlogersModel {
  BlogersModel({
    this.id,
    this.userName,
    this.fullName,
    this.picUrl,
    this.numFollowers,
    this.absoluteLikes,
    this.absoluteComments,
    this.er,
  });

  String? id;
  String? userName;
  String? fullName;
  String? picUrl;
  int? numFollowers;
  int? absoluteLikes;
  int? absoluteComments;
  double? er;

  factory BlogersModel.fromJson(Map<String, dynamic> json) => BlogersModel(
        id: json["id"],
        userName: json["userName"],
        fullName: json["fullName"],
        picUrl: json["picUrl"],
        numFollowers: json["numFollowers"],
        absoluteLikes: json["absoluteLikes"],
        absoluteComments: json["absoluteComments"],
        er: json["er"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userName": userName,
        "fullName": fullName,
        "picUrl": picUrl,
        "numFollowers": numFollowers,
        "absoluteLikes": absoluteLikes,
        "absoluteComments": absoluteComments,
        "er": er,
      };
}
<<<<<<< HEAD

class FilterModel {
  List<dynamic>? filter;

  FilterModel({this.filter}) {
    print("filter $filter");
  }

  factory FilterModel.fromJson(Map<String, dynamic> json) {
    var absoluteCommentsExtremesJson = json['absoluteCommentsExtremes'];
    var absoluteLikesExtremesJson = json['absoluteLikesExtremes'];
    var erExtremesJson = json['erExtremes'];

    List<dynamic> forlist = [];

    forlist.add(absoluteCommentsExtremesJson["min"]);

    forlist.add(absoluteCommentsExtremesJson["max"]);

    forlist.add(absoluteLikesExtremesJson["min"]);

    forlist.add(absoluteLikesExtremesJson["max"]);

    forlist.add(erExtremesJson["min"]);

    forlist.add(erExtremesJson["max"]);

    print("forlist $forlist");

    return FilterModel(filter: forlist);
  }
}
=======
>>>>>>> 50d9cf1265dc3f4d79fd3d70e05476ded861adcf
