import 'dart:convert';

import 'package:blogonomy/cubit/network/admin_state.dart';
import 'package:blogonomy/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class AdminCubit extends Cubit<AdminState> {
  AdminCubit() : super(NoAdminState());
  var a, b;
  bool c = false;
  Future<void> setAdmin() async {
    if (c) {
      //здесь если пользователь админ
      emit(NoAdminState());
    } else {
      //здесь если пользователь не админ
      emit(AdminInState());
    }
    c = !c;
  }

  Future<void> checkOnAdmin(check) async {
    print("check in admin = $check");
    if (check == 'Admin') {
      //здесь если пользователь админ
      print("u are admin");
      emit(AdminInState());
    }
    if (check == 'User') {
      //здесь если пользователь не админ
      print("u are user");
      emit(NoAdminState());
    }
  }

  Future<void> deleteAdmin() async {
    late String? id = blogerFindModel.id;

    final response = await http.post(
        Uri.parse("https://service-blogonomy.maksatlabs.ru/api/Blogger/Delete"),
        body: json.encode({
          "ids": [id]
        }),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        });

    print(response.body);
  }

  Future<void> addAdmin(bloger) async {
    print("ploger = $bloger");
    final response = await http.post(
        Uri.parse("https://service-blogonomy.maksatlabs.ru/api/Blogger/Create"),
        body: json.encode({"userName": bloger}),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        });

    print(response.body);
  }

  Future<void> updateAdmin() async {
    final response = await http.post(
        Uri.parse("https://service-blogonomy.maksatlabs.ru/api/Blogger/Update"),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        });

    print(response.body);
  }
}
