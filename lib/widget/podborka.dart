import 'package:blogonomy/cubit/network/card_cubitCateg.dart';
import 'package:blogonomy/cubit/panel_controller_cubit.dart';
import 'package:blogonomy/main.dart';
import 'package:blogonomy/screens/blogers_screens.dart';
import 'package:blogonomy/screens/popular_tab.dart';
import 'package:blogonomy/widget/sliding_up/bloger_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/src/provider.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class Podborka extends StatefulWidget {
  const Podborka({Key? key}) : super(key: key);
  @override
  State<Podborka> createState() => PodborkaState();
}

class PodborkaState extends State<Podborka> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Stack(children: [
      Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: const Color(0xFFFFFFFF)),
          child: ListView(children: [
            const SizedBox(height: 42.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 10,
                ),
                Container(
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.chevron_left_outlined,
                          color: Color(0xFF0072FD),
                          size: 38,
                        ))),
                Spacer(
                  flex: 1,
                ),
                Container(
                  alignment: Alignment.center,
                  child: const Text(
                    'Блогеры',
                    style: TextStyle(
                      fontFamily: 'Roboto-Medium.ttf',
                      fontSize: 18.0,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF24282E),
                    ),
                  ),
                ),
                Spacer(
                  flex: 1,
                ),
                Container(
                    child: IconButton(
                  onPressed: () {
                    print("HEllol");
                    context.read<SlidingUpCubit4>().open();
                  },
                  icon: Icon(Icons.edit),
                  color: Colors.blue,
                )),
                const SizedBox(
                  width: 20,
                ),
              ],
            ),
            const SizedBox(height: 4.0),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 21.0),
              child: Container(
                child: Text("Тут блогеры из подборки"),
              ),
            )
          ])),
      SlidingUp4(),
    ])));
  }
}
