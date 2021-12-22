<<<<<<< HEAD
import 'dart:convert';
import 'dart:math';

import 'package:blogonomy/Repository/card_repositoriesCateg.dart';
import 'package:blogonomy/cubit/network/card_cubitCateg.dart';
import 'package:blogonomy/cubit/network/card_modelCateg.dart';
import 'package:blogonomy/cubit/network/card_stateCateg.dart';
import 'package:blogonomy/cubit/network/filters_model.dart';
import 'package:blogonomy/cubit/network/getAllCardsCateg.dart';
import 'package:blogonomy/cubit/panel_controller_cubit.dart';
import 'package:blogonomy/screens/custom_bloger_sliding.dart';
import 'package:dartz/dartz_unsafe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/src/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import '../main.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';

List<MultiSelectItem<ListCategotyFilters>>? items = [];
List? items2 = [];
List<ListCategotyFilters>? listik;
List<ListCategotyFilters>? listikselected;

List<dynamic>? loaded;
Future<void> fetchCarde() async {
  print("BlogersPanelStatefetchCarde");

  loaded = await CardRepository().getAllCards();
  print("++++++++++++++++++++++++++++++++++++++++++");

  print(loaded);

  listik = loaded
      ?.map((value) => ListCategotyFilters(id: value.id!, name: value.name!))
      .toList();

  items = listik
      ?.map((value) => MultiSelectItem<ListCategotyFilters>(value, value.name))
      .toList();

  items2 = listik
      ?.map((e) => {
            "display": "${e.name}",
            "value": ListCategotyFilters(id: e.id, name: e.name)
          })
      .toList();
  print("=====+++++++++++++++++++++++++++======ewqeqw");
  print(items2);
  print("=====+++++++++++++++++++++++++++======ewqeqw");
  print(listik);
  int imain = listik!.length;

  print("prime2 ${filterModels.id}");
  print("prime4 $listik");

  if (filterModels.id?.isEmpty == false) {
    for (var item in filterModels.id!) {
      for (var i = 0; i < imain; i++) {
        for (var item2 in listik!) {
          if (item2.id != item.id) {
            listik?.remove(item2);
            print("prime3 $item2");
            break;
          }
        }
      }
    }
  }

  // if (filterModels.id?.isEmpty == false) {
  //   for (var item in filterModels.id!) {
  //     for (var i = 0; i < imain; i++) {
  //       for (var item2 in listik!) {
  //         if (item2.id != item.id) {
  //           listik?.remove(item2);
  //           print("prime3 $item2");
  //           break;
  //         }
  //       }
  //     }
  //   }
  // }
  print("prime5 $listik");
  // if (filterModels.id?.isEmpty == false) {
  //   for (var item in filterModels.id!) {
  //     for (var item2 in listik!) {
  //       if (item2.id != item.id) {
  //         listik?.remove(item2);
  //         break;
  //       }
  //     }
  //   }
  // }

  // if (filterModels.id?.isEmpty == false) {
  //   for (var item in filterModels.id!) {
  //     print(item);
  //     print(listik?.remove(ListCategotyFilters(id: item.id, name: item.name)));
  //     print(item.id);
  //     print(item.name);
  //   }
  // }
  print(filterModels.id);
  print("++++++++++++++++++++++++++++++++++++++++++");
}
=======
import 'package:blogonomy/cubit/network/card_cubitCateg.dart';
import 'package:blogonomy/cubit/panel_controller_cubit.dart';
import 'package:blogonomy/screens/custom_bloger_sliding.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../main.dart';
>>>>>>> 50d9cf1265dc3f4d79fd3d70e05476ded861adcf

class BlogersPanel extends StatefulWidget {
  @override
  State<BlogersPanel> createState() => BlogersPanelState();
}

final PanelController pc = new PanelController();

class BlogersPanelState extends State<BlogersPanel> {
<<<<<<< HEAD
  @override
  void initState() {
    fetchCarde();

    print("BlogersPanelStateinitstate");

    FilterCubit filterCubit = context.read<FilterCubit>();
    filterCubit.fetchFilter();

    super.initState();
  }

  RangeValues currentRangeValueser = RangeValues(0, 15);
  RangeValues currentRangeValueslikes = RangeValues(0, 15);
  RangeValues currentRangeValuescomments = RangeValues(0, 15);

  final textCompilationController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterCubit, FilterState>(builder: (context, state) {
      if (state is FilterLoadingState) {
        return Center(child: CircularProgressIndicator());
      }
      if (state is FilterLoadedState) {
        if (state.loadedFilter?.filter?[4].roundToDouble() >
                currentRangeValueser.start.round() ||
            state.loadedFilter?.filter?[5].roundToDouble() <
                currentRangeValueser.end.round()) {
          currentRangeValueser = RangeValues(
              state.loadedFilter?.filter?[4].roundToDouble(),
              state.loadedFilter?.filter?[5].roundToDouble() == 0.0
                  ? 1.0
                  : state.loadedFilter?.filter?[5].roundToDouble());
        }

        if (state.loadedFilter?.filter?[2].roundToDouble() >
                currentRangeValueslikes.start.round() ||
            state.loadedFilter?.filter?[3].roundToDouble() <
                currentRangeValueslikes.end.round()) {
          currentRangeValueslikes = RangeValues(
              state.loadedFilter?.filter?[2].roundToDouble(),
              state.loadedFilter?.filter?[3].roundToDouble());
        }

        if (state.loadedFilter?.filter?[0].roundToDouble() >
                currentRangeValuescomments.start.round() ||
            state.loadedFilter?.filter?[1].roundToDouble() <
                currentRangeValuescomments.end.round()) {
          currentRangeValuescomments = RangeValues(
              state.loadedFilter?.filter?[0].roundToDouble(),
              state.loadedFilter?.filter?[1].roundToDouble());
        }

        BlogersCubit blogersCubit = context.read<BlogersCubit>();

        return Container(
          padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
          width: MediaQuery.of(context).size.width,
          child: Stack(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Абсолют лайков",
                        style: TextStyle(
                          color: Colors.grey,
                          fontFamily: 'Roboto-Bold.ttf',
                          fontSize: 12,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            currentRangeValueslikes.start.round().toString(),
                            style: TextStyle(
                              fontFamily: 'Roboto-Bold.ttf',
                              fontSize: 15,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(currentRangeValueslikes.end.round().toString(),
                              style: TextStyle(
                                fontFamily: 'Roboto-Bold.ttf',
                                fontSize: 15,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w700,
                              )),
                        ],
                      ),
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          // overlayShape: RoundSliderOverlayShape(overlayRadius: 20),
                          rangeThumbShape: CircleThumbShape(),
                        ),
                        child: RangeSlider(
                            values: currentRangeValueslikes,
                            max: state.loadedFilter?.filter?[3].roundToDouble(),
                            min: state.loadedFilter?.filter?[2].roundToDouble(),
                            divisions: state.loadedFilter?.filter?[3].round(),
                            onChanged: (RangeValues values) {
                              setState(() {
                                currentRangeValueslikes = values;
                              });
                            },
                            onChangeEnd: (RangeValues values) {
                              print("f333333333333333333333");

                              filterModels.absoluteLikesFilterMin =
                                  values.start.round().toString();

                              filterModels.absoluteLikesFilterMax =
                                  values.end.round().toString();

                              blogersCubit.fetchBlogers();
                            }),
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Абсолют комментариев",
                        style: TextStyle(
                          color: Colors.grey,
                          fontFamily: 'Roboto-Bold.ttf',
                          fontSize: 12,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            currentRangeValuescomments.start.round().toString(),
                            style: TextStyle(
                              fontFamily: 'Roboto-Bold.ttf',
                              fontSize: 15,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                              currentRangeValuescomments.end.round().toString(),
                              style: TextStyle(
                                fontFamily: 'Roboto-Bold.ttf',
                                fontSize: 15,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w700,
                              )),
                        ],
                      ),
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          // overlayShape: RoundSliderOverlayShape(overlayRadius: 20),
                          rangeThumbShape: CircleThumbShape(),
                        ),
                        child: RangeSlider(
                          values: currentRangeValuescomments,
                          max: state.loadedFilter?.filter?[1].roundToDouble(),
                          min: state.loadedFilter?.filter?[0].roundToDouble(),
                          divisions: state.loadedFilter?.filter?[1].round(),
                          onChanged: (RangeValues values) {
                            setState(() {
                              currentRangeValuescomments = values;
                            });
                          },
                          onChangeEnd: (RangeValues values) {
                            filterModels.absoluteCommentsFilterMin =
                                values.start.round().toString();

                            filterModels.absoluteCommentsFilterMax =
                                values.end.round().toString();

                            blogersCubit.fetchBlogers();
                          },
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Показатель ER, %",
                        style: TextStyle(
                          color: Colors.grey,
                          fontFamily: 'Roboto-Bold.ttf',
                          fontSize: 12,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            currentRangeValueser.start.round().toString(),
                            style: TextStyle(
                              fontFamily: 'Roboto-Bold.ttf',
                              fontSize: 15,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(currentRangeValueser.end.round().toString(),
                              style: TextStyle(
                                fontFamily: 'Roboto-Bold.ttf',
                                fontSize: 15,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w700,
                              )),
                        ],
                      ),
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          // overlayShape: RoundSliderOverlayShape(overlayRadius: 20),
                          rangeThumbShape: CircleThumbShape(),
                        ),
                        child: RangeSlider(
                            values: currentRangeValueser,
                            max: state.loadedFilter?.filter?[5]
                                        .roundToDouble() ==
                                    0.0
                                ? 1.0
                                : state.loadedFilter?.filter?[5]
                                    .roundToDouble(),
                            min: state.loadedFilter?.filter?[4].roundToDouble(),
                            divisions:
                                state.loadedFilter?.filter?[5].round() == 0
                                    ? 1
                                    : state.loadedFilter?.filter?[5].round(),
                            onChanged: (RangeValues values) {
                              setState(() {
                                currentRangeValueser = values;
                              });
                            },
                            onChangeEnd: (RangeValues values) {
                              filterModels.ermin =
                                  values.start.round().toString();

                              filterModels.ermax =
                                  values.end.round().toString();

                              blogersCubit.fetchBlogers();
                            }),
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),

                // const SizedBox(height: 24),
                // TextFormField(
                //   controller: textCompilationController,
                //   decoration: const InputDecoration(
                //     hintText: 'Название подборки',
                //     hintStyle: TextStyle(
                //       fontFamily: 'Roboto-Regular.ttf',
                //       fontSize: 15.0,
                //       fontStyle: FontStyle.normal,
                //       fontWeight: FontWeight.w400,
                //       color: Color(0xFFADB3BD),
                //     ),
                //     enabledBorder: OutlineInputBorder(
                //         borderSide:
                //             BorderSide(color: Color(0xFFADB3BD), width: 1.0),
                //         borderRadius: BorderRadius.all(Radius.circular(32.0))),
                //     focusedBorder: OutlineInputBorder(
                //         borderSide:
                //             BorderSide(color: Color(0xFFADB3BD), width: 1.0),
                //         borderRadius: BorderRadius.all(Radius.circular(32.0))),
                //   ),
                // ),

                // Column(
                //   children: [
                //     MultiSelectFormField(
                //       chipBackGroundColor: Colors.red,
                //       chipLabelStyle: TextStyle(fontWeight: FontWeight.bold),
                //       dialogTextStyle: TextStyle(fontWeight: FontWeight.bold),
                //       checkBoxActiveColor: Colors.red,
                //       checkBoxCheckColor: Colors.green,
                //       dialogShapeBorder: RoundedRectangleBorder(
                //           borderRadius:
                //               BorderRadius.all(Radius.circular(12.0))),
                //       title: Text(
                //         "Title Of Form",
                //         style: TextStyle(fontSize: 16),
                //       ),
                //       dataSource: items2,
                //       textField: 'display',
                //       valueField: 'value',
                //       okButtonLabel: 'OK',
                //       cancelButtonLabel: 'CANCEL',
                //       hintWidget: Text('Please choose one or more'),
                //       initialValue: filterModels.id ?? [],
                //       onSaved: (value) {
                //         if (value == null) return;
                //         setState(() {});
                //       },
                //     ),
                //     MultiSelectChipField(
                //       items: items ?? [],
                //       initialValue: listik,
                //       title: Text("Animals"),
                //       headerColor: Colors.blue.withOpacity(0.5),
                //       decoration: BoxDecoration(
                //         border: Border.all(color: Colors.blue, width: 1.8),
                //       ),
                //       selectedChipColor: Colors.blue.withOpacity(0.5),
                //       selectedTextStyle: TextStyle(color: Colors.blue[800]),
                //       onTap: (values) {
                //         filterModels.clearId();
                //         for (var item in values) {
                //           item = item as ListCategotyFilters;
                //           filterModels.id!.add(item);
                //         }

                //         print("prime1 ${filterModels.id}");
                //         //  fetchCarde();
                //         BlogersCubit blogersCubit =
                //             context.read<BlogersCubit>();
                //         blogersCubit.fetchBlogers();

                //         FilterCubit filterCubit = context.read<FilterCubit>();
                //         filterCubit.fetchFilter();
                //       },
                //     ),
                //     MultiSelectDialogField(
                //       //   initialChildSize: 0.4,
                //       listType: MultiSelectListType.CHIP,
                //       initialValue: listik,
                //       items: items ?? [],
                //       onConfirm: (values) {
                //         filterModels.clearId();
                //         print("---filterModels.id--- ${filterModels.id}");
                //         print("---filterModels.id--- ${values}");
                //         for (var item in values) {
                //           print(item);
                //           print(item.runtimeType);

                //           item = item as ListCategotyFilters;
                //           print(item.id);
                //           print(item.name);
                //           filterModels.id!.add(item);
                //         }

                //         print("---filterModels.id--- ${filterModels.id}");

                //         BlogersCubit blogersCubit =
                //             context.read<BlogersCubit>();
                //         blogersCubit.fetchBlogers();

                //         FilterCubit filterCubit = context.read<FilterCubit>();
                //         filterCubit.fetchFilter();
                //       },
                //     ),
                //     MultiSelectChipDisplay(
                //       icon: Icon(
                //         Icons.close,
                //         color: Colors.white,
                //       ),
                //       textStyle: TextStyle(color: Colors.white),
                //       chipColor: Colors.blue,
                //       scroll: true,
                //       items: filterModels.id
                //           ?.map((e) => MultiSelectItem(e, e.name))
                //           .toList(),
                //       onTap: (value) {
                //         setState(() {
                //           filterModels.id!.remove(value);
                //           print("filterModels.id: -${filterModels.id}-");
                //           BlogersCubit blogersCubit =
                //               context.read<BlogersCubit>();
                //           blogersCubit.fetchBlogers();

                //           FilterCubit filterCubit = context.read<FilterCubit>();
                //           filterCubit.fetchFilter();
                //         });
                //       },
                //     ),
                //     filterModels.id == null || filterModels.id == []
                //         ? Container(
                //             padding: EdgeInsets.all(10),
                //             alignment: Alignment.centerLeft,
                //             child: Text(
                //               "Выбраны все категории",
                //               style: TextStyle(color: Colors.black54),
                //             ))
                //         : Container(),
                //   ],
                // ),

                const SizedBox(height: 16),
                ElevatedButton(
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ))),
                    onPressed: () {
                      // FilterCubit filterCubit = context.read<FilterCubit>();
                      // filterCubit.fetchFilter();

                      // BlogersCubit blogersCubit = context.read<BlogersCubit>();
                      // blogersCubit.fetchBlogers();

                      // context.read<SlidingUpCubit2>().close();
                      context.read<SlidingUpCubit3>().open();
                    },
                    child: const SizedBox(
                      height: 52,
                      child: Center(child: Text('Cоздать подборку')),
                    )),
              ],
            ),
          ]),
        );
      }
      return GestureDetector(
          onTap: () {
            FilterCubit filterCubit = context.read<FilterCubit>();
            filterCubit.fetchFilter();
          },
          child: Text("Error"));
    });
=======
  final textCompilationController = TextEditingController();
  RangeValues _currentRangeValueser = const RangeValues(1, 3000);
  RangeValues _currentRangeValueslikes = const RangeValues(1, 3000);
  RangeValues _currentRangeValuescomments = const RangeValues(1, 3000);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Абсолют лайков",
                  style: TextStyle(
                    color: Colors.grey,
                    fontFamily: 'Roboto-Bold.ttf',
                    fontSize: 12,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _currentRangeValueslikes.start.round().toString(),
                      style: TextStyle(
                        fontFamily: 'Roboto-Bold.ttf',
                        fontSize: 15,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(_currentRangeValueslikes.end.round().toString(),
                        style: TextStyle(
                          fontFamily: 'Roboto-Bold.ttf',
                          fontSize: 15,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w700,
                        )),
                  ],
                ),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    // overlayShape: RoundSliderOverlayShape(overlayRadius: 20),
                    rangeThumbShape: CircleThumbShape(),
                  ),
                  child: RangeSlider(
                      values: _currentRangeValueslikes,
                      max: 3000,
                      divisions: 3000,
                      onChanged: (RangeValues values) {
                        setState(() {
                          _currentRangeValueslikes = values;
                        });
                      },
                      onChangeEnd: (RangeValues values) {
                        filterModels.absoluteLikesFilterMin =
                            values.start.round().toString();

                        filterModels.absoluteLikesFilterMax =
                            values.end.round().toString();
                      }),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Абсолют комментариев",
                  style: TextStyle(
                    color: Colors.grey,
                    fontFamily: 'Roboto-Bold.ttf',
                    fontSize: 12,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _currentRangeValuescomments.start.round().toString(),
                      style: TextStyle(
                        fontFamily: 'Roboto-Bold.ttf',
                        fontSize: 15,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(_currentRangeValuescomments.end.round().toString(),
                        style: TextStyle(
                          fontFamily: 'Roboto-Bold.ttf',
                          fontSize: 15,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w700,
                        )),
                  ],
                ),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    // overlayShape: RoundSliderOverlayShape(overlayRadius: 20),
                    rangeThumbShape: CircleThumbShape(),
                  ),
                  child: RangeSlider(
                    values: _currentRangeValuescomments,
                    max: 3000,
                    divisions: 3000,
                    onChanged: (RangeValues values) {
                      setState(() {
                        _currentRangeValuescomments = values;
                      });
                    },
                    onChangeEnd: (RangeValues values) {
                      filterModels.absoluteCommentsFilterMin =
                          values.start.round().toString();

                      filterModels.absoluteCommentsFilterMax =
                          values.end.round().toString();
                    },
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Показатель ER, %",
                  style: TextStyle(
                    color: Colors.grey,
                    fontFamily: 'Roboto-Bold.ttf',
                    fontSize: 12,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _currentRangeValueser.start.round().toString(),
                      style: TextStyle(
                        fontFamily: 'Roboto-Bold.ttf',
                        fontSize: 15,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(_currentRangeValueser.end.round().toString(),
                        style: TextStyle(
                          fontFamily: 'Roboto-Bold.ttf',
                          fontSize: 15,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w700,
                        )),
                  ],
                ),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    // overlayShape: RoundSliderOverlayShape(overlayRadius: 20),
                    rangeThumbShape: CircleThumbShape(),
                  ),
                  child: RangeSlider(
                      values: _currentRangeValueser,
                      max: 3000,
                      divisions: 3000,
                      onChanged: (RangeValues values) {
                        setState(() {
                          _currentRangeValueser = values;
                        });
                      },
                      onChangeEnd: (RangeValues values) {
                        filterModels.ermin = values.start.round().toString();
                        filterModels.ermax = values.end.round().toString();
                      }),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),

          // const SizedBox(height: 24),
          // TextFormField(
          //   controller: textCompilationController,
          //   decoration: const InputDecoration(
          //     hintText: 'Название подборки',
          //     hintStyle: TextStyle(
          //       fontFamily: 'Roboto-Regular.ttf',
          //       fontSize: 15.0,
          //       fontStyle: FontStyle.normal,
          //       fontWeight: FontWeight.w400,
          //       color: Color(0xFFADB3BD),
          //     ),
          //     enabledBorder: OutlineInputBorder(
          //         borderSide:
          //             BorderSide(color: Color(0xFFADB3BD), width: 1.0),
          //         borderRadius: BorderRadius.all(Radius.circular(32.0))),
          //     focusedBorder: OutlineInputBorder(
          //         borderSide:
          //             BorderSide(color: Color(0xFFADB3BD), width: 1.0),
          //         borderRadius: BorderRadius.all(Radius.circular(32.0))),
          //   ),
          // ),

          const SizedBox(height: 16),
          ElevatedButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ))),
              onPressed: () {
                BlogersCubit blogersCubit = context.read<BlogersCubit>();

                blogersCubit.fetchBlogers();
                context.read<SlidingUpCubit2>().close();
              },
              child: const SizedBox(
                height: 52,
                child: Center(child: Text('ПРИМЕНИТЬ ФИЛЬТР')),
              ))
        ],
      ),
    );
>>>>>>> 50d9cf1265dc3f4d79fd3d70e05476ded861adcf
  }
}
