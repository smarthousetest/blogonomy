import 'dart:async';
import 'dart:math';
import 'package:blogonomy/auth/auth_page.dart';
import 'package:blogonomy/cubit/network/admin_cubit.dart';
import 'package:blogonomy/cubit/network/admin_state.dart';
import 'package:blogonomy/cubit/network/auth_cubit.dart';
import 'package:blogonomy/cubit/network/auth_state.dart';
import 'package:blogonomy/cubit/panel_controller_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);
  @override
  State<Profile> createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  bool _enabled = false;
  @override
  Widget build(BuildContext context) {
    context.read<SlidingUpCubit>().open();
    return Stack(
      children: [
        Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              title: const Text(
                'Профиль',
                style: TextStyle(
                  fontFamily: 'Roboto-Medium.ttf',
                  fontSize: 21.0,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF24282E),
                ),
              ),
              backgroundColor: Color(0x59e0f2f1),
              elevation: 0,
              centerTitle: true,
              actions: [
                BlocBuilder<AdminCubit, AdminState>(builder: (context, state) {
                  //var authState = context.read<AuthCubit>().state;
                  //(authState is LoginedState ||
                  if (state is NoAdminState)
                    return Container();
                  else
                    return Stack(children: [
                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Text("admin"),
                      ),
                    ]);
                }),
                Switch(
                  value: _enabled,
                  onChanged: (bool value) {
                    setState(() {
                      context.read<AdminCubit>().setAdmin();
                      _enabled = value;
                    });
                  },
                  activeThumbImage:
                      new NetworkImage('https://nklk.ru/dll_image/1017.png'),
                  inactiveThumbImage: new NetworkImage(
                      'https://w7.pngwing.com/pngs/251/239/png-transparent-logo-design-rebranding-typography-letter-a-angle-text-triangle.png'),
                ),
              ],
            ),
            body: SingleChildScrollView(
                child: Column(children: [
              ClipPath(
                clipper: CurvedBottomClipper(),
                child: Container(
                  color: Color(0x59e0f2f1),
                  height: 200.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 60),
                        child: Container(
                          width: 130,
                          child: CircleAvatar(
                            radius: 60,
                            // backgroundImage: NetworkImage(
                            //     'https://aif-s3.aif.ru/images/019/507/eeba36a2a2d37754bab8b462f4262d97.jpg'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Column(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 20),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Полное имя',
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
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                    ),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Email',
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
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Мобильный телефон',
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
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/a');
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, top: 20),
                    child: Container(
                      height: 104.0,
                      margin: const EdgeInsets.only(left: 20.0, right: 21.0),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 0,
                            blurRadius: 25,
                            // changes position of shadow
                          ),
                        ],
                        border: Border.all(
                          color: const Color(0xFFF0F0FF),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(32.0),
                        color: const Color(0xFFFFFFFF),
                        // gradient: const LinearGradient(
                        //   colors: [Color(0xFFFFFFFF), Color(0xFFF3F3FF)],
                        // ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 24, right: 24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 5),
                              child: Image.asset(
                                'assets/images/notif.png',
                                width: 27,
                                height: 27,
                                color: Colors.yellow,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: 20,
                              ),
                              child: Text(
                                "Настройка уведомлений",
                                textScaleFactor:
                                    MediaQuery.of(context).textScaleFactor,
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                            ),
                            Spacer(
                              flex: 1,
                            ),
                            Image.asset(
                              'assets/images/arrow.png',
                              height: 30,
                              width: 30,
                              color: Colors.blue,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/b'),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, top: 20),
                    child: Container(
                      height: 104.0,
                      margin: const EdgeInsets.only(left: 20.0, right: 21.0),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 0,
                            blurRadius: 25,
                            // changes position of shadow
                          ),
                        ],
                        border: Border.all(
                          color: const Color(0xFFF0F0FF),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(32.0),
                        color: const Color(0xFFFFFFFF),
                        // gradient: const LinearGradient(
                        //   colors: [Color(0xFFFFFFFF), Color(0xFFF3F3FF)],
                        // ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 24, right: 24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Image.asset(
                                'assets/images/shield.png',
                                width: 27,
                                height: 27,
                                color: Color(0x40200E32),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Text(
                                "Политика конфиденциальности",
                                textScaleFactor: MediaQuery.of(context)
                                    .textScaleFactor
                                    .clamp(1.0, 1.5),
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Spacer(
                              flex: 1,
                            ),
                            Image.asset(
                              'assets/images/arrow.png',
                              height: 30,
                              width: 30,
                              color: Colors.blue,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/d'),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, top: 20),
                    child: Container(
                      height: 104.0,
                      margin: const EdgeInsets.only(left: 20.0, right: 21.0),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 0,
                            blurRadius: 25,
                            // changes position of shadow
                          ),
                        ],
                        border: Border.all(
                          color: const Color(0xFFF0F0FF),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(32.0),
                        color: const Color(0xFFFFFFFF),
                        // gradient: const LinearGradient(
                        //   colors: [Color(0xFFFFFFFF), Color(0xFFF3F3FF)],
                        // ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 24, right: 24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Image.asset(
                                'assets/images/info.png',
                                width: 27,
                                height: 27,
                                color: Colors.green,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Text(
                                "Подсказки",
                                textScaleFactor:
                                    MediaQuery.of(context).textScaleFactor,
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                            ),
                            Spacer(
                              flex: 1,
                            ),
                            Image.asset(
                              'assets/images/arrow.png',
                              height: 30,
                              width: 30,
                              color: Colors.blue,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/c'),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, top: 20),
                    child: Container(
                      height: 104.0,
                      margin: const EdgeInsets.only(left: 20.0, right: 21.0),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 0,
                            blurRadius: 25,
                            // changes position of shadow
                          ),
                        ],
                        border: Border.all(
                          color: const Color(0xFFF0F0FF),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(32.0),
                        color: const Color(0xFFFFFFFF),
                        // gradient: const LinearGradient(
                        //   colors: [Color(0xFFFFFFFF), Color(0xFFF3F3FF)],
                        // ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 24, right: 24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Image.asset(
                                'assets/images/copy.png',
                                width: 27,
                                height: 27,
                                color: Colors.grey,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Text(
                                "О приложении",
                                textScaleFactor:
                                    MediaQuery.of(context).textScaleFactor,
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                            ),
                            Spacer(
                              flex: 1,
                            ),
                            Image.asset(
                              'assets/images/arrow.png',
                              height: 30,
                              width: 30,
                              color: Colors.blue,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
                  if (state is LoginedState) {
                    return Container(
                      height: 55.0,
                      width: 600,
                      margin: const EdgeInsets.only(
                          left: 35.0, right: 35.0, top: 20),
                      child: ElevatedButton(
                        onPressed: () {
                          print("ggggyggy");
                          context.read<AuthCubit>().logOut();
                        },
                        child: const Text(
                          'Выйти',
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
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              side: BorderSide(color: Color(0xFF006FFD)),
                              borderRadius: BorderRadius.circular(32.0),
                            ),
                          ),
                        ),
                      ),
                    );
                  } else if (state is LogoutedState) {
                    return const Text('data');
                  } else
                    return (Text(""));
                }),
                const SizedBox(
                  height: 20,
                )
              ]),
            ])))
      ],
    );
  }
}

class CurvedBottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // I've taken approximate height of curved part of view
    // Change it if you have exact spec for it
    final roundingHeight = size.height * 9 / 6;

    // this is top part of path, rectangle without any rounding
    final filledRectangle =
        Rect.fromLTRB(0, 0, size.width, size.height - roundingHeight);

    // this is rectangle that will be used to draw arc
    // arc is drawn from center of this rectangle, so it's height has to be twice roundingHeight
    // also I made it to go 5 units out of screen on left and right, so curve will have some incline there
    final roundingRectangle = Rect.fromLTRB(
        -50, size.height - roundingHeight * 2, size.width + 50, size.height);

    final path = Path();
    path.addRect(filledRectangle);
    // so as I wrote before: arc is drawn from center of roundingRectangle
    // 2nd and 3rd arguments are angles from center to arc start and end points
    // 4th argument is set to true to move path to rectangle center, so we don't have to move it manually
    path.arcTo(roundingRectangle, pi, -pi, true);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // returning fixed 'true' value here for simplicity, it's not the part of actual question, please read docs if you want to dig into it
    // basically that means that clipping will be redrawn on any changes
    return true;
  }
}
