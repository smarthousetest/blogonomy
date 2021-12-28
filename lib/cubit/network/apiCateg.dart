import 'dart:convert';
import 'package:blogonomy/cubit/network/auth_mode.dart';
import 'package:blogonomy/cubit/network/card_modelCateg.dart';
import 'package:blogonomy/screens/sliding_up_panel_screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:http/http.dart' as http;

import '../../main.dart';

class CardApi {
  Future<List<CardModel>> getCard() async {
    print("object");
    final response = await http.post(
        Uri.parse(
            'https://service-blogonomy.maksatlabs.ru/api/info/AboutCategories'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"public": true}));
    print("a");
    print(response.body);
    print("a");
    if (response.statusCode == 200) {
      final List<dynamic> cardJson = json.decode(response.body);
      return cardJson.map((json) => CardModel.fromJson(json)).toList();
    } else {
      throw Exception('Error fetching users');
    }
  }
}

class BlogersApi {
  Future<List<BlogersModel>> getBloger() async {
    print("запрос2");

    List<String>? id = filterModels.id?.map((e) => e.id).toList() ?? null;

    String minComments = filterModels.absoluteCommentsFilterMin ?? "";
    String maxComments = filterModels.absoluteCommentsFilterMax ?? "";

    String minLikes = filterModels.absoluteLikesFilterMin ?? "";
    String maxLikes = filterModels.absoluteLikesFilterMax ?? "";

    String minerr = filterModels.ermin ?? "";
    String maxerr = filterModels.ermax ?? "";

    String minnumFollowers = filterModels.numFollowersmin ?? "";
    String maxnumFollowers = filterModels.numFollowersmax ?? "";

    var body = {
      "size": 50,
      "page": 1,
      "categoryIds": id,
      "absoluteCommentsFilter": {"max": maxComments, "min": minComments},
      "absoluteLikesFilter": {"max": maxLikes, "min": minLikes},
      "erFilter": {"max": maxerr, "min": minerr},
      "numFollowersFilter": {"max": maxnumFollowers, "min": minnumFollowers}
    };

    if (filterModels.id?.isEmpty == true) {
      body.remove("categoryIds");
    }

    if (filterModels.absoluteCommentsFilterMax == "") {
      body.remove("absoluteCommentsFilter");
    }

    if (filterModels.absoluteLikesFilterMax == "") {
      body.remove("absoluteLikesFilter");
    }

    if (filterModels.ermax == "") {
      body.remove("erFilter");
    }

    if (filterModels.numFollowersmax == "") {
      body.remove("numFollowersFilter");
    }

    print("+++++++++++++++++++++++++");
    print(filterModels.id);
    print(filterModels.absoluteCommentsFilterMin);
    print(filterModels.absoluteCommentsFilterMax);
    print(filterModels.absoluteLikesFilterMin);
    print(filterModels.absoluteLikesFilterMax);
    print(filterModels.ermin);
    print(filterModels.ermax);
    print(filterModels.numFollowersmin);
    print(filterModels.numFollowersmax);
    print(id);
    print(minComments);
    print(maxComments);
    print(minLikes);
    print(maxLikes);
    print(minerr);
    print(maxerr);
    print(minnumFollowers);
    print(maxnumFollowers);
    print(json.encode(body));
    print("+++++++++++++++++++++++++");

    final response = await http.post(
        Uri.parse(
            'https://service-blogonomy.maksatlabs.ru/api/info/AboutBloggers'),
        headers: {"Content-Type": "application/json"},
        body: json.encode(body));

    if (response.statusCode == 200) {
      final List<dynamic> blogersJson = json.decode(response.body);
      return blogersJson.map((json) => BlogersModel.fromJson(json)).toList();
    } else {
      throw Exception('Error fetching blogers');
    }
  }
}

AuthApi authApi = AuthApi();
String? hash;

class AuthApi {
  Future<AuthModel> createMail(String mail) async {
    var error;
    print(mail);
    final response = await http.post(
        Uri.parse(
            "https://passport-blogonomy.maksatlabs.ru/api/Forgot/CheckEmail"),
        body: json.encode({
          "Email": mail,
        }),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        });

    print(response.statusCode);
    print("Auth api mail = $mail");
    if (response.statusCode == 200) {
      final String responseString = response.body;

      print(responseString);
      return authModelFromJson(responseString);
    } else {
      return error;
    }
  }

  Future<AuthModel> getCode(String mail) async {
    var error;
    print("Get code $mail");
    final response = await http.post(
        Uri.parse(
            "https://passport-blogonomy.maksatlabs.ru/api/Forgot/GetCode"),
        body: json.encode({
          "Email": mail,
        }),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        });
    Map<String, dynamic> responseJson = json.decode(response.body);

    hash = responseJson['hash'];
    print('Hash = $hash');

    print("body = ${response.body}");
    print(response.statusCode);
    if (response.statusCode == 200) {
      final String responseString = response.body;
      print("response string $responseString");
      return authModelFromJson(responseString);
    } else {
      return error;
    }
  }

  Future<AuthModel> setCode(String code) async {
    var error;

    print("hash 2 = $hash");
    print("code = $code");
    final response = await http.post(
        Uri.parse(
            "https://passport-blogonomy.maksatlabs.ru/api/Forgot/SetCode"),
        body: json.encode({"Code": code, "Hash": hash}),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        });
    Map<String, dynamic> responseJson = json.decode(response.body);
    hash = responseJson['hash'];
    print("body = ${response.body}");
    print(response.statusCode);
    if (response.statusCode == 200) {
      final String responseString = response.body;
      print("response string $responseString");
      return authModelFromJson(responseString);
    } else {
      return error;
    }
  }

  Future<AuthModel> setPassword(String password) async {
    var error;

    print("hash 3 = $hash");
    final response = await http.post(
        Uri.parse(
            "https://passport-blogonomy.maksatlabs.ru/api/Forgot/SetPassword"),
        body: json.encode({"Password": password, "Hash": hash}),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        });

    print("body = ${response.body}");
    print(response.statusCode);
    print("hash 4 = $hash");
    if (response.statusCode == 200) {
      final String responseString = response.body;
      print("response string $responseString");
      return authModelFromJson(responseString);
    } else {
      return error;
    }
  }
}

class FilterLoadApi {
  Future<FilterModel> getFilterLoad() async {
    print("Дошел1");
    List<String?>? id = filterModels.id?.map((e) => e.id).toList() ?? null;

    if (filterModels.id?.isEmpty == true) {
      id = null;
    }
    var body = {
      "Ids": id,
    };

    print("+++++++++++++++++++++++++");
    print(filterModels.id);
    print(id);
    print(json.encode(body));
    print("+++++++++++++++++++++++++");

    final response = await http.post(
        Uri.parse(
            'https://service-blogonomy.maksatlabs.ru/api/info/BloggerFilterExtremes'),
        headers: {"Content-Type": "application/json"},
        body: json.encode(body));
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      print("внутри");
      print(FilterModel.fromJson(json.decode(response.body)));

      return FilterModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error FilterLoadModel');
    }
  }
}

class OneBlogerApi {
  Future<OneBlogerModel> getBloger() async {
    late String? id = blogerFindModel.id;

    var body = {
      "id": id,
    };
    final response = await http.post(
        Uri.parse(
            'https://service-blogonomy.maksatlabs.ru/api/info/AboutBlogger'),
        headers: {"Content-Type": "application/json"},
        body: json.encode(body));

    print(response.body);
    if (response.statusCode == 200) {
      //  final List<dynamic> blogerJson = json.decode(response.body);
      return OneBlogerModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error fetching one blogger');
    }
  }
}
