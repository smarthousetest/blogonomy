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

List<ListCategotyFilters>? listikloaded;
List? listikload = [];
List? itemslist = [];

class ListItem<String> {
  bool selected;
  String data;
  ListItem({required this.data, required this.selected});
}

List<dynamic>? loaded;
Future<void> fetchCarde() async {
  loaded = await CardRepository().getAllCards();
  listikloaded = loaded
      ?.map((value) => ListCategotyFilters(id: value.id!, name: value.name!))
      .toList();
  listikload = loaded?.map((value) => value.name!).toList();
}

Future<void> fetchCarde2() async {
  loaded = await CardRepository().getAllCards2();
  listikloaded = loaded
      ?.map((value) => ListCategotyFilters(id: value.id!, name: value.name!))
      .toList();
  listikload = loaded?.map((value) => value.name!).toList();
}

void outselected() {
  List? itemsSelected = [];

  itemsSelected = filterModels.id?.map((e) => e.name).toList() ?? null;

  if (itemsSelected != null) {
    itemslist = listikload
        ?.map((e) => ListItem(
            data: e, selected: itemsSelected!.contains(e) ? true : false))
        .toList();
  } else {
    if (itemsSelected == null) {
      itemslist =
          listikload?.map((e) => ListItem(data: e, selected: false)).toList();
    }
  }
}

void setselected() {
  filterModels.id = [];
  for (var i = 0; i < listikload!.length; i++) {
    if (listikload?.contains(itemslist?[i].data) == true) {
      if (itemslist?[i].selected == true) {
        filterModels.id?.add(listikloaded![i]);
      }
    }
  }
}

class BlogersPanel extends StatefulWidget {
  @override
  State<BlogersPanel> createState() => BlogersPanelState();
}

class BlogersPanelState extends State<BlogersPanel> {
  @override
  void initState() {
    podborkaBool.public = true;
    fetchCarde();

    FilterCubit filterCubit = context.read<FilterCubit>();
    filterCubit.fetchFilter();
    super.initState();
  }

  RangeValues currentRangeValueser = RangeValues(0, 15);
  RangeValues currentRangeValueslikes = RangeValues(0, 15);
  RangeValues currentRangeValuescomments = RangeValues(0, 15);
  RangeValues currentRangeValuessubscribers = RangeValues(0, 15);

  final textCompilationController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterCubit, FilterState>(builder: (context, state) {
      if (state is FilterLoadingState) {
        return Center(child: CircularProgressIndicator());
      }
      if (state is FilterLoadedState) {
        if (filterModels.absoluteCommentsFilterMax == "" &&
            filterModels.absoluteCommentsFilterMin == "") {
          print("gggg");
        }

        if (state.loadedFilter?.filter?[4].roundToDouble() >
                currentRangeValueser.start.round() ||
            state.loadedFilter?.filter?[5].roundToDouble() <
                currentRangeValueser.end.round() ||
            filterModels.ermax == "") {
          filterModels.ermax == "";
          filterModels.ermin == "";
          currentRangeValueser = RangeValues(
              state.loadedFilter?.filter?[4].roundToDouble(),
              state.loadedFilter?.filter?[5].roundToDouble() == 0.0
                  ? 1.0
                  : state.loadedFilter?.filter?[5].roundToDouble());
        }

        if (state.loadedFilter?.filter?[2].roundToDouble() >
                currentRangeValueslikes.start.round() ||
            state.loadedFilter?.filter?[3].roundToDouble() <
                currentRangeValueslikes.end.round() ||
            filterModels.absoluteLikesFilterMax == "") {
          filterModels.absoluteLikesFilterMax == "";
          filterModels.absoluteLikesFilterMin == "";
          currentRangeValueslikes = RangeValues(
              state.loadedFilter?.filter?[2].roundToDouble(),
              state.loadedFilter?.filter?[3].roundToDouble());
        }

        if (state.loadedFilter?.filter?[0].roundToDouble() >
                currentRangeValuescomments.start.round() ||
            state.loadedFilter?.filter?[1].roundToDouble() <
                currentRangeValuescomments.end.round() ||
            filterModels.absoluteCommentsFilterMax == "") {
          filterModels.absoluteCommentsFilterMax == "";
          filterModels.absoluteCommentsFilterMin == "";
          currentRangeValuescomments = RangeValues(
              state.loadedFilter?.filter?[0].roundToDouble(),
              state.loadedFilter?.filter?[1].roundToDouble());
        }

        if (state.loadedFilter?.filter?[6].roundToDouble() >
                currentRangeValuessubscribers.start.round() ||
            state.loadedFilter?.filter?[7].roundToDouble() <
                currentRangeValuessubscribers.end.round() ||
            filterModels.numFollowersmax == "") {
          filterModels.numFollowersmax == "";
          filterModels.numFollowersmin == "";
          currentRangeValuessubscribers = RangeValues(
              state.loadedFilter?.filter?[6].roundToDouble(),
              state.loadedFilter?.filter?[7].roundToDouble());
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
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Подписчиков",
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
                            currentRangeValuessubscribers.start
                                .round()
                                .toString(),
                            style: TextStyle(
                              fontFamily: 'Roboto-Bold.ttf',
                              fontSize: 15,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                              currentRangeValuessubscribers.end
                                  .round()
                                  .toString(),
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
                          rangeThumbShape: CircleThumbShape(),
                        ),
                        child: RangeSlider(
                            values: currentRangeValuessubscribers,
                            max: state.loadedFilter?.filter?[7]
                                        .roundToDouble() ==
                                    0.0
                                ? 1.0
                                : state.loadedFilter?.filter?[7]
                                    .roundToDouble(),
                            min: state.loadedFilter?.filter?[6].roundToDouble(),
                            divisions:
                                state.loadedFilter?.filter?[7].round() == 0
                                    ? 1
                                    : state.loadedFilter?.filter?[7].round(),
                            onChanged: (RangeValues values) {
                              setState(() {
                                currentRangeValuessubscribers = values;
                              });
                            },
                            onChangeEnd: (RangeValues values) {
                              filterModels.numFollowersmin =
                                  values.start.round().toString();

                              filterModels.numFollowersmax =
                                  values.end.round().toString();

                              blogersCubit.fetchBlogers();
                            }),
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    filterModels.id == null ||
                            filterModels.id == [] ||
                            filterModels.id?.isEmpty == true
                        ? Expanded(
                            flex: 3,
                            child: Container(
                                padding: EdgeInsets.all(4),
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Выбраны все категории",
                                  style: TextStyle(
                                    fontFamily: 'Roboto-Bold.ttf',
                                    fontSize: 14,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )),
                          )
                        : Expanded(
                            flex: 3,
                            child: MultiSelectChipDisplay(
                              icon: Icon(
                                Icons.close,
                                color: Colors.white,
                              ),
                              textStyle: TextStyle(color: Colors.white),
                              chipColor: Colors.blue,
                              scroll: true,
                              items: filterModels.id
                                  ?.map((e) => MultiSelectItem(e, e.name))
                                  .toList(),
                              onTap: (value) {
                                setState(() {
                                  filterModels.clearsettings();
                                  filterModels.id!.remove(value);
                                  print(
                                      "filterModels.id: -${filterModels.id}-");
                                  BlogersCubit blogersCubit =
                                      context.read<BlogersCubit>();
                                  blogersCubit.fetchBlogers();

                                  FilterCubit filterCubit =
                                      context.read<FilterCubit>();
                                  filterCubit.fetchFilter();
                                });
                              },
                            ),
                          ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          outselected();
                          showAlertDialog(context);
                        },
                        child: Text("Изменить",
                            style: TextStyle(
                              color: Colors.blue,
                              fontFamily: 'Roboto-Bold.ttf',
                              fontSize: 14,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w500,
                            )),
                      ),
                    )
                  ],
                ),
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
  }
}

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

      FilterCubit filterCubit = context.read<FilterCubit>();
      filterCubit.fetchFilter();

      BlogersCubit blogersCubit = context.read<BlogersCubit>();
      blogersCubit.fetchBlogers();

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
