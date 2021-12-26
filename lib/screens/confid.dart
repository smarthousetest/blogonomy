import 'package:flutter/material.dart';

class Confid extends StatefulWidget {
  @override
  State<Confid> createState() => _ConfidState();
}

class _ConfidState extends State<Confid> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.only(top: 70),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Image.asset(
                    "assets/images/arrow2.png",
                    height: 30,
                    width: 30,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(
                  width: 100,
                ),
                const Text(
                  "Политика конфиденциальности",
                  style: TextStyle(
                    fontFamily: 'Roboto-Medium.ttf',
                    fontSize: 21.0,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF24282E),
                  ),
                ),
                SizedBox(
                  width: 130,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
