import 'package:blogonomy/cubit/panel_controller_cubit.dart';
import 'package:blogonomy/main.dart';
import 'package:blogonomy/screens/blogers_sliding.dart';
import 'package:blogonomy/widget/blogers.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class SlidingUp2 extends StatefulWidget {
  const SlidingUp2({Key? key}) : super(key: key);

  @override
  _SlidingUpState createState() => _SlidingUpState();
}

class _SlidingUpState extends State<SlidingUp2> {
  final PanelController pc = PanelController();
  @override
  Widget build(BuildContext context) {
    context.read<SlidingUpCubit2>().stream.listen((ev) {
      print("first $ev");
      if (ev is OpenState) {
        print("second $ev");
        pc.open();
      } else if (ev is CloseState) {
        pc.close();
      }
    });
    BorderRadiusGeometry radius = const BorderRadius.only(
      topLeft: Radius.circular(32.0),
      topRight: Radius.circular(32.0),
    );

    return SlidingUpPanel(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
      maxHeight: 300,
      minHeight: 0,
      backdropEnabled: true,
      controller: pc,
      panel: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              color: Colors.black,
            ),
            margin: const EdgeInsets.only(top: 8, bottom: 16),
            width: 118,
            height: 4,
          ),
          BlogersPanel(() {
            setState(() {
              pc.animatePanelToPosition(1);
            });
          }),
        ],
      ),
    );
  }
}
