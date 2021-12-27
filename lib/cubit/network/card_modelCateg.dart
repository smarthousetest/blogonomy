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
    this.sexRatio,
    this.ageGroupRatio,
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
  SexRatio? sexRatio;
  Map<String, int>? ageGroupRatio;

  factory OneBlogerModel.fromJson(Map<String, dynamic> json) => OneBlogerModel(
        id: json["id"] == null ? null : json["id"],
        instagramId: json["instagramId"] == null ? null : json["instagramId"],
        userName: json["userName"] == null ? null : json["userName"],
        fullName: json["fullName"] == null ? null : json["fullName"],
        picUrl: json["picUrl"] == null ? null : json["picUrl"],
        numFollowers:
            json["numFollowers"] == null ? null : json["numFollowers"],
        absoluteLikes:
            json["absoluteLikes"] == null ? null : json["absoluteLikes"],
        absoluteComments:
            json["absoluteComments"] == null ? null : json["absoluteComments"],
        er: json["er"] == null ? null : json["er"].toDouble(),
        location: json["location"] == null
            ? null
            : Location.fromJson(json["location"]),
        hashtag: json["hashtag"] == null
            ? null
            : List<Hashtag>.from(
                json["hashtag"].map((x) => Hashtag.fromJson(x))),
        taggedUser: json["taggedUser"] == null
            ? null
            : List<TaggedUser>.from(
                json["taggedUser"].map((x) => TaggedUser.fromJson(x))),
        sexRatio: json["sexRatio"] == null
            ? null
            : SexRatio.fromJson(json["sexRatio"]),
        ageGroupRatio: json["ageGroupRatio"] == null
            ? null
            : Map.from(json["ageGroupRatio"])
                .map((k, v) => MapEntry<String, int>(k, v)),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "instagramId": instagramId == null ? null : instagramId,
        "userName": userName == null ? null : userName,
        "fullName": fullName == null ? null : fullName,
        "picUrl": picUrl == null ? null : picUrl,
        "numFollowers": numFollowers == null ? null : numFollowers,
        "absoluteLikes": absoluteLikes == null ? null : absoluteLikes,
        "absoluteComments": absoluteComments == null ? null : absoluteComments,
        "er": er == null ? null : er,
        "location": location == null ? null : location?.toJson(),
        "hashtag": hashtag == null
            ? null
            : List<dynamic>.from(hashtag!.map((x) => x.toJson())),
        "taggedUser": taggedUser == null
            ? null
            : List<dynamic>.from(taggedUser!.map((x) => x.toJson())),
        "sexRatio": sexRatio == null ? null : sexRatio?.toJson(),
        "ageGroupRatio": ageGroupRatio == null
            ? null
            : Map.from(ageGroupRatio!)
                .map((k, v) => MapEntry<String, dynamic>(k, v)),
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
        name: json["name"] == null ? null : json["name"],
        count: json["count"] == null ? null : json["count"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "count": count == null ? null : count,
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
        name: json["name"] == null ? null : json["name"],
        slag: json["slag"] == null ? null : json["slag"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "slag": slag == null ? null : slag,
      };
}

class SexRatio {
  SexRatio({
    this.men,
    this.women,
  });

  int? men;
  int? women;

  factory SexRatio.fromJson(Map<String, dynamic> json) => SexRatio(
        men: json["men"] == null ? null : json["men"],
        women: json["women"] == null ? null : json["women"],
      );

  Map<String, dynamic> toJson() => {
        "men": men == null ? null : men,
        "women": women == null ? null : women,
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
        name: json["name"] == null ? null : json["name"],
        coun: json["coun"] == null ? null : json["coun"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "coun": coun == null ? null : coun,
      };
}
