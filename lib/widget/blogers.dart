import 'package:blogonomy/cubit/network/admin_cubit.dart';
import 'package:blogonomy/cubit/network/admin_state.dart';
import 'package:blogonomy/cubit/network/card_cubitCateg.dart';
import 'package:blogonomy/cubit/panel_controller_cubit.dart';
import 'package:blogonomy/main.dart';

import 'package:blogonomy/screens/blogers_screens.dart';
import 'package:blogonomy/screens/popular_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/src/provider.dart';

import 'package:multi_select_flutter/multi_select_flutter.dart';

class Blogers extends StatefulWidget {
  const Blogers({Key? key}) : super(key: key);
  @override
  State<Blogers> createState() => BlogerState();
}

class BlogerState extends State<Blogers> {
  TextEditingController bloger = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            'Блогеры',
            style: TextStyle(
              fontFamily: 'Roboto-Medium.ttf',
              fontSize: 18.0,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w500,
              color: Color(0xFF24282E),
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading:
              BlocBuilder<AdminCubit, AdminState>(builder: (context, state) {
            //var authState = context.read<AuthCubit>().state;
            //(authState is LoginedState ||
            print('state now is $state');
            if (state is NoAdminState)
              return Container();
            else if (state is AdminInState) {
              return IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                              child: Container(
                            width: 100,
                            height: 200,
                            child: Column(children: [
                              Container(
                                height: 100,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20, top: 20),
                                    child: TextFormField(
                                      controller: bloger,
                                      decoration: const InputDecoration(
                                        hintText: 'Введите ник блогера',
                                        hintStyle: TextStyle(
                                          fontFamily: 'Roboto-Regular.ttf',
                                          fontSize: 15.0,
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xFFADB3BD),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0xFFADB3BD),
                                                width: 1.0),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(32.0))),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0xFFADB3BD),
                                                width: 1.0),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(32.0))),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 20.0,
                                width: 600,
                                margin: const EdgeInsets.only(
                                    left: 33.0, right: 35.0, top: 20),
                                child: ElevatedButton(
                                  onPressed: () {
                                    context
                                        .read<AdminCubit>()
                                        .addAdmin(bloger.text);
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    'Добавить',
                                    style: TextStyle(
                                      fontFamily: 'Roboto-Bold.ttf',
                                      fontSize: 15.0,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF006FFD),
                                    ),
                                  ),
                                  style: ButtonStyle(
                                    elevation: MaterialStateProperty.all(0),
                                    backgroundColor: MaterialStateProperty.all(
                                        const Color(0xFFFFFFFF)),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        side: BorderSide(
                                            color: Color(0xFF006FFD)),
                                        borderRadius:
                                            BorderRadius.circular(32.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                          ));
                        });
                  },
                  icon: Icon(
                    Icons.add,
                    color: Colors.blue,
                  ));
            }
            return Text('');
          }),
          actions: [
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
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: Padding(
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
                      borderSide:
                          BorderSide(color: Color(0xFFADB3BD), width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0))),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFFADB3BD), width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0))),
                ),
              ),
            ),
          ),
        ),
        body: SafeArea(child: BlogersList()));
  }
}
