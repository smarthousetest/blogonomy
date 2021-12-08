import 'dart:convert';
import 'package:blogonomy/cubit/network/card_modelCateg.dart';
import 'package:http/http.dart' as http;

import '../../main.dart';

class CardApi {
  Future<List<CardModel>> getCard() async {
    print("object");
    final response = await http.get(Uri.parse(
        'https://service-blogonomy.maksatlabs.ru/api/info/AboutCategories'));
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
    print("запрос");

    String id = filterModels.id ?? "";
    String minerr = filterModels.ermin ?? "";
    String maxerr = filterModels.ermax ?? "";

    var body = json.encode({
      "size": 8,
      "page": 1,
    });

    if (id != "") {
      body = json.encode({
        "size": 8,
        "page": 1,
        "categoryIds": [id]
      });
    }

    if (minerr != "" && maxerr != "") {
      body = json.encode({
        "size": 8,
        "page": 1,
        "filterEr": {"max": maxerr, "min": minerr}
      });
    }
    if (id != "" && minerr != "" && maxerr != "") {
      body = json.encode({
        "size": 8,
        "page": 1,
        "categoryIds": [id],
        "filterEr": {"max": maxerr, "min": minerr}
      });
    }

    print("+++++++++++++++++++++++++");
    print(filterModels.id);
    print(filterModels.ermin);
    print(filterModels.ermax);
    print(id);
    print(minerr);
    print(maxerr);
    print(body);
    print("+++++++++++++++++++++++++");

    final response = await http.post(
        Uri.parse(
            'https://service-blogonomy.maksatlabs.ru/api/info/AboutBloggers'),
        headers: {"Content-Type": "application/json"},
        body: body);

    if (response.statusCode == 200) {
      final List<dynamic> blogersJson = json.decode(response.body);
      return blogersJson.map((json) => BlogersModel.fromJson(json)).toList();
    } else {
      throw Exception('Error fetching blogers');
    }
  }
}
