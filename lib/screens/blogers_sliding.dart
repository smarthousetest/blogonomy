import 'package:blogonomy/cubit/network/card_cubitCateg.dart';
import 'package:blogonomy/cubit/panel_controller_cubit.dart';
import 'package:blogonomy/screens/custom_bloger_sliding.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../main.dart';

class BlogersPanel extends StatefulWidget {
  @override
  State<BlogersPanel> createState() => BlogersPanelState();
}

final PanelController pc = new PanelController();

class BlogersPanelState extends State<BlogersPanel> {
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
  }
}
