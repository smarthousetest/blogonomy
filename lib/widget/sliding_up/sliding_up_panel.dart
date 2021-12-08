import 'dart:ui';

import 'package:blogonomy/cubit/panel_controller_cubit.dart';
import 'package:blogonomy/main.dart';
import 'package:blogonomy/screens/sliding_up_panel_screens.dart';
import 'package:blogonomy/widget/collections.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class SlidingUp extends StatefulWidget {
  const SlidingUp({Key? key}) : super(key: key);

  @override
  _SlidingUpState createState() => _SlidingUpState();
}

class _SlidingUpState extends State<SlidingUp> {
  final PanelController panelController = PanelController();
  @override
  Widget build(BuildContext context) {
    context.read<SlidingUpCubit>().stream.listen((ev) {
      print("first $ev");
      if (ev is OpenState) {
        print("second $ev");
        panelController.open();
        print(panelController.isPanelOpen);
      } else if (ev is CloseState) {
        print("third $ev");
        panelController.close();
      }
    });
    BorderRadiusGeometry radius = const BorderRadius.only(
      topLeft: Radius.circular(32.0),
      topRight: Radius.circular(32.0),
    );

    return SlidingUpPanel(
        controller: panelController,
        maxHeight: 300,
        minHeight: 0,
        backdropColor: Colors.black,
        borderRadius: radius,
        panel: const Sliding(),
        body: MyHomePage());
  }
}
