import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlogerView extends StatelessWidget {
  String id;
  String userName;
  String picUrl;
  double er;

  BlogerView(
      {required this.id,
      required this.userName,
      required this.picUrl,
      required this.er});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Container(
          height: 80.0,
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
            borderRadius: BorderRadius.circular(36.0),
            color: const Color(0xFFFFFFFF),
            // gradient: const LinearGradient(
            //   colors: [Color(0xFFFFFFFF), Color(0xFFF3F3FF)],
            // ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    '$id',
                    style: TextStyle(
                      fontFamily: 'Roboto-Bold.ttf',
                      fontSize: 24.0,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF394759),
                    ),
                  )),
              CircleAvatar(
                backgroundImage: NetworkImage('$picUrl'),
                radius: 25,
              ),
              Padding(
                  padding: EdgeInsets.all(20.0),
                  child: SizedBox(
                    width: 140,
                    child: Text(
                      '$userName',
                      style: TextStyle(
                        fontFamily: 'Roboto-Bold.ttf',
                        fontSize: 18.0,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF394759),
                      ),
                    ),
                  )),
              Spacer(
                flex: 1,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 30),
                child: Positioned(
                    child: SizedBox(
                  child: Text(
                    '${er.round()}',
                    style: TextStyle(
                      fontFamily: 'Roboto-Bold.ttf',
                      fontSize: 20.0,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF394759),
                    ),
                  ),
                )),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24.0)
      ],
    );
  }
}
