import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardView extends StatelessWidget {
  String id;
  String name;
  String image;
  int numberOfBloggers;

  CardView(
      {required this.id,
      required this.name,
      required this.image,
      required this.numberOfBloggers});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 104.0,
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
            borderRadius: BorderRadius.circular(32.0),
            color: const Color(0xFFFFFFFF),
            // gradient: const LinearGradient(
            //   colors: [Color(0xFFFFFFFF), Color(0xFFF3F3FF)],
            // ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 24, right: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 25, bottom: 25),
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0.0,
                          top: 0.0,
                          child: Text(
                            '$name',
                            style: const TextStyle(
                              fontFamily: 'Roboto-Bold.ttf',
                              fontSize: 24.0,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF394759),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 0.0,
                          bottom: 0.0,
                          child: Text(
                            numberOfBloggers.toString(),
                            style: const TextStyle(
                              fontFamily: 'Roboto-Regular.ttf',
                              fontSize: 15.0,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF394759),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Container(
                        color: Colors.blue,
                        width: 70,
                        height: 70,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.network(
                            '$image',
                          ),
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24.0)
      ],
    );
  }
}
