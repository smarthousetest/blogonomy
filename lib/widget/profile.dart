import 'dart:async';
import 'dart:math';
import 'package:blogonomy/auth/auth_page.dart';
import 'package:blogonomy/cubit/panel_controller_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);
  @override
  State<Profile> createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    context.read<SlidingUpCubit>().open();
    return Scaffold(
        body: Column(children: [
      ClipPath(
        clipper: CurvedBottomClipper(),
        child: Container(
          color: Color(0x59e0f2f1),
          height: 300.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 60),
                child: Container(
                  alignment: Alignment.center,
                  height: 25.0,
                  child: const Text(
                    'Профиль',
                    style: TextStyle(
                      fontFamily: 'Roboto-Medium.ttf',
                      fontSize: 21.0,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF24282E),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 60),
                child: Container(
                  width: 130,
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(
                        'https://aif-s3.aif.ru/images/019/507/eeba36a2a2d37754bab8b462f4262d97.jpg'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      Expanded(
        child: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
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
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
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
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Icon(Icons.ac_unit),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text("Настройка уведомлений"),
                      ),
                      Spacer(
                        flex: 1,
                      ),
                      Icon(Icons.arrow_back),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
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
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Icon(Icons.ac_unit),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text("Настройка уведомлений"),
                      ),
                      Spacer(
                        flex: 1,
                      ),
                      Icon(Icons.arrow_back),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
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
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Icon(Icons.ac_unit),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text("Настройка уведомлений"),
                      ),
                      Spacer(
                        flex: 1,
                      ),
                      Icon(Icons.arrow_back),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
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
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Icon(Icons.ac_unit),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text("Настройка уведомлений"),
                      ),
                      Spacer(
                        flex: 1,
                      ),
                      Icon(Icons.arrow_back),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: 55.0,
              width: 600,
              margin: const EdgeInsets.only(left: 33.0, right: 35.0, top: 20),
              child: ElevatedButton(
                onPressed: () {},
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
                  backgroundColor:
                      MaterialStateProperty.all(const Color(0xFFFFFFFF)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      side: BorderSide(color: Color(0xFF006FFD)),
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            )
          ]),
        ),
      )
    ]));
  }
}

class CurvedBottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // I've taken approximate height of curved part of view
    // Change it if you have exact spec for it
    final roundingHeight = size.height * 4 / 5;

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
