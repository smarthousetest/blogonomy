import 'dart:async';

import 'package:blogonomy/cubit/bottom_navigation_bar.dart';
import 'package:blogonomy/cubit/network/apiCateg.dart';
import 'package:blogonomy/cubit/network/auth_cubit.dart';
import 'package:blogonomy/cubit/network/card_cubitCateg.dart';

import 'package:blogonomy/cubit/panel_controller_cubit.dart';
import 'package:blogonomy/main.dart';
import 'package:blogonomy/screens/blogers_sliding.dart';
import 'package:blogonomy/widget/blogers.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

TextEditingController textEditingController = TextEditingController();
TextEditingController textEditingController2 = TextEditingController();

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
      if (ev is OpenState) {
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
      maxHeight: MediaQuery.of(context).size.height > 580
          ? 556
          : MediaQuery.of(context).size.height / 1.4,
      minHeight: 0,
      backdropEnabled: true,
      controller: pc,
      panelBuilder: (ScrollController sc) {
        return SingleChildScrollView(
          physics: MediaQuery.of(context).size.height > 580
              ? NeverScrollableScrollPhysics()
              : AlwaysScrollableScrollPhysics(),
          controller: sc,
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  color: Colors.black,
                ),
                margin: const EdgeInsets.only(top: 8, bottom: 18),
                width: 118,
                height: 4,
              ),
              BlogersPanel(),
            ],
          ),
        );
      },
    );
  }
}

class SlidingUp3 extends StatefulWidget {
  @override
  _SlidingUpState3 createState() => _SlidingUpState3();
}

class _SlidingUpState3 extends State<SlidingUp3> {
  final PanelController pc3 = PanelController();
  @override
  Widget build(BuildContext context) {
    context.read<SlidingUpCubit3>().stream.listen((ev) {
      print("first $ev");
      if (ev is OpenState) {
        print("second $ev");
        pc3.open();
      } else if (ev is CloseState) {
        pc3.close();
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
      maxHeight: MediaQuery.of(context).size.height > 540
          ? 260
          : MediaQuery.of(context).size.height / 1.4,
      minHeight: 0,
      backdropEnabled: true,
      controller: pc3,
      panelBuilder: (ScrollController sc) {
        return SingleChildScrollView(
          controller: sc,
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  color: Colors.black,
                ),
                margin: const EdgeInsets.only(top: 8, bottom: 18),
                width: 118,
                height: 4,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: Column(
                  children: [
                    Form(
                      child: TextFormField(
                        controller: textEditingController,
                        decoration: const InputDecoration(
                          hintText: 'Название подборки',
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
                    const SizedBox(height: 16),
                    ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ))),
                        onPressed: () async {
                          showAlertDialog(context);
                          String name = textEditingController.text;

                          String? idpodborka =
                              await Podborka().create(name, false);

                          String? createpodborka =
                              await Podborka().setbloggers(idpodborka!);

                          context.read<SlidingUpCubit2>().close();
                          context.read<SlidingUpCubit3>().close();

                          context
                              .read<BottomNavigationControllerSelect>()
                              .select(0);
                          Navigator.pop(context);
                          AuthCubit().GetCategoryUser();
                        },
                        child: const SizedBox(
                          height: 52,
                          child: Center(child: Text('Сохранить')),
                        )),
                    const SizedBox(height: 16),
                    ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ))),
                        onPressed: () {
                          context.read<SlidingUpCubit3>().close();
                        },
                        child: const SizedBox(
                          height: 52,
                          child: Center(child: Text('Назад')),
                        )),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class SlidingUp4 extends StatefulWidget {
  @override
  _SlidingUpState4 createState() => _SlidingUpState4();
}

class _SlidingUpState4 extends State<SlidingUp4> {
  final PanelController pc4 = PanelController();
  @override
  Widget build(BuildContext context) {
    context.read<SlidingUpCubit4>().stream.listen((ev) {
      print("first $ev");
      if (ev is OpenState) {
        print("second $ev");
        pc4.open();
      } else if (ev is CloseState) {
        pc4.close();
      }
    });
    BorderRadiusGeometry radius = const BorderRadius.only(
      topLeft: Radius.circular(32.0),
      topRight: Radius.circular(32.0),
    );

    textEditingController2.text = filterModels.id![0].name;

    return SlidingUpPanel(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
      maxHeight: MediaQuery.of(context).size.height > 540
          ? 280
          : MediaQuery.of(context).size.height / 1.5,
      minHeight: 0,
      backdropEnabled: true,
      controller: pc4,
      panelBuilder: (ScrollController sc) {
        return SingleChildScrollView(
          controller: sc,
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  color: Colors.black,
                ),
                margin: const EdgeInsets.only(top: 8, bottom: 18),
                width: 118,
                height: 4,
              ),
              Container(
                padding: EdgeInsets.only(left: 20, right: 21),
                child: Column(
                  children: [
                    Form(
                      child: TextFormField(
                        controller: textEditingController2,
                        decoration: const InputDecoration(
                          hintText: 'Новое имя подборки',
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
                    const SizedBox(height: 16),
                    ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ))),
                        onPressed: () async {
                          String name = textEditingController2.text;

                          String? updatepodborka = await Podborka()
                              .update(filterModels.id![0].id, name, false);

                          textEditingController2.text = "";

                          context.read<SlidingUpCubit4>().close();
                          Navigator.pop(context);
                          filterModels.clearAll();

                          podborkaBool.public = false;
                          CardCubit2 cardCubit2 = context.read<CardCubit2>();
                          cardCubit2.fetchCard();
                        },
                        child: const SizedBox(
                          height: 52,
                          child: Center(child: Text('Изменить')),
                        )),
                    const SizedBox(height: 16),
                    ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ))),
                        onPressed: () async {
                          String? deletepodborka =
                              await Podborka().delete(filterModels.id![0].id);

                          context.read<SlidingUpCubit4>().close();
                          Navigator.pop(context);
                          filterModels.clearAll();

                          podborkaBool.public = false;
                          CardCubit2 cardCubit2 = context.read<CardCubit2>();
                          cardCubit2.fetchCard();
                        },
                        child: const SizedBox(
                          height: 52,
                          child: Center(child: Text('Удалить подборку')),
                        )),
                    const SizedBox(height: 16),
                    Text(
                      'Дата создания: ${filterModels.date}',
                      style: TextStyle(
                        fontFamily: 'Roboto-Bold.ttf',
                        fontSize: 12.0,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

showAlertDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: Container(
        height: 100,
        width: 100,
        child: Center(child: CircularProgressIndicator())),
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
