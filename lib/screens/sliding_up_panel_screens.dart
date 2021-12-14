import 'dart:async';
import 'dart:ui';
import 'package:quiver/async.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Sliding extends StatefulWidget {
  const Sliding({Key? key}) : super(key: key);

  @override
  State<Sliding> createState() => _SlidingState();
}

class _SlidingState extends State<Sliding> with SingleTickerProviderStateMixin {
  late final _tabController = TabController(length: 2, vsync: this);

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
            onNext: () => _tabController.index = 0,
          )
        ],
      ),
    );
  }
}

class FirstPage extends StatelessWidget {
  const FirstPage({Key? key, required this.onNext}) : super(key: key);
  final VoidCallback onNext;
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
            onPressed: () {
              onNext();
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
        const SizedBox(height: 40.0),
      ],
    );
  }
}

class SecondPage extends StatefulWidget {
  final VoidCallback onNext;

  const SecondPage({Key? key, required this.onNext}) : super(key: key);
  @override
  State<SecondPage> createState() => SecondPageState();
}

class SecondPageState extends State<SecondPage> {
  SecondPageState({Key? key});
  int _start = 60;
  int _current = 60;
  bool wg = true;
  void startTimer() {
    CountdownTimer countDownTimer = new CountdownTimer(
      new Duration(seconds: _start),
      new Duration(seconds: 1),
    );

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

  @override
  void initState() {
    super.initState();
  }

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
                  onPressed: () {
                    wg = false;
                    startTimer();
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
            onPressed: () {
              widget.onNext();
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
      ])
    ]);
  }
}
