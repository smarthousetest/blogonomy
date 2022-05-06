import 'dart:ui';

import 'package:blogonomy/cubit/network/apiCateg.dart';
import 'package:blogonomy/cubit/network/api_state.dart';
import 'package:blogonomy/cubit/network/auth_cubit.dart';
import 'package:blogonomy/cubit/network/auth_mode.dart';
import 'package:blogonomy/cubit/network/auth_state.dart';
import 'package:blogonomy/cubit/panel_controller_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/src/provider.dart';
import 'package:quiver/async.dart';

FirstPage first = FirstPage();

class Sliding extends StatefulWidget {
  const Sliding({Key? key}) : super(key: key);

  @override
  State<Sliding> createState() => _SlidingState();
}

class _SlidingState extends State<Sliding> with SingleTickerProviderStateMixin {
  late final _tabController = TabController(length: 4, vsync: this);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: [
          FirstPage(
            onNext: () => _tabController.index = 3,
            onNext1: () => _tabController.index = 1,
          ),
          SecondPage(
            onNext: () => _tabController.index = 2,
            onBack: () => _tabController.index = 0,
          ),
          ThirdPage(
            onNext: () => _tabController.index = 1,
          ),
          FourPage(
            onNext: () => 1,
            onBack: () => _tabController.index = 0,
          )
        ],
      ),
    );
  }
}

class FirstPage extends StatefulWidget {
  FirstPage({Key? key, this.onNext, this.mail, this.onNext1}) : super(key: key);
  final VoidCallback? onNext;
  final VoidCallback? onNext1;
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
  bool value = false;
  GlobalKey<FormState> formkey1 = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 30.0),
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
        const SizedBox(height: 20),
        const SizedBox(height: 16.0),
        Container(
            height: 52.0,
            width: 600,
            margin: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: ElevatedButton(
              onPressed: () {
                widget.onNext!();
              },
              child: const Text(
                'Войти',
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
            )),
        SizedBox(
          height: 16,
        ),
        Container(
          width: 600,
          height: 52,
          margin: EdgeInsets.only(left: 20, right: 20),
          child: ElevatedButton(
            onPressed: () async {
              widget.onNext1!();
            },
            child: const Text(
              'Зарегистрироваться',
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
        const SizedBox(
          height: 10,
        ),
        const SizedBox(
          height: 20,
        ),
        GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/e'),
            child: const Text(
              "Обратиться в службу подержки",
              style: const TextStyle(
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
  final VoidCallback onBack;
  setMail(String mail) {
    this.mail = mail;
    print(mail);
  }

  SecondPage({Key? key, required this.onNext, required this.onBack})
      : super(key: key);
  @override
  State<SecondPage> createState() => SecondPageState();
}

class SecondPageState extends State<SecondPage> {
  SecondPageState({Key? key});
  AuthModel? _authModel;
  TextEditingController textEditingController2 = TextEditingController();
  int _start = 60;
  int _current = 60;
  bool wg = true;
  FirstPage firstPage = FirstPage();
  GlobalKey<FormState> formkey2 = GlobalKey<FormState>();
  GlobalKey<FormState> formkey3 = GlobalKey<FormState>();
  String b = 'ok';

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
          onPressed: widget.onBack,
          icon: const Icon(Icons.arrow_back_rounded)),
      Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(
          height: 30,
        ),
        Form(
          key: formkey2,
          child: Container(
            height: 52.0,
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: TextFormField(
              validator: (value) {
                print("value = $value");
                if (value!.isEmpty) {
                  return "* Required";
                }
                if (!value.contains('@')) return 'Это не E-mail';
                print(" auth Model = ${_authModel?.result}");
              },
              controller: textEditingController2,
              decoration: const InputDecoration(
                hintText: 'Email',
                hintStyle: TextStyle(
                  fontFamily: 'Roboto-Regular.ttf',
                  fontSize: 15.0,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFFADB3BD),
                ),
                enabledBorder: const OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xFFADB3BD), width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0))),
                focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Color(0xFFADB3BD), width: 1.0),
                    borderRadius:
                        const BorderRadius.all(const Radius.circular(32.0))),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Form(
          key: formkey3,
          child: Center(
            child: Container(
              height: 52.0,
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Введите код с почты";
                  }
                  print("b= $b");
                  if (b != 'ok') {
                    print("b2= $b");
                    return 'Код не совпадает';
                  }
                  // if (hash == null) {
                  //   return 'Код не совпадает';
                  // }
                },
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
        ),
        const SizedBox(
          height: 16,
        ),
        wg
            ? Container(
                height: 52.0,
                width: 600,
                margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: ElevatedButton(
                  onPressed: () async {
                    if (formkey2.currentState!.validate()) {
                      print("hererererere");
                      startTimer();
                      final AuthModel authModel =
                          await AuthApi().getCode(textEditingController2.text);
                    }
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
                        side: const BorderSide(color: const Color(0xFF006FFD)),
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
        const SizedBox(
          height: 16,
        ),
        Container(
          height: 52.0,
          width: 600,
          margin: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: ElevatedButton(
            onPressed: () async {
              String a = await context
                  .read<AuthApi>()
                  .setCode(textEditingController.text);
              //  await AuthApi().setCode(textEditingController.text);

              print("a=$a");

              if (a == 'ok') {
                setState(() {
                  b = 'ok';
                });
              }
              if (a == 'error') {
                print("haarerreer");
                setState(() {
                  b = 'ee';
                });
              }
              if (formkey3.currentState!.validate()) {
                widget.onNext();
              }
            },
            child: BlocBuilder<AuthApi, ApiState>(
              builder: ((context, state) {
                print("state on enter = $state");
                if (state is Loading) {
                  return CircularProgressIndicator(
                    color: Colors.white,
                  );
                }
                return const Text(
                  'Далее',
                  style: TextStyle(
                    fontFamily: 'Roboto-Bold.ttf',
                    fontSize: 15.0,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFFFFFFF),
                  ),
                );
              }),
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
        const SizedBox(
          height: 26,
        ),
        GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/e'),
            child: const Text(
              "Обратиться в службу подержки",
              style: const TextStyle(
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
  final VoidCallback onNext;

  const ThirdPage({Key? key, required this.onNext}) : super(key: key);
  @override
  State<ThirdPage> createState() => ThirdPageState();
}

class ThirdPageState extends State<ThirdPage> {
  TextEditingController textEditingController = TextEditingController();
  TextEditingController textEditingController2 = TextEditingController();
  bool yes = true;
  RegExp regex = RegExp('(?=.*?[0-9])');
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              IconButton(
                  alignment: Alignment.topLeft,
                  onPressed: widget.onNext,
                  icon: const Icon(Icons.arrow_back_rounded)),
            ],
          ),
          Form(
            key: _formKey,
            child: Container(
              height: 87.0,
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: TextFormField(
                obscureText: true,
                controller: textEditingController,
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Поле пустое";
                  }
                  if (val.length < 6) {
                    return "Пароль меньше 6 символов";
                  }
                  if (!regex.hasMatch(val)) {
                    return ('Пароль должен содержать хотя бы одну цифру');
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
                  helperText:
                      "Пароль не менее 6 символов \n и минимум одна цифра без пробелов",
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
          const SizedBox(
            height: 16,
          ),
          Form(
            key: _formKey2,
            child: Container(
              height: 52.0,
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: TextFormField(
                obscureText: true,
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
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            height: 52.0,
            width: 600,
            margin: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate() &&
                    _formKey2.currentState!.validate()) {
                  final AuthModel authModel =
                      await AuthApi().setPassword(textEditingController2.text);
                  context.read<SlidingUpCubit>().close();
                  context.read<AuthCubit>().signIn();
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
          const SizedBox(
            height: 26,
          ),
          GestureDetector(
              onTap: () => Navigator.pushNamed(context, '/e'),
              child: const Text(
                "Обратиться в службу подержки",
                style: const TextStyle(
                  fontFamily: 'Roboto-Bold.ttf',
                  fontSize: 15.0,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w700,
                  color: Colors.blue,
                ),
              )),
        ],
      ),
    );
  }
}

class FourPage extends StatefulWidget {
  FourPage({Key? key, this.onNext, this.mail, this.onBack}) : super(key: key);
  final VoidCallback? onNext;
  final VoidCallback? onBack;
  TextEditingController textEditingController = TextEditingController();
  String? mail;
  // getMail(String mail) {

  //   print("getMail $mail");
  //   return mail;
  // }

  @override
  State<FourPage> createState() => _FourPageState();
}

class _FourPageState extends State<FourPage> {
  AuthModel? _authModel;
  bool value = false;
  GlobalKey<FormState> formkey1 = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            color: Colors.black,
            alignment: Alignment.topLeft,
            onPressed: widget.onBack,
            icon: const Icon(Icons.arrow_back_rounded)),
        centerTitle: true,
        title: const Text(
          'Авторизация',
          style: TextStyle(
              fontFamily: 'Roboto-Bold.ttf',
              fontSize: 20,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w700,
              color: Color(0xFF24282E)),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Form(
            key: formkey1,
            child: Container(
              height: 52.0,
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: TextFormField(
                validator: (value) {
                  print("value = $value");
                  if (value!.isEmpty) {
                    return "* Required";
                  }
                  print(" auth Model = ${_authModel?.result}");
                  if (_authModel?.result == "empty") {
                    return "Аккаунт не найден, нажмите ЗАРЕГИСТРИРОВАТЬСЯ";
                  }
                },
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
                  enabledBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFFADB3BD), width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0))),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color(0xFFADB3BD), width: 1.0),
                      borderRadius:
                          const BorderRadius.all(const Radius.circular(32.0))),
                ),
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

                  AuthModel authModel =
                      await context.read<AuthApi>().createMail(mail);

                  first.mail = mail;
                  print("object $mail");
                  setState(() {
                    _authModel = authModel;
                  });
                  if (formkey1.currentState!.validate()) {
                    print(" auth Model = ${_authModel!.result}");
                    if (authModel.result == 'exist') {
                      context.read<AuthCubit>().signIn();
                      context.read<SlidingUpCubit>().close();
                    }

                    return;
                  } else {
                    print("UnSuccessfull");
                  }
                },
                child: BlocBuilder<AuthApi, ApiState>(
                  builder: ((context, state) {
                    print("state on enter = $state");
                    if (state is Loading) {
                      return CircularProgressIndicator(
                        color: Colors.white,
                      );
                    }
                    return const Text(
                      'Вход',
                      style: TextStyle(
                        fontFamily: 'Roboto-Bold.ttf',
                        fontSize: 15.0,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFFFFFFF),
                      ),
                    );
                  }),
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
              )),
          // const SizedBox(
          //   height: 10,
          // ),
          // GestureDetector(
          //     onTap: () async {
          //       // String mail = widget.textEditingController.text;
          //       // final AuthModel authModel = await AuthApi().getCode(mail);
          //       widget.onNext!();
          //       print("hererererere");
          //     },
          //     child: const Text(
          //       "Зарегистрироваться",
          //       style: TextStyle(
          //         fontFamily: 'Roboto-Bold.ttf',
          //         fontSize: 15.0,
          //         fontStyle: FontStyle.normal,
          //         fontWeight: FontWeight.w700,
          //         color: Colors.blue,
          //       ),
          //     )),
          const SizedBox(
            height: 30,
          ),
          GestureDetector(
              onTap: () => Navigator.pushNamed(context, '/e'),
              child: const Text(
                "Обратиться в службу подержки",
                style: const TextStyle(
                  fontFamily: 'Roboto-Bold.ttf',
                  fontSize: 15.0,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w700,
                  color: Colors.blue,
                ),
              )),
          const SizedBox(height: 40.0),
        ],
      ),
    );
  }
}
