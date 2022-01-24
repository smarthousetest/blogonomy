import 'package:flutter/material.dart';

class Confid extends StatefulWidget {
  @override
  State<Confid> createState() => _ConfidState();
}

class _ConfidState extends State<Confid> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Политика конфиденциальности",
            style: TextStyle(
              fontFamily: 'Roboto-Medium.ttf',
              fontSize: 21.0,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w500,
              color: Color(0xFF24282E),
            ),
          ),
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.blue),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
      ),
    );
  }
}
