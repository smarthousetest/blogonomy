import 'dart:async';

import 'package:blogonomy/screens/podborki_main.dart';
import 'package:blogonomy/screens/popular_tab.dart';
import 'package:blogonomy/widget/collections.dart';
import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class HelpPage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HelpPage> {
  GlobalKey keyButton = GlobalKey();
  GlobalKey keyButton1 = GlobalKey();
  GlobalKey keyButton2 = GlobalKey();
  GlobalKey keyButton3 = GlobalKey();
  GlobalKey keyButton4 = GlobalKey();
  GlobalKey keyButton5 = GlobalKey();

  List<Widget> images = [const Popular(), const PodborkiMain()];

  int selectedValue = 0;
  late TutorialCoachMark tutorialCoachMark;
  List<TargetFocus> targets = <TargetFocus>[];

  GlobalKey keyBottomNavigation1 = GlobalKey();
  GlobalKey keyBottomNavigation2 = GlobalKey();
  GlobalKey keyBottomNavigation3 = GlobalKey();
  Timer? _timer;
  @override
  void initState() {
    _timer = Timer(const Duration(milliseconds: 1000), () {
      Future.delayed(Duration.zero, showTutorial);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map<int, Widget> children = <int, Widget>{
      0: Container(
          key: keyButton1,
          child: const Text(
            'Популярные',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Roboto-Medium.ttf',
              fontSize: 14.0,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w500,
              color: Color(0xFF24282E),
            ),
          )),
      1: Container(
        key: keyButton,
        child: const Text(
          'Мои',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Roboto-Medium.ttf',
            fontSize: 14.0,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w500,
            color: Color(0xFF24282E),
          ),
        ),
      )
    };
    return Scaffold(
      body: Scaffold(
        body: SafeArea(
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color(0xFFFFFFFF)),
                child: ListView(children: [
                  const SizedBox(height: 42.0),
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
                      const SizedBox(
                        width: 100,
                      ),
                      const Text(
                        "Категории",
                        style: TextStyle(
                          fontFamily: 'Roboto-Medium.ttf',
                          fontSize: 21.0,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF24282E),
                        ),
                      ),
                      const SizedBox(
                        width: 190,
                      )
                    ],
                  ),
                  const SizedBox(height: 34.0),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: LayoutBuilder(
                      builder: (context, constraints) =>
                          CustomSlidingSegmentedControl<int>(
                        radius: 30,
                        padding: 8,
                        innerPadding: 4,
                        fixedWidth: (constraints.maxWidth - 8) / 2,
                        backgroundColor: const Color(0xFFF0F2FE),
                        thumbColor: const Color(0xFFFFFFFF),
                        children: children,
                        initialValue: selectedValue,
                        onValueChanged: (value) {
                          setState(() {
                            selectedValue = value;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 26.0),
                  Container(
                    child: images[selectedValue],
                  )
                ]))),
      ),
      bottomNavigationBar: Stack(
        children: [
          Container(
            height: 50,
            child: Row(
              children: [
                Expanded(
                    child: Center(
                  child: SizedBox(
                    key: keyBottomNavigation1,
                    height: 50,
                    width: 50,
                  ),
                )),
                Expanded(
                    child: Center(
                  child: SizedBox(
                    key: keyBottomNavigation2,
                    height: 50,
                    width: 50,
                  ),
                )),
                Expanded(
                  child: Center(
                    child: SizedBox(
                      key: keyBottomNavigation3,
                      height: 50,
                      width: 50,
                    ),
                  ),
                ),
              ],
            ),
          ),
          FloatingNavbar(
              width: MediaQuery.of(context).size.width,
              elevation: 5,
              margin: const EdgeInsets.only(left: 18, right: 18),
              selectedBackgroundColor: Colors.blue,
              backgroundColor: Colors.white,
              unselectedItemColor: Colors.black,
              selectedItemColor: Colors.white,
              itemBorderRadius: 28,
              // iconSize: 50,
              items: [
                FloatingNavbarItem(
                  customWidget: 'assets/icons/category_icon.svg',
                ),
                FloatingNavbarItem(
                  customWidget: 'assets/icons/star_icon.svg',
                ),
                FloatingNavbarItem(
                  customWidget: 'assets/icons/iconly_light_profile.svg',
                ),
              ],
              currentIndex: 3,
              onTap: (index) {}),
        ],
      ),
    );
  }

  void showTutorial() {
    initTargets();
    tutorialCoachMark = TutorialCoachMark(
      context,
      targets: targets,
      colorShadow: Colors.black,
      textSkip: "SKIP",
      paddingFocus: 10,
      opacityShadow: 0.8,
      onFinish: () {
        print("finish");
      },
      onClickTarget: (target) {
        print('onClickTarget: $target');
      },
      onClickOverlay: (target) {
        print('onClickOverlay: $target');
      },
      onSkip: () {
        print("skip");
      },
    )..show();
  }

  void initTargets() {
    targets.clear();
    targets.add(
      TargetFocus(
        identify: "keyBottomNavigation1",
        keyTarget: keyBottomNavigation1,
        alignSkip: Alignment.topRight,
        contents: [
          TargetContent(
            align: ContentAlign.right,
            builder: (context, controller) {
              return Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 70,
                      width: 250,
                      decoration: BoxDecoration(
                          color: const Color(0x33000000),
                          borderRadius: BorderRadius.circular(8)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, top: 10),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: const Text(
                            "Раздел категорий",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 20.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );

    // targets.add(
    //   TargetFocus(
    //     identify: "keyBottomNavigation2",
    //     keyTarget: keyBottomNavigation2,
    //     alignSkip: Alignment.topRight,
    //     contents: [
    //       TargetContent(
    //         align: ContentAlign.top,
    //         builder: (context, controller) {
    //           return Container(
    //             child: Column(
    //               mainAxisSize: MainAxisSize.min,
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: <Widget>[
    //                 Text(
    //                   "Информация",
    //                   style: TextStyle(
    //                     color: Colors.white,
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           );
    //         },
    //       ),
    //     ],
    //   ),
    // );

    // targets.add(
    //   TargetFocus(
    //     identify: "keyBottomNavigation3",
    //     keyTarget: keyBottomNavigation3,
    //     alignSkip: Alignment.topRight,
    //     contents: [
    //       TargetContent(
    //         align: ContentAlign.top,
    //         builder: (context, controller) {
    //           return Container(
    //             child: Column(
    //               mainAxisSize: MainAxisSize.min,
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: <Widget>[
    //                 Text(
    //                   "Информация",
    //                   style: TextStyle(
    //                     color: Colors.white,
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           );
    //         },
    //       ),
    //     ],
    //   ),
    // );

    targets.add(
      TargetFocus(
        identify: "Target 0",
        keyTarget: keyButton1,
        contents: [
          TargetContent(
            align: ContentAlign.right,
            builder: (context, controller) {
              return Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 70,
                      width: 250,
                      decoration: BoxDecoration(
                          color: const Color(0x33000000),
                          borderRadius: BorderRadius.circular(8)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 40, top: 10),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: const Text(
                            "Здесь находятся популярные",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 20.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
        shape: ShapeLightFocus.RRect,
        radius: 6,
      ),
    );
    targets.add(
      TargetFocus(
        identify: "Target 0",
        keyTarget: keyButton,
        contents: [
          TargetContent(
            align: ContentAlign.left,
            builder: (context, controller) {
              return Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 70,
                      width: 250,
                      decoration: BoxDecoration(
                          color: const Color(0x33000000),
                          borderRadius: BorderRadius.circular(8)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 40, top: 10),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: const Text(
                            "Сюда попадают ваши подборки",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 20.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
        shape: ShapeLightFocus.RRect,
        radius: 6,
      ),
    );
  }
}
