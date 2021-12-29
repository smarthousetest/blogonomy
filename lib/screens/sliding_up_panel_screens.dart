import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:blogonomy/auth/auth_page.dart';
import 'package:blogonomy/cubit/bottom_navigation_bar.dart';
import 'package:blogonomy/cubit/network/apiCateg.dart';
import 'package:blogonomy/cubit/network/auth_cubit.dart';
import 'package:blogonomy/cubit/network/auth_mode.dart';
import 'package:blogonomy/cubit/page_bloc.dart';
import 'package:blogonomy/cubit/panel_controller_cubit.dart';
import 'package:blogonomy/widget/sliding_up/sliding_up_panel.dart';
import 'package:provider/src/provider.dart';
import 'package:quiver/async.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

FirstPage first = FirstPage();

class Sliding extends StatefulWidget {
  const Sliding({Key? key}) : super(key: key);

  @override
  State<Sliding> createState() => _SlidingState();
}

class _SlidingState extends State<Sliding> with SingleTickerProviderStateMixin {
  late final _tabController = TabController(length: 3, vsync: this);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: TabBarView(
        controller: _tabController,
        children: [
          FirstPage(
            onNext: () => _tabController.index = 1,
          ),
          SecondPage(
            onNext: () => _tabController.index = 2,
          ),
          ThirdPage()
        ],
      ),
    );
  }
}

class FirstPage extends StatefulWidget {
  FirstPage({Key? key, this.onNext, this.mail}) : super(key: key);
  final VoidCallback? onNext;
  TextEditingController textEditingController = TextEditingController();
  String? mail;
  // getMail(String mail) {

  //   print("getMail $mail");
  //   return mail;
  // }

  @override
  State<FirstPage> createState() => _FirstPageStateState();
}

class _FirstPageStateState extends State<FirstPage> {
  AuthModel? _authModel;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 32.0),
        Container(
          alignment: Alignment.center,
          child: const Text(
            'Авторизация',
            style: TextStyle(
                fontFamily: 'Roboto-Bold.ttf',
                fontSize: 20,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w700,
                color: Color(0xFF24282E)),
          ),
        ),
        const SizedBox(height: 32),
        Container(
          height: 52.0,
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: TextFormField(
            controller: widget.textEditingController,
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
                  borderSide: BorderSide(color: Color(0xFFADB3BD), width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0))),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFADB3BD), width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0))),
            ),
          ),
        ),
        const SizedBox(height: 16.0),
        Container(
          height: 52.0,
          width: 600,
          margin: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: ElevatedButton(
            onPressed: () async {
              String mail = widget.textEditingController.text;
              final AuthModel authModel = await AuthApi().createMail(mail);
              first.mail = mail;
              print("object $mail");
              setState(() {
                _authModel = authModel;
              });

              if (authModel.result == 'empty') {
                widget.onNext!();
              }
              if (authModel.result == 'exist') {
                context.read<AuthCubit>().signIn();
              }
            },
            child: const Text(
              'Далее',
              style: TextStyle(
                fontFamily: 'Roboto-Bold.ttf',
                fontSize: 15.0,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w700,
                color: Color(0xFFFFFFFF),
              ),
            ),
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(const Color(0xFF006FFD)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 16,
        ),
        GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/e'),
            child: Text(
              "Обратиться в службу подержки",
              style: TextStyle(
                fontFamily: 'Roboto-Bold.ttf',
                fontSize: 15.0,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w700,
                color: Colors.blue,
              ),
            )),
        const SizedBox(height: 40.0),
      ],
    );
  }
}

class SecondPage extends StatefulWidget {
  final VoidCallback onNext;
  String? mail;

  setMail(String mail) {
    this.mail = mail;
    print(mail);
  }

  SecondPage({Key? key, required this.onNext}) : super(key: key);
  @override
  State<SecondPage> createState() => SecondPageState();
}

class SecondPageState extends State<SecondPage> {
  SecondPageState({Key? key});
  int _start = 60;
  int _current = 60;
  bool wg = true;
  FirstPage firstPage = FirstPage();

  void startTimer() {
    CountdownTimer countDownTimer = new CountdownTimer(
      new Duration(seconds: _start),
      new Duration(seconds: 1),
    );
    setState(() {
      wg = false;
      print(widget.mail);
    });

    var sub = countDownTimer.listen(null);
    sub.onData((duration) {
      setState(() {
        _current = _start - duration.elapsed.inSeconds;
      });
      if (_current == 0) {
        setState(() {
          wg = true;
          print(wg);
        });
      }
    });

    sub.onDone(() {
      print("Done");
      sub.cancel();
    });
  }

  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print("wg = ${wg}");
    return Stack(children: <Widget>[
      IconButton(
          alignment: Alignment.topLeft,
          onPressed: widget.onNext,
          icon: const Icon(Icons.arrow_back_rounded)),
      Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Center(
          child: Container(
            height: 52.0,
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: TextFormField(
              controller: textEditingController,
              decoration: const InputDecoration(
                hintText: 'Введите код с почты',
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
        SizedBox(
          height: 16,
        ),
        wg
            ? Container(
                height: 52.0,
                width: 600,
                margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: ElevatedButton(
                  onPressed: () async {
                    String? mail = first.mail;
                    print("hererererere");
                    startTimer();
                    final AuthModel authModel = await AuthApi().getCode(mail!);
                  },
                  child: const Text(
                    'Отправить код',
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
              )
            : SizedBox(
                child: Center(
                    child: Text(
                  'До повторной отправки кода осталось $_current',
                  style: const TextStyle(
                    fontFamily: 'Roboto-Bold.ttf',
                    fontSize: 15.0,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                )),
                height: 50,
              ),
        SizedBox(
          height: 16,
        ),
        Container(
          height: 52.0,
          width: 600,
          margin: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: ElevatedButton(
            onPressed: () async {
              widget.onNext();
              final AuthModel authModel =
                  await AuthApi().setCode(textEditingController.text);
            },
            child: const Text(
              'Далее',
              style: TextStyle(
                fontFamily: 'Roboto-Bold.ttf',
                fontSize: 15.0,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w700,
                color: Color(0xFFFFFFFF),
              ),
            ),
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(const Color(0xFF006FFD)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 16,
        ),
        GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/e'),
            child: Text(
              "Обратиться в службу подержки",
              style: TextStyle(
                fontFamily: 'Roboto-Bold.ttf',
                fontSize: 15.0,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w700,
                color: Colors.blue,
              ),
            )),
      ])
    ]);
  }
}

class ThirdPage extends StatefulWidget {
  @override
  State<ThirdPage> createState() => ThirdPageState();
}

class ThirdPageState extends State<ThirdPage> {
  TextEditingController textEditingController = TextEditingController();
  TextEditingController textEditingController2 = TextEditingController();
  bool yes = true;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 52.0,
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: TextFormField(
                controller: textEditingController,
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Поле пустое";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: 'Придумайте пароль',
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
            SizedBox(
              height: 16,
            ),
            Container(
              height: 52.0,
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: TextFormField(
                controller: textEditingController2,
                validator: (val) {
                  if (val!.isEmpty) return 'Поле пустое';
                  if (val != textEditingController.text) {
                    return 'Not Match';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: 'Повторите пароль',
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
            SizedBox(
              height: 16,
            ),
            Container(
              height: 52.0,
              width: 600,
              margin: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final AuthModel authModel = await AuthApi()
                        .setPassword(textEditingController2.text);
                    context.read<SlidingUpCubit>().close();
                    return;
                  } else {
                    print("UnSuccessfull");
                  }
                },
                child: const Text(
                  'Готово',
                  style: TextStyle(
                    fontFamily: 'Roboto-Bold.ttf',
                    fontSize: 15.0,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(const Color(0xFF006FFD)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/e'),
                child: Text(
                  "Обратиться в службу подержки",
                  style: TextStyle(
                    fontFamily: 'Roboto-Bold.ttf',
                    fontSize: 15.0,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w700,
                    color: Colors.blue,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
