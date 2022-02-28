import 'dart:async';

import 'package:blogonomy/cubit/network/admin_cubit.dart';
import 'package:blogonomy/cubit/network/admin_state.dart';
import 'package:blogonomy/cubit/network/apiCateg.dart';
import 'package:blogonomy/cubit/network/auth_cubit.dart';
import 'package:blogonomy/cubit/network/auth_state.dart';
import 'package:blogonomy/cubit/network/bloger_find_model.dart';
import 'package:blogonomy/cubit/network/card_cubitCateg.dart';
import 'package:blogonomy/cubit/network/card_modelCateg.dart';
import 'package:blogonomy/cubit/network/card_stateCateg.dart';
import 'package:blogonomy/cubit/panel_controller_cubit.dart';
import 'package:blogonomy/main.dart';
import 'package:blogonomy/screens/bloger_profile_screen.dart';
import 'package:blogonomy/screens/blogers_screens.dart';
import 'package:blogonomy/screens/blogers_sliding.dart';
import 'package:blogonomy/screens/popular_tab.dart';
import 'package:blogonomy/widget/bloger_view.dart';
import 'package:blogonomy/widget/sliding_up/bloger_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/src/provider.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class Podborka extends StatefulWidget {
  int index;
  String name;
  Podborka({Key? key, required this.index, required this.name})
      : super(key: key);
  @override
  State<Podborka> createState() => PodborkaState();
}

class PodborkaState extends State<Podborka> {
  bool _enabled = false;
  bool value = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: (AppBar(
          title: Container(
            alignment: Alignment.center,
            child: const Text(
              'Блогеры',
              style: TextStyle(
                fontFamily: 'Roboto-Medium.ttf',
                fontSize: 18.0,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w500,
                color: Color(0xFF24282E),
              ),
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                filterModels.clearAll();
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.chevron_left_outlined,
                color: Color(0xFF0072FD),
                size: 38,
              )),
          actions: [
            Container(
                child: IconButton(
              onPressed: () {
                context.read<SlidingUpCubit4>().open();
              },
              icon: Icon(Icons.edit),
              color: Colors.blue,
            )),
            BlocBuilder<AdminCubit, AdminState>(
              builder: (context, state) {
                print("admin $state ");
                if (state is AdminInState) {
                  return BlocBuilder<CardCubit, CardState>(
                      builder: ((context, state) {
                    if (state is CardLoadedState) {
                      return Switch(
                        value: _enabled,
                        onChanged: (value) {
                          Pod().update(state.loadedCard![widget.index].id,
                              state.loadedCard![widget.index].name, _enabled);
                          setState(() {
                            _enabled = value;
                          });
                        },
                        activeThumbImage: new NetworkImage(
                            'https://cdn-icons-png.flaticon.com/512/76/76296.png'),
                        inactiveThumbImage: new NetworkImage(
                            'https://e7.pngegg.com/pngimages/447/557/png-clipart-computer-icons-padlock-padlock-computer-technic.png'),
                      );
                    }
                    return Text('');
                  }));
                }
                return Text('');
              },
            )
          ],
          iconTheme: IconThemeData(color: Colors.blue),
        )),
        body: SafeArea(
            child: Stack(children: [
          PodborkaList(),
          SlidingUp4(),
        ])));
  }
}

class PodborkaList extends StatefulWidget {
  const PodborkaList({Key? key}) : super(key: key);

  @override
  _PodborkaListState createState() => _PodborkaListState();
}

class _PodborkaListState extends State<PodborkaList> {
  final scrollController = ScrollController();

  void setupScrollController(BuildContext context) {
    print("dddd1");
    scrollController.addListener(() {
      print("dddd2 ");
      if (scrollController.position.atEdge) {
        print("dddd3");
        if (scrollController.position.pixels != 0) {
          print("dddd4");
          BlogersCubit2 blogersCubit = context.read<BlogersCubit2>();
          blogersCubit.fetchBlogers(pagen: "scrool");
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    setupScrollController(context);
    BlocProvider.of<BlogersCubit2>(context).fetchBlogers();

    return BlocBuilder<BlogersCubit2, BlogersState2>(builder: (context, state) {
      if (state is BlogersLoadingState2 && state.isFirstFetch) {
        return _loadingIndicator();
      }

      List<BlogersModel> blogers = [];
      bool isLoading = false;

      if (state is BlogersLoadingState2) {
        blogers = state.oldblogers as List<BlogersModel>;
        isLoading = true;
      } else if (state is BlogersLoadedState2) {
        blogers = state.loadedBlogers as List<BlogersModel>;
      }

      BlogersCubit2 blogersCubit = context.read<BlogersCubit2>();

      return RefreshIndicator(
          child: ListView.builder(
              controller: scrollController,
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              itemCount: blogers.length + (isLoading ? 1 : 0),
              itemBuilder: (context, index) {
                if (index < blogers.length)
                  return GestureDetector(
                    onTap: () {
                      blogerFindModel =
                          BlogerFindModel(id: "${blogers[index].id}");

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BlogerProfileScreen()));
                    },
                    child: BlogerView(
                        id: '${index + 1}',
                        userName: '${blogers[index].userName}',
                        //   fullName: '${state.loadedBlogers?[index].fullName}',

                        picUrl: '${blogers[index].picUrl}',
                        // picUrl:
                        //     'https://img.desktopwallpapers.ru/animals/pics/wide/1920x1200/6369fc18cca723f6a53f8730d420e7ee.jpg',
                        er: blogers[index].er ?? 1),
                  );
                else {
                  Timer(Duration(milliseconds: 300), () {
                    scrollController
                        .jumpTo(scrollController.position.maxScrollExtent);
                  });

                  return _loadingIndicator();
                }
              }),
          onRefresh: blogersCubit.fetchBlogers);
    });
  }

  Widget _loadingIndicator() {
    return Center(child: CircularProgressIndicator());
  }
}
