import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "О приложении",
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
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 30, left: 40),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Column(
                  children: const [
                    Text(
                      "Разработчик",
                      style: TextStyle(
                        fontFamily: 'Roboto-Medium.ttf',
                        fontSize: 13.0,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      "Максат",
                      style: TextStyle(
                        fontFamily: 'Roboto-Medium.ttf',
                        fontSize: 19.0,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    )
                  ],
                )
              ]),
            )
          ],
        ),
      ),
    );
  }
}
