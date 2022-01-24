import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  bool isSwitch = false;
  bool isSwitch2 = false;
  bool isSwitch3 = false;
  bool isSwitch4 = false;
  bool isSwitch5 = false;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          title: const Text(
            "Уведомления",
            style: TextStyle(
              fontFamily: 'Roboto-Medium.ttf',
              fontSize: 21.0,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w500,
              color: Color(0xFF24282E),
            ),
          ),
          iconTheme: IconThemeData(color: Colors.blue),
        ),
        body: Column(
          children: [
            ListTile(
              title: const Text(
                "Новые блогеры в подборках",
                style: TextStyle(
                  fontFamily: 'Roboto-Medium.ttf',
                  fontSize: 20.0,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF24282E),
                ),
              ),
              trailing: Switch(
                  value: isSwitch,
                  onChanged: (bool x) {
                    setState(() {
                      isSwitch = x;
                    });
                  }),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ListTile(
                title: const Text(
                  "Обновления приложения",
                  style: TextStyle(
                    fontFamily: 'Roboto-Medium.ttf',
                    fontSize: 20.0,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF24282E),
                  ),
                ),
                trailing: Switch(
                    value: isSwitch2,
                    onChanged: (bool x) {
                      setState(() {
                        isSwitch2 = x;
                      });
                    }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: ListTile(
                title: const Text(
                  "СМС",
                  style: TextStyle(
                    fontFamily: 'Roboto-Medium.ttf',
                    fontSize: 20.0,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF24282E),
                  ),
                ),
                trailing: Switch(
                    value: isSwitch3,
                    onChanged: (bool x) {
                      setState(() {
                        isSwitch3 = x;
                      });
                    }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ListTile(
                title: const Text(
                  "Email",
                  style: TextStyle(
                    fontFamily: 'Roboto-Medium.ttf',
                    fontSize: 20.0,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF24282E),
                  ),
                ),
                trailing: Switch(
                    value: isSwitch4,
                    onChanged: (bool x) {
                      setState(() {
                        isSwitch4 = x;
                      });
                    }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ListTile(
                title: const Text(
                  "Push",
                  style: TextStyle(
                    fontFamily: 'Roboto-Medium.ttf',
                    fontSize: 20.0,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF24282E),
                  ),
                ),
                trailing: Switch(
                    value: isSwitch5,
                    onChanged: (bool x) {
                      setState(() {
                        isSwitch5 = x;
                      });
                    }),
              ),
            ),
            Spacer(
              flex: 1,
            ),
            Container(
              height: 52.0,
              width: 600,
              margin:
                  const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 50),
              child: ElevatedButton(
                onPressed: () {},
                child: const Text(
                  'Сохранить',
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
