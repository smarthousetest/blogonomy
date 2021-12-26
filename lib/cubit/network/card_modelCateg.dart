import 'dart:convert';
import 'package:blogonomy/cubit/panel_controller_cubit.dart';

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

class FilterModel {
  List<dynamic>? filter;

  FilterModel({this.filter}) {
    print("filter $filter");
  }

  factory FilterModel.fromJson(Map<String, dynamic> json) {
    var absoluteCommentsExtremesJson = json['absoluteCommentsExtremes'];
    var absoluteLikesExtremesJson = json['absoluteLikesExtremes'];
    var erExtremesJson = json['erExtremes'];
    var numFollowersExtremesJson = json['numFollowersExtremes'];

    List<dynamic> forlist = [];

    forlist.add(absoluteCommentsExtremesJson["min"]);

    forlist.add(absoluteCommentsExtremesJson["max"]);

    forlist.add(absoluteLikesExtremesJson["min"]);

    forlist.add(absoluteLikesExtremesJson["max"]);

    forlist.add(erExtremesJson["min"]);

    forlist.add(erExtremesJson["max"]);

    forlist.add(numFollowersExtremesJson["min"]);

    forlist.add(numFollowersExtremesJson["max"]);

    print("forlist $forlist");

    return FilterModel(filter: forlist);
  }
}

OneBlogerModel oneBlogerModelFromJson(String str) =>
    OneBlogerModel.fromJson(json.decode(str));

String oneBlogerModelToJson(OneBlogerModel data) => json.encode(data.toJson());

class OneBlogerModel {
  OneBlogerModel({
    this.id,
    this.instagramId,
    this.userName,
    this.fullName,
    this.picUrl,
    this.numFollowers,
    this.absoluteLikes,
    this.absoluteComments,
    this.er,
    this.location,
    this.hashtag,
    this.taggedUser,
  });

  String? id;
  String? instagramId;
  String? userName;
  String? fullName;
  String? picUrl;
  int? numFollowers;
  int? absoluteLikes;
  int? absoluteComments;
  double? er;
  Location? location;
  List<Hashtag>? hashtag;
  List<TaggedUser>? taggedUser;

  factory OneBlogerModel.fromJson(Map<String, dynamic> json) => OneBlogerModel(
        id: json["id"],
        instagramId: json["instagramId"],
        userName: json["userName"],
        fullName: json["fullName"],
        picUrl: json["picUrl"],
        numFollowers: json["numFollowers"],
        absoluteLikes: json["absoluteLikes"],
        absoluteComments: json["absoluteComments"],
        er: json["er"].toDouble(),
        location: Location.fromJson(json["location"]),
        hashtag:
            List<Hashtag>.from(json["hashtag"].map((x) => Hashtag.fromJson(x))),
        taggedUser: List<TaggedUser>.from(
            json["taggedUser"].map((x) => TaggedUser.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "instagramId": instagramId,
        "userName": userName,
        "fullName": fullName,
        "picUrl": picUrl,
        "numFollowers": numFollowers,
        "absoluteLikes": absoluteLikes,
        "absoluteComments": absoluteComments,
        "er": er,
        "location": location?.toJson(),
        "hashtag": List<dynamic>.from(hashtag!.map((x) => x.toJson())),
        "taggedUser": List<dynamic>.from(taggedUser!.map((x) => x.toJson())),
      };
}

class Hashtag {
  Hashtag({
    this.name,
    this.count,
  });

  String? name;
  int? count;

  factory Hashtag.fromJson(Map<String, dynamic> json) => Hashtag(
        name: json["name"],
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "count": count,
      };
}

class Location {
  Location({
    this.name,
    this.slag,
  });

  String? name;
  String? slag;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        name: json["name"],
        slag: json["slag"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "slag": slag,
      };
}

class TaggedUser {
  TaggedUser({
    this.name,
    this.coun,
  });

  String? name;
  int? coun;

  factory TaggedUser.fromJson(Map<String, dynamic> json) => TaggedUser(
        name: json["name"],
        coun: json["coun"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "coun": coun,
      };
}
