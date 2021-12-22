import 'dart:math';

import 'package:blogonomy/cubit/network/card_modelCateg.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class BlogerProfileScreen extends StatefulWidget {
  BlogersModel loadedBlogers;
  BlogerProfileScreen(this.loadedBlogers);

  @override
  State<BlogerProfileScreen> createState() => _BlogerProfileScreenState();
}

class _BlogerProfileScreenState extends State<BlogerProfileScreen> {
  List<Color> gradientColors = [
    const Color(0xff0072FD),
    const Color(0xff0072FD),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          ClipPath(
            clipper: CurvedBottomClipper(),
            child: Container(
              color: Color(0xFFF5F5FF),
              height: 300.0,
              child: Column(
                children: [
                  const SizedBox(height: 32.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                          child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.chevron_left_outlined,
                                color: Color(0xFF0072FD),
                                size: 38,
                              ))),
                      Spacer(
                        flex: 1,
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 25.0,
                        child: const Text(
                          'Инфо о блогере',
                          style: TextStyle(
                            fontFamily: 'Roboto-Medium.ttf',
                            fontSize: 21.0,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF24282E),
                          ),
                        ),
                      ),
                      Spacer(
                        flex: 1,
                      ),
                      Container(
                          child: IconButton(
                              onPressed: () {
                                print("HEllol");
                              },
                              icon: Icon(
                                Icons.date_range_outlined,
                                color: Color(0xFF0072FD),
                                size: 30,
                              ))),
                      const SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CircularProfileAvatar(
                    '${widget.loadedBlogers.picUrl}', //sets image path, it should be a URL string. default value is empty string, if path is empty it will display only initials
                    radius: 48,
                    borderWidth: 5,
                    borderColor: Colors.blue,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    '${widget.loadedBlogers.fullName}',
                    style: TextStyle(
                      fontFamily: 'Roboto-Bold.ttf',
                      fontSize: 18.0,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person_outline,
                        color: Colors.grey[400],
                      ),
                      Text(
                        '@${widget.loadedBlogers.userName}',
                        style: TextStyle(
                          fontFamily: 'Roboto-Bold.ttf',
                          fontSize: 12.0,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Icon(
                        Icons.location_on_outlined,
                        color: Colors.grey[400],
                      ),
                      Text(
                        'City',
                        style: TextStyle(
                          fontFamily: 'Roboto-Bold.ttf',
                          fontSize: 12.0,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            height: 350,
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
            child: Column(
              children: [
                Stack(children: [
                  Container(
                    padding: EdgeInsets.only(top: 26, bottom: 20, right: 26),
                    height: 240,
                    width: MediaQuery.of(context).size.width,
                    child: LineChart(
                      mainData(),
                    ),
                  ),
                ]),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Показатель ER, % ',
                        style: TextStyle(
                          fontFamily: 'Roboto-Bold.ttf',
                          fontSize: 17.0,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFFB1B1D1),
                        ),
                      ),
                      Text(
                        '${widget.loadedBlogers.er?.round()}',
                        style: TextStyle(
                          fontFamily: 'Roboto-Bold.ttf',
                          fontSize: 20.0,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Подписчиков:',
                        style: TextStyle(
                          fontFamily: 'Roboto-Bold.ttf',
                          fontSize: 17.0,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFFB1B1D1),
                        ),
                      ),
                      Text(
                        '${widget.loadedBlogers.numFollowers}',
                        style: TextStyle(
                          fontFamily: 'Roboto-Bold.ttf',
                          fontSize: 20.0,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF394759),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
              padding: EdgeInsets.only(top: 26, bottom: 24),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Icon(
                        Icons.favorite_border_outlined,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 11),
                      Text(
                        '${widget.loadedBlogers.absoluteLikes}',
                        style: TextStyle(
                          fontFamily: 'Roboto-Bold.ttf',
                          fontSize: 16.0,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF394759),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Icon(
                        Icons.chat_outlined,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 11),
                      Text(
                        '${widget.loadedBlogers.absoluteComments}',
                        style: TextStyle(
                          fontFamily: 'Roboto-Bold.ttf',
                          fontSize: 16.0,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF394759),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Icon(
                        Icons.turned_in_not_outlined,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 11),
                      Text(
                        '00000',
                        style: TextStyle(
                          fontFamily: 'Roboto-Bold.ttf',
                          fontSize: 16.0,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF394759),
                        ),
                      ),
                    ],
                  )
                ],
              )),
          const SizedBox(height: 16),
          Container(
              padding: EdgeInsets.all(16),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Теги',
                    style: TextStyle(
                      fontFamily: 'Roboto-Bold.ttf',
                      fontSize: 18.0,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Divider(
                    height: 2,
                    color: Color(0xFFebebff),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 12),
                        decoration: BoxDecoration(
                          color: Color(0xFFF0F0FF),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 2, bottom: 2, left: 4, right: 4),
                          child: Text("Казань",
                              style: TextStyle(
                                fontFamily: 'Roboto-Bold.ttf',
                                fontSize: 15.0,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              )),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 12),
                        decoration: BoxDecoration(
                          color: Color(0xFFF0F0FF),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 2, bottom: 2, left: 4, right: 4),
                          child: Text("Казань",
                              style: TextStyle(
                                fontFamily: 'Roboto-Bold.ttf',
                                fontSize: 15.0,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              )),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 12),
                        decoration: BoxDecoration(
                          color: Color(0xFFF0F0FF),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 2, bottom: 2, left: 4, right: 4),
                          child: Text("Казань",
                              style: TextStyle(
                                fontFamily: 'Roboto-Bold.ttf',
                                fontSize: 15.0,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              )),
                        ),
                      )
                    ],
                  )
                ],
              ))
        ],
      ),
    )));
  }

  LineChartData mainData() {
    return LineChartData(
      lineTouchData: LineTouchData(
        getTouchedSpotIndicator:
            (LineChartBarData barData, List<int> spotIndexes) {
          return spotIndexes.map((spotIndex) {
            return TouchedSpotIndicatorData(
              FlLine(color: Colors.blue, strokeWidth: 4),
              FlDotData(
                getDotPainter: (spot, percent, barData, index) {
                  return FlDotCirclePainter(
                      radius: 5,
                      color: Colors.blue,
                      strokeWidth: 3,
                      strokeColor: Colors.white);
                },
              ),
            );
          }).toList();
        },
        touchTooltipData: LineTouchTooltipData(
            fitInsideHorizontally: true,
            tooltipBgColor: Colors.grey[100],
            getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
              return touchedBarSpots.map((barSpot) {
                return LineTooltipItem(
                  '',
                  const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: barSpot.y.toString(),
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                );
              }).toList();
            }),
      ),
      gridData: FlGridData(show: false),
      borderData: FlBorderData(show: false),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: SideTitles(showTitles: false),
        topTitles: SideTitles(showTitles: false),
        // bottomTitles: SideTitles(
        //   showTitles: true,
        //   reservedSize: 22,
        //   interval: 1,
        //   getTextStyles: (context, value) => const TextStyle(
        //       color: Color(0xff68737d),
        //       fontWeight: FontWeight.bold,
        //       fontSize: 16),
        //   getTitles: (value) {
        //     switch (value.toInt()) {
        //       case 2:
        //         return 'MAR';
        //       case 5:
        //         return 'JUN';
        //       case 8:
        //         return 'SEP';
        //     }
        //     return '';
        //   },
        //   margin: 8,
        // ),
        // leftTitles: SideTitles(
        //   showTitles: true,
        //   interval: 1,
        //   getTextStyles: (context, value) => const TextStyle(
        //     color: Color(0xff67727d),
        //     fontWeight: FontWeight.bold,
        //     fontSize: 15,
        //   ),
        //   getTitles: (value) {
        //     switch (value.toInt()) {
        //       case 1:
        //         return '10k';
        //       case 3:
        //         return '30k';
        //       case 5:
        //         return '50k';
        //     }
        //     return '';
        //   },
        //   reservedSize: 32,
        //   margin: 12,
        // ),
      ),
      minX: 0,
      minY: 0,
      lineBarsData: [
        LineChartBarData(
            spots: const [
              FlSpot(0, 3),
              FlSpot(1, 2),
              FlSpot(2, 5),
              FlSpot(3, 3.1),
            ],
            isCurved: true,
            colors: gradientColors,
            barWidth: 1,
            isStrokeCapRound: true,
            dotData: FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              gradientColorStops: [0.5, 1.0],
              gradientFrom: const Offset(0, 0),
              gradientTo: const Offset(0, 1),
              colors: [
                Colors.blue.withOpacity(0.2),
                Colors.blue.withOpacity(0.0),
              ],
            )),
      ],
    );
  }
}

class CurvedBottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // I've taken approximate height of curved part of view
    // Change it if you have exact spec for it
    final roundingHeight = size.height * 4 / 5;

    // this is top part of path, rectangle without any rounding
    final filledRectangle =
        Rect.fromLTRB(0, 0, size.width, size.height - roundingHeight);

    // this is rectangle that will be used to draw arc
    // arc is drawn from center of this rectangle, so it's height has to be twice roundingHeight
    // also I made it to go 5 units out of screen on left and right, so curve will have some incline there
    final roundingRectangle = Rect.fromLTRB(
        -50, size.height - roundingHeight * 2, size.width + 50, size.height);

    final path = Path();
    path.addRect(filledRectangle);
    // so as I wrote before: arc is drawn from center of roundingRectangle
    // 2nd and 3rd arguments are angles from center to arc start and end points
    // 4th argument is set to true to move path to rectangle center, so we don't have to move it manually
    path.arcTo(roundingRectangle, pi, -pi, true);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // returning fixed 'true' value here for simplicity, it's not the part of actual question, please read docs if you want to dig into it
    // basically that means that clipping will be redrawn on any changes
    return true;
  }
}
