import 'package:blogonomy/cubit/network/bloger_find_model.dart';
import 'package:blogonomy/cubit/network/card_cubitCateg.dart';
import 'package:blogonomy/cubit/network/card_stateCateg.dart';
import 'package:blogonomy/cubit/panel_controller_cubit.dart';
import 'package:blogonomy/main.dart';
import 'package:blogonomy/screens/bloger_profile_screen.dart';
import 'package:blogonomy/screens/blogers_screens.dart';
import 'package:blogonomy/screens/popular_tab.dart';
import 'package:blogonomy/widget/bloger_view.dart';
import 'package:blogonomy/widget/sliding_up/bloger_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/src/provider.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class Podborka extends StatefulWidget {
  const Podborka({Key? key}) : super(key: key);
  @override
  State<Podborka> createState() => PodborkaState();
}

class PodborkaState extends State<Podborka> {
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
          actions: [
            Container(
                child: IconButton(
              onPressed: () {
                context.read<SlidingUpCubit4>().open();
              },
              icon: Icon(Icons.edit),
              color: Colors.blue,
            )),
          ],
          iconTheme: IconThemeData(color: Colors.blue),
        )),
        body: SafeArea(
            child: Stack(children: [
          Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color(0xFFFFFFFF)),
              child: ListView(children: [
                const SizedBox(height: 4.0),
                Padding(
                  padding: const EdgeInsets.only(left: 1.0, right: 1.0),
                  child: Container(child: PodborkaList()),
                )
              ])),
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
  @override
  Widget build(BuildContext context) {
    BlogersCubit2 blogersCubit2 = context.read<BlogersCubit2>();
    blogersCubit2.fetchBlogers();

    return BlocBuilder<BlogersCubit2, BlogersState2>(builder: (context, state) {
      if (state is BlogersLoadingState2) {
        return Center(child: CircularProgressIndicator());
      }
      if (state is BlogersLoadedState2) {
        print("BlogersLoadedState");
        var i = 0;

        return RefreshIndicator(
            child: Column(children: [
              Container(
                child: ListView.builder(
                    physics: PageScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.loadedBlogers?.length,
                    itemBuilder: (context, index) {
                      i++;
                      return GestureDetector(
                        onTap: () {
                          blogerFindModel = BlogerFindModel(
                              id: "${state.loadedBlogers?[index].id}");

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BlogerProfileScreen()));
                        },
                        child: BlogerView(
                            id: '$i',
                            userName: '${state.loadedBlogers?[index].userName}',
                            //   fullName: '${state.loadedBlogers?[index].fullName}',

                            picUrl: '${state.loadedBlogers?[index].picUrl}',
                            // picUrl:
                            //     'https://img.desktopwallpapers.ru/animals/pics/wide/1920x1200/6369fc18cca723f6a53f8730d420e7ee.jpg',
                            er: state.loadedBlogers?[index].er ?? 1),
                      );
                    }),
              )
            ]),
            onRefresh: blogersCubit2.fetchBlogers);
      }
      return Text("Error");
    });
  }
}
