<<<<<<< HEAD
import 'package:blogonomy/cubit/network/card_cubitCateg.dart';
import 'package:blogonomy/cubit/panel_controller_cubit.dart';
import 'package:blogonomy/main.dart';
=======
import 'package:blogonomy/cubit/panel_controller_cubit.dart';
>>>>>>> 50d9cf1265dc3f4d79fd3d70e05476ded861adcf
import 'package:blogonomy/screens/blogers_screens.dart';
import 'package:blogonomy/screens/popular_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/src/provider.dart';
<<<<<<< HEAD
import 'package:multi_select_flutter/multi_select_flutter.dart';
=======
>>>>>>> 50d9cf1265dc3f4d79fd3d70e05476ded861adcf

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
<<<<<<< HEAD
                  const SizedBox(height: 42.0),
=======
                  const SizedBox(height: 62.0),
>>>>>>> 50d9cf1265dc3f4d79fd3d70e05476ded861adcf
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
<<<<<<< HEAD
=======
                        height: 25.0,
>>>>>>> 50d9cf1265dc3f4d79fd3d70e05476ded861adcf
                        child: const Text(
                          'Блогеры',
                          style: TextStyle(
                            fontFamily: 'Roboto-Medium.ttf',
<<<<<<< HEAD
                            fontSize: 18.0,
=======
                            fontSize: 21.0,
>>>>>>> 50d9cf1265dc3f4d79fd3d70e05476ded861adcf
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
<<<<<<< HEAD
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 21.0),
                    child: TextFormField(
                      //  readOnly: true,
                      decoration: const InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                        hintText: 'Поиск',
                        prefixIcon: Icon(Icons.search),
                        hintStyle: TextStyle(
                          fontFamily: 'Roboto-Regular.ttf',
                          fontSize: 15.0,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFFADB3BD),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFFADB3BD), width: 1.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(32.0))),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFFADB3BD), width: 1.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(32.0))),
                      ),
                    ),
                  ),
                  const SizedBox(height: 4.0),
=======
                  const SizedBox(height: 34.0),
>>>>>>> 50d9cf1265dc3f4d79fd3d70e05476ded861adcf
                  Container(
                    child: BlogersList(),
                  )
                ]))));
  }
}
