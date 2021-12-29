import 'package:blogonomy/cubit/network/admin_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    print("c = $c");
    print("state = $state");
    c = !c;
  }

  Future<void> checkOnAdmin(check) async {
    if (a < b) {
      //здесь если пользователь админ
      emit(AdminInState());
    }
    if (a > b) {
      //здесь если пользователь не админ
      emit(NoAdminState());
    }
  }
}
