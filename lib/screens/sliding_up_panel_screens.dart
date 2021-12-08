import 'dart:ui';

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

class SecondPage extends StatelessWidget {
  const SecondPage({Key? key, required this.onNext}) : super(key: key);
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      IconButton(
          alignment: Alignment.topLeft,
          onPressed: onNext,
          icon: const Icon(Icons.arrow_back_rounded)),
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
                  borderSide: BorderSide(color: Color(0xFFADB3BD), width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0))),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFADB3BD), width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0))),
            ),
          ),
        ),
      )
    ]);
  }
}
