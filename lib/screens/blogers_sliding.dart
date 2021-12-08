import 'package:blogonomy/cubit/network/card_cubitCateg.dart';
import 'package:blogonomy/cubit/panel_controller_cubit.dart';
import 'package:blogonomy/screens/custom_bloger_sliding.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../main.dart';

class BlogersPanel extends StatefulWidget {
  VoidCallback param;
  BlogersPanel(this.param);
  @override
  State<BlogersPanel> createState() => BlogersPanelState();
}

final PanelController pc = new PanelController();

class BlogersPanelState extends State<BlogersPanel> {
  ScrollController scrollController = ScrollController();

  final textCompilationController = TextEditingController();

  RangeValues _currentRangeValues = const RangeValues(10, 1000);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      controller: scrollController,
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Показатель ER, %",
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                SizedBox(
                  height: 4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _currentRangeValues.start.round().toString(),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    Text(_currentRangeValues.end.round().toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15)),
                  ],
                ),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    // overlayShape: RoundSliderOverlayShape(overlayRadius: 20),
                    rangeThumbShape: CircleThumbShape(),
                  ),
                  child: RangeSlider(
                    values: _currentRangeValues,
                    min: 0,
                    max: 2000,
                    onChanged: (RangeValues values) {
                      setState(() {
                        _currentRangeValues = values;
                      });
                    },
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
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ))),
                    onPressed: () {
                      filterModels.ermin =
                          _currentRangeValues.start.round().toString();
                      filterModels.ermax =
                          _currentRangeValues.end.round().toString();

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
          )
        ],
      ),
    );
  }
}
