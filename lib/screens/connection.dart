import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Connection extends StatefulWidget {
  @override
  State<Connection> createState() => _HelpState();
}

class _HelpState extends State<Connection> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.only(top: 70),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
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
              ],
            ),
            Image.asset(
              'assets/images/logo.png',
              height: 150,
              width: 150,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 30),
              child: Text(
                "Обратная связь с тех.поддержкой",
                style: TextStyle(
                  fontFamily: 'Roboto-Medium.ttf',
                  fontSize: 21.0,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF24282E),
                ),
              ),
            ),
            Container(
              height: 52.0,
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: TextFormField(
                // controller: widget.textEditingController,
                decoration: const InputDecoration(
                  hintText: 'Email или телефон',
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
              height: 20,
            ),
            Container(
              height: 300.0,
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: TextField(
                keyboardType: TextInputType.multiline,
                maxLines: 30,
                //  controller: widget.textEditingController,
                decoration: const InputDecoration(
                  hintText: 'Опишите ваше проблему',
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
              height: 20,
            ),
            Container(
              height: 52.0,
              width: 600,
              margin: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: ElevatedButton(
                onPressed: () {},
                child: const Text(
                  'Отправить',
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
          ],
        ),
      ),
    );
  }
}
