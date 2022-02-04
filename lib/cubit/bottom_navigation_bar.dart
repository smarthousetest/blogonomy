import 'package:blogonomy/cubit/network/app_auth.dart';
import 'package:blogonomy/cubit/network/auth_cubit.dart';
import 'package:blogonomy/cubit/network/auth_state.dart';
import 'package:blogonomy/cubit/panel_controller_cubit.dart';
import 'package:blogonomy/main.dart';
import 'package:blogonomy/widget/sliding_up/bloger_panel.dart';
import 'package:blogonomy/widget/sliding_up/sliding_up_panel.dart';
import 'package:flutter/animation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';

class BottomNavigationControllerSelect extends Cubit<int> {
  BottomNavigationControllerSelect() : super(0);

  void select(int index) {
    emit(index);
  }
}
