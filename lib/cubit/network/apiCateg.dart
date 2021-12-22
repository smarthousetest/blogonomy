import 'dart:convert';
import 'package:blogonomy/cubit/network/card_modelCateg.dart';
import 'package:http/http.dart' as http;

import '../../main.dart';

class CardApi {
  Future<List<CardModel>> getCard() async {
    print("object");
    final response = await http.post(
        Uri.parse(
            'https://service-blogonomy.maksatlabs.ru/api/info/AboutCategories'),
        headers: {"Content-Type": "application/json"});
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

    var body = {
      "size": 50,
      "page": 1,
      "categoryIds": id,
      "absoluteCommentsFilter": {"max": maxComments, "min": minComments},
      "absoluteLikesFilter": {"max": maxLikes, "min": minLikes},
      "erFilter": {"max": maxerr, "min": minerr}
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

    print("+++++++++++++++++++++++++");
    print(filterModels.id);
    print(filterModels.absoluteCommentsFilterMin);
    print(filterModels.absoluteCommentsFilterMax);
    print(filterModels.absoluteLikesFilterMin);
    print(filterModels.absoluteLikesFilterMax);
    print(filterModels.ermin);
    print(filterModels.ermax);
    print(id);
    print(minComments);
    print(maxComments);
    print(minLikes);
    print(maxLikes);
    print(minerr);
    print(maxerr);
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
