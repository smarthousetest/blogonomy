import 'package:blogonomy/cubit/panel_controller_cubit.dart';
import 'package:blogonomy/screens/blogers_screens.dart';
import 'package:blogonomy/screens/popular_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/src/provider.dart';

class Blogers extends StatefulWidget {
  const Blogers({Key? key}) : super(key: key);
  @override
  State<Blogers> createState() => BlogerState();
}

class BlogerState extends State<Blogers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color(0xFFFFFFFF)),
                child: ListView(children: [
                  const SizedBox(height: 62.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Spacer(
                        flex: 1,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 25.0,
                        child: const Text(
                          'Блогеры',
                          style: TextStyle(
                            fontFamily: 'Roboto-Medium.ttf',
                            fontSize: 21.0,
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
                                context.read<SlidingUpCubit2>().open();
                              },
                              icon: SvgPicture.asset(
                                'assets/icons/filter.svg',
                                color: Colors.blue,
                                height: 50,
                                width: 50,
                              ))),
                      const SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                  const SizedBox(height: 34.0),
                  Container(
                    child: BlogersList(),
                  )
                ]))));
  }
}
