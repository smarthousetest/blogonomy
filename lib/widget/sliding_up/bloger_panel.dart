<<<<<<< HEAD
import 'package:blogonomy/cubit/bottom_navigation_bar.dart';
=======
>>>>>>> 50d9cf1265dc3f4d79fd3d70e05476ded861adcf
import 'package:blogonomy/cubit/panel_controller_cubit.dart';
import 'package:blogonomy/main.dart';
import 'package:blogonomy/screens/blogers_sliding.dart';
import 'package:blogonomy/widget/blogers.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class SlidingUp2 extends StatefulWidget {
<<<<<<< HEAD
=======
  const SlidingUp2({Key? key}) : super(key: key);

>>>>>>> 50d9cf1265dc3f4d79fd3d70e05476ded861adcf
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
<<<<<<< HEAD
        //  fetchCarde();
=======
>>>>>>> 50d9cf1265dc3f4d79fd3d70e05476ded861adcf
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
<<<<<<< HEAD
      maxHeight: MediaQuery.of(context).size.height > 540
          ? 420
          : MediaQuery.of(context).size.height / 1.5,
=======
      maxHeight: MediaQuery.of(context).size.height > 500
          ? 410
          : MediaQuery.of(context).size.height / 1.6,
>>>>>>> 50d9cf1265dc3f4d79fd3d70e05476ded861adcf
      minHeight: 0,
      backdropEnabled: true,
      controller: pc,
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
              BlogersPanel(),
            ],
          ),
        );
      },
    );
  }
}
<<<<<<< HEAD

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
        //  fetchCarde();
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
                        onPressed: () {
                          // FilterCubit filterCubit = context.read<FilterCubit>();
                          // filterCubit.fetchFilter();

                          // BlogersCubit blogersCubit = context.read<BlogersCubit>();
                          // blogersCubit.fetchBlogers();

                          context.read<SlidingUpCubit2>().close();
                          context.read<SlidingUpCubit3>().close();

                          context
                              .read<BottomNavigationControllerSelect>()
                              .select(0);
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
        //  fetchCarde();
        pc4.open();
      } else if (ev is CloseState) {
        pc4.close();
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
                        decoration: const InputDecoration(
                          hintText: 'Тут будет имя подборки',
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
                        onPressed: () {
                          context.read<SlidingUpCubit3>().close();
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
                        onPressed: () {
                          context.read<SlidingUpCubit3>().close();
                        },
                        child: const SizedBox(
                          height: 52,
                          child: Center(child: Text('Удалить подборку')),
                        )),
                    const SizedBox(height: 16),
                    Text(
                      'Дата создания: 22.12.2021',
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
=======
>>>>>>> 50d9cf1265dc3f4d79fd3d70e05476ded861adcf
