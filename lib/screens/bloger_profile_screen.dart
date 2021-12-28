import 'dart:math';

import 'package:blogonomy/cubit/network/card_cubitCateg.dart';
import 'package:blogonomy/cubit/network/card_modelCateg.dart';
import 'package:blogonomy/cubit/network/card_stateCateg.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BlogerProfileScreen extends StatefulWidget {
  @override
  State<BlogerProfileScreen> createState() => _BlogerProfileScreenState();
}

class _BlogerProfileScreenState extends State<BlogerProfileScreen> {
  List<Color> gradientColors = [
    const Color(0xff0072FD),
    const Color(0xff0072FD),
  ];

  double heightcontainer1 = 100.0;
  double heightcontainer2 = 100.0;

  bool tegsscrol = false;
  bool peoplesscrol = false;

  bool tegsopen = false;
  bool peoplesopen = false;

  @override
  Widget build(BuildContext context) {
    OneBlogerCubit oneBlogerCubit = context.read<OneBlogerCubit>();
    oneBlogerCubit.fetchBloger();

    return BlocBuilder<OneBlogerCubit, OneBlogerState>(
        builder: (context, state) {
      if (state is OneBlogerLoadingState) {
        return Scaffold(body: Center(child: CircularProgressIndicator()));
      }
      if (state is OneBlogerLoadedState) {
        String? location = state.loadedBloger.location?.name.toString();
        location = location!.substring(location.lastIndexOf(',') + 1);

        return StatefulBuilder(// StatefulBuilder
            builder: (context, setState) {
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
                            SizedBox(
                              width: 40,
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
                              flex: 2,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CircularProfileAvatar(
                          '${state.loadedBloger?.picUrl}', //sets image path, it should be a URL string. default value is empty string, if path is empty it will display only initials
                          radius: 48,
                          borderWidth: 5,
                          borderColor: Colors.blue,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          '${state.loadedBloger?.fullName}',
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
                              '@${state.loadedBloger?.userName}',
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
                              "$location",
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
                          padding:
                              EdgeInsets.only(top: 26, bottom: 20, right: 26),
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
                              '${state.loadedBloger?.er?.round()}',
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
                              '${state.loadedBloger?.numFollowers}',
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
                            SvgPicture.asset(
                              "assets/icons/heart.svg",
                              color: Colors.grey,
                            ),
                            // Icon(
                            //   Icons.favorite_border_outlined,
                            //   color: Colors.grey,
                            // ),
                            const SizedBox(height: 11),
                            Text(
                              '${state.loadedBloger?.absoluteLikes}',
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
                            SvgPicture.asset(
                              "assets/icons/chat.svg",
                              color: Colors.grey,
                            ),
                            // Icon(
                            //   Icons.chat_outlined,
                            //   color: Colors.grey,
                            // ),
                            const SizedBox(height: 11),
                            Text(
                              '${state.loadedBloger?.absoluteComments}',
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
                      ],
                    )),
                const SizedBox(height: 8),
                state.loadedBloger?.hashtag!.length != 0
                    ? Column(
                        children: [
                          const SizedBox(height: 8),
                          Container(
                            padding: EdgeInsets.only(
                                left: 16, right: 16, bottom: 16, top: 24),
                            margin:
                                const EdgeInsets.only(left: 20.0, right: 21.0),
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
                                Divider(),
                                const SizedBox(height: 2),
                                AnimatedContainer(
                                  duration: Duration(seconds: 1),
                                  child: SingleChildScrollView(
                                    physics: tegsscrol
                                        ? AlwaysScrollableScrollPhysics()
                                        : NeverScrollableScrollPhysics(),
                                    child: Wrap(
                                      spacing: 16,
                                      children: List.generate(
                                          state.loadedBloger?.hashtag!.length,
                                          (int index) {
                                        return Chip(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                            ),
                                            backgroundColor: Color(0xFFF0F0FF),
                                            label: Text(
                                                '${state.loadedBloger?.hashtag?[index].name}',
                                                style: TextStyle(
                                                  fontFamily: 'Roboto-Bold.ttf',
                                                  fontSize: 15.0,
                                                  fontStyle: FontStyle.normal,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.black,
                                                )));
                                      }),
                                    ),
                                  ),
                                  height: heightcontainer1,
                                ),
                                TextButton(
                                    onPressed: () {
                                      setState(() {
                                        tegsscrol = false;
                                        tegsopen = !tegsopen;
                                        heightcontainer1 = tegsopen
                                            ? state.loadedBloger?.hashtag!
                                                    .length *
                                                25.8
                                            : 100;
                                      });
                                    },
                                    child: Text(
                                      !tegsopen ? "Ещё" : "Скрыть",
                                      style: TextStyle(
                                        fontFamily: 'Roboto-Bold.ttf',
                                        fontSize: 14.0,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.blue,
                                      ),
                                    )),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                        ],
                      )
                    : Container(),
                state.loadedBloger?.taggedUser!.length != 0
                    ? Column(
                        children: [
                          const SizedBox(height: 8),
                          Container(
                            padding: EdgeInsets.only(
                                left: 16, right: 16, bottom: 16, top: 24),
                            margin:
                                const EdgeInsets.only(left: 20.0, right: 21.0),
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
                                  'Люди',
                                  style: TextStyle(
                                    fontFamily: 'Roboto-Bold.ttf',
                                    fontSize: 18.0,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Divider(),
                                const SizedBox(height: 2),
                                AnimatedContainer(
                                  duration: Duration(seconds: 1),
                                  child: SingleChildScrollView(
                                    physics: peoplesscrol
                                        ? AlwaysScrollableScrollPhysics()
                                        : NeverScrollableScrollPhysics(),
                                    child: Wrap(
                                      spacing: 10,
                                      children: List.generate(
                                          state.loadedBloger?.taggedUser!
                                              .length, (int index) {
                                        return Chip(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                            ),
                                            backgroundColor: Color(0xFFF0F0FF),
                                            label: Text(
                                                '${state.loadedBloger?.taggedUser?[index].name}',
                                                style: TextStyle(
                                                  fontFamily: 'Roboto-Bold.ttf',
                                                  fontSize: 15.0,
                                                  fontStyle: FontStyle.normal,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.black,
                                                )));
                                      }),
                                    ),
                                  ),
                                  height: heightcontainer2,
                                ),
                                TextButton(
                                    onPressed: () {
                                      setState(() {
                                        peoplesscrol = false;
                                        peoplesopen = !peoplesopen;
                                        heightcontainer2 = peoplesopen
                                            ? state.loadedBloger?.taggedUser!
                                                    .length *
                                                26.roundToDouble()
                                            : 100;
                                      });
                                    },
                                    child: Text(
                                      !peoplesopen ? "Ещё" : "Скрыть",
                                      style: TextStyle(
                                        fontFamily: 'Roboto-Bold.ttf',
                                        fontSize: 14.0,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.blue,
                                      ),
                                    )),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                        ],
                      )
                    : Container(),
              ],
            ),
          )));
        });
      }
      return GestureDetector(
          onTap: () {
            FilterCubit filterCubit = context.read<FilterCubit>();
            filterCubit.fetchFilter();
          },
          child: Text("Error"));
    });
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
