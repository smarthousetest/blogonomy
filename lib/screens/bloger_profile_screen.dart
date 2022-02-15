import 'dart:math';
import 'package:blogonomy/cubit/network/admin_cubit.dart';
import 'package:blogonomy/cubit/network/admin_state.dart';
import 'package:blogonomy/cubit/network/card_cubitCateg.dart';
import 'package:blogonomy/cubit/network/card_modelCateg.dart';
import 'package:blogonomy/cubit/network/card_stateCateg.dart';
import 'package:blogonomy/cubit/panel_controller_cubit.dart';
import 'package:blogonomy/cubit/network/apiCateg.dart';
import 'package:blogonomy/cubit/network/card_cubitCateg.dart';
import 'package:blogonomy/cubit/network/card_modelCateg.dart';
import 'package:blogonomy/cubit/network/card_stateCateg.dart';
import 'package:blogonomy/main.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pie_chart/pie_chart.dart' as prefix;

class ListItem<String> {
  bool selected;
  String data;
  String id;
  ListItem({required this.data, required this.selected, required this.id});
}

List? itemslist = [];
Future<String> outselected() async {
  late String? id = blogerFindModel.id;
  List<FilterOneModel> load = await FilterOneApi().getFilterOne(id!);
  itemslist = load
      .map(
          (e) => ListItem(data: e.name, selected: e.containsBlogger!, id: e.id))
      .toList();
  return "ok";
}

void setselected() async {
  List? send = [];
  for (var i = 0; i < itemslist!.length; i++) {
    if (itemslist?[i].selected == true) {
      send.add(itemslist?[i].id);
    }
  }
  late String? id = blogerFindModel.id;
  String whatres = await FilterOneApi().setFilterOne(id!, send);
}

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

        List? widgets1 = [];
        for (var item in state.loadedBloger?.ageGroupRatio.entries) {
          widgets1.add(
            Text("${item.key}: ${item.value}%",
                style: TextStyle(
                  fontFamily: 'Roboto-Bold.ttf',
                  fontSize: 14.0,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                )),
          );
        }

        List<BarChartGroupData> barGroups = [];

        int ichet = 0;
        for (var item in state.loadedBloger?.ageGroupRatio.entries) {
          barGroups.add(
            BarChartGroupData(
              x: ichet,
              barRods: [
                BarChartRodData(
                    y: item.value.roundToDouble(),
                    colors: [Colors.lightBlueAccent, Colors.blue])
              ],
              showingTooltipIndicators: [0],
            ),
          );
          ichet++;
        }

        return StatefulBuilder(// StatefulBuilder
            builder: (context, setState) {
          return Scaffold(
              body:
                  CustomScrollView(physics: ClampingScrollPhysics(), slivers: [
            SliverAppBar(
              iconTheme: IconThemeData(color: Colors.blue),
              toolbarHeight: 100,
              backgroundColor: Color(0xFFF5F5FF),
              elevation: 0,
              actions: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 23),
                      child: Container(
                          child: IconButton(
                              onPressed: () async {
                                showAlertDialogload(context);
                                await outselected();
                                Navigator.pop(context);
                                showAlertDialog(context);
                              },
                              icon: Icon(
                                Icons.library_books_outlined,
                                color: Color(0xFF0072FD),
                                size: 28,
                              ))),
                    ),
                    BlocBuilder<AdminCubit, AdminState>(
                        builder: (context, state) {
                      if (state is AdminState) {
                        Container(
                            child: IconButton(
                                onPressed: () async {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text('Выполняю обновление!'),
                                  ));
                                  String? result =
                                      await OneBlogerApi().updBloger();
                                  if (result == "OK") {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(
                                          'В скором времени информация обновится!'),
                                    ));
                                  }
                                  if (result == "ERR") {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(
                                          'Ошибка! Обратитесь в поддержку.'),
                                    ));
                                  }
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  Icons.refresh_outlined,
                                  color: Color(0xFF0072FD),
                                  size: 28,
                                )));
                      }
                      return Text('');
                    }),
                  ],
                ),
              ],
              title: Container(
                alignment: Alignment.center,
                height: 25.0,
                child: const Text(
                  'Информация о блогере',
                  style: TextStyle(
                    fontFamily: 'Roboto-Medium.ttf',
                    fontSize: 18.0,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF24282E),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
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
                                Spacer(
                                  flex: 1,
                                ),
                                Spacer(
                                  flex: 1,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Spacer(
                                  flex: 2,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
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
                              padding: EdgeInsets.only(
                                  top: 26, bottom: 20, right: 26),
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
                                  '${state.loadedBloger?.er?.toStringAsFixed(1)}',
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
                                margin: const EdgeInsets.only(
                                    left: 20.0, right: 21.0),
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
                                              state.loadedBloger?.hashtag!
                                                  .length, (int index) {
                                            return Chip(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                ),
                                                backgroundColor:
                                                    Color(0xFFF0F0FF),
                                                label: Text(
                                                    '${state.loadedBloger?.hashtag?[index].name}',
                                                    style: TextStyle(
                                                      fontFamily:
                                                          'Roboto-Bold.ttf',
                                                      fontSize: 15.0,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      fontWeight:
                                                          FontWeight.w400,
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
                                margin: const EdgeInsets.only(
                                    left: 20.0, right: 21.0),
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
                                                backgroundColor:
                                                    Color(0xFFF0F0FF),
                                                label: Text(
                                                    '${state.loadedBloger?.taggedUser?[index].name}',
                                                    style: TextStyle(
                                                      fontFamily:
                                                          'Roboto-Bold.ttf',
                                                      fontSize: 15.0,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      fontWeight:
                                                          FontWeight.w400,
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
                                                ? state.loadedBloger
                                                        ?.taggedUser!.length *
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
                        child: Container(
                          margin:
                              const EdgeInsets.only(left: 20.0, right: 21.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Гендер',
                                style: TextStyle(
                                  fontFamily: 'Roboto-Bold.ttf',
                                  fontSize: 18.0,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                              prefix.PieChart(
                                dataMap: {
                                  "Women": state.loadedBloger?.sexRatio.women
                                      .roundToDouble(),
                                  "Men": state.loadedBloger?.sexRatio.men
                                      .roundToDouble()
                                },
                                animationDuration: Duration(milliseconds: 800),
                                chartLegendSpacing: 32,
                                chartRadius:
                                    MediaQuery.of(context).size.width / 3.2,
                                colorList: [
                                  Colors.blue,
                                  Color(0xFFBBDEFB),
                                ],
                                initialAngleInDegree: 90,
                                legendOptions: prefix.LegendOptions(
                                  showLegends: false,
                                ),
                                chartValuesOptions: prefix.ChartValuesOptions(
                                  showChartValueBackground: false,
                                  showChartValues: false,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        "${state.loadedBloger?.sexRatio.women}%",
                                        style: TextStyle(
                                          fontFamily: 'Roboto-Bold.ttf',
                                          fontSize: 16.0,
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.blue,
                                        ),
                                      ),
                                      Text("Women",
                                          style: TextStyle(
                                            fontFamily: 'Roboto-Bold.ttf',
                                            fontSize: 15.0,
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFFB1B1D1),
                                          ))
                                    ],
                                  ),
                                  VerticalDivider(),
                                  Column(
                                    children: [
                                      Text(
                                        "${state.loadedBloger?.sexRatio.men}%",
                                        style: TextStyle(
                                          fontFamily: 'Roboto-Bold.ttf',
                                          fontSize: 16.0,
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xFFBBDEFB),
                                        ),
                                      ),
                                      Text("Men",
                                          style: TextStyle(
                                            fontFamily: 'Roboto-Bold.ttf',
                                            fontSize: 15.0,
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFFB1B1D1),
                                          ))
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Divider(),
                              const SizedBox(height: 8),
                              Text(
                                'Возраст',
                                style: TextStyle(
                                  fontFamily: 'Roboto-Bold.ttf',
                                  fontSize: 18.0,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                              // Center(
                              //   child: Container(
                              //     child: Column(
                              //       children:
                              //           List.generate(widgets1.length, (index) {
                              //         return widgets1[index];
                              //       }),
                              //     ),
                              //   ),
                              // ),
                              AspectRatio(
                                aspectRatio: 1.7,
                                child: Card(
                                  child: BarChart(
                                    BarChartData(
                                      gridData: FlGridData(show: false),
                                      barTouchData: barTouchData,
                                      titlesData: titlesData,
                                      borderData: borderData,
                                      barGroups: barGroups,
                                      alignment: BarChartAlignment.spaceAround,
                                      maxY: 100,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )),
                    const SizedBox(height: 16),
                    BlocBuilder<AdminCubit, AdminState>(
                        builder: (context, state) {
                      //var authState = context.read<AuthCubit>().state;
                      //(authState is LoginedState ||
                      if (state is NoAdminState)
                        return Container();
                      else
                        return Container(
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
                            child: Center(
                              child: GestureDetector(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return Dialog(
                                            child: Container(
                                          width: 100,
                                          height: 100,
                                          child: Column(
                                            children: [
                                              Text(
                                                  "Вы уверены что хотите удалить?"),
                                              Spacer(
                                                flex: 1,
                                              ),
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Spacer(
                                                      flex: 1,
                                                    ),
                                                    GestureDetector(
                                                      child: Text("Да"),
                                                    ),
                                                    Spacer(
                                                      flex: 1,
                                                    ),
                                                    GestureDetector(
                                                      child: Text("Нет"),
                                                    ),
                                                    Spacer(
                                                      flex: 1,
                                                    ),
                                                  ]),
                                              Spacer(
                                                flex: 1,
                                              )
                                            ],
                                          ),
                                        ));
                                      });
                                },
                                child: Text(
                                  "Удалить блогера",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.red),
                                ),
                              ),
                            ));
                    }),
                  ],
                ),
              ),
            )
          ]));
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

BarTouchData get barTouchData => BarTouchData(
      enabled: false,
      touchTooltipData: BarTouchTooltipData(
        tooltipBgColor: Colors.transparent,
        tooltipPadding: const EdgeInsets.all(0),
        tooltipMargin: 8,
        getTooltipItem: (
          BarChartGroupData group,
          int groupIndex,
          BarChartRodData rod,
          int rodIndex,
        ) {
          return BarTooltipItem(
            rod.y.round().toString(),
            const TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          );
        },
      ),
    );

FlTitlesData get titlesData => FlTitlesData(
      show: true,
      bottomTitles: SideTitles(
        showTitles: true,
        getTextStyles: (context, value) => const TextStyle(
          color: Color(0xff7589a2),
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
        margin: 20,
        getTitles: (double value) {
          switch (value.toInt()) {
            case 0:
              return '13-17';
            case 1:
              return '18-24';
            case 2:
              return '25-34';
            case 3:
              return '35-44';
            case 4:
              return '45-54';
            case 5:
              return '55-64';
            case 6:
              return '65+';
            default:
              return '';
          }
        },
      ),
      leftTitles: SideTitles(showTitles: false),
      topTitles: SideTitles(showTitles: false),
      rightTitles: SideTitles(showTitles: false),
    );

FlBorderData get borderData => FlBorderData(
      show: false,
    );

showAlertDialog(BuildContext context) {
  // set up the button
  Widget cancelButton = TextButton(
    child: Text("Отменить"),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  Widget okButton = TextButton(
    child: Text("Применить"),
    onPressed: () {
      setselected();

      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  var alert = StatefulBuilder(// StatefulBuilder
      builder: (context, setState) {
    return AlertDialog(
      title: Text("Категории"),
      content: Container(
        height: 200,
        child: SingleChildScrollView(
          child: Column(
            children: List.generate(itemslist!.length, (int index) {
              return Column(
                children: [
                  CheckboxListTile(
                    value: itemslist?[index].selected,
                    onChanged: (value) {
                      setState(() {
                        itemslist?[index].selected =
                            !itemslist?[index].selected;
                      });
                    },
                    title: Text("${itemslist?[index].data}"),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  ),
                  Divider(),
                ],
              );
            }),
          ),
        ),
      ),
      actions: [cancelButton, okButton],
    );
  });

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(// StatefulBuilder
          builder: (context, setState) {
        return alert;
      });
    },
  );
}

showAlertDialogload(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: Container(
        height: 200,
        width: 100,
        child: Center(child: CircularProgressIndicator())),
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
