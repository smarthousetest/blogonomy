import 'dart:async';

import 'package:blogonomy/Repository/card_repositoriesCateg.dart';
import 'package:blogonomy/cubit/network/bloger_find_model.dart';
import 'package:blogonomy/cubit/network/card_cubitCateg.dart';
import 'package:blogonomy/cubit/network/card_modelCateg.dart';
import 'package:blogonomy/cubit/network/card_stateCateg.dart';
import 'package:blogonomy/main.dart';
import 'package:blogonomy/screens/bloger_profile_screen.dart';
import 'package:blogonomy/widget/bloger_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

final scrollController = ScrollController();

void setupScrollController(context) {
  scrollController.addListener(() {
    if (scrollController.position.atEdge) {
      if (scrollController.position.pixels != 0) {
        print("state----start");

        BlocProvider.of<BlogersCubit>(context).fetchBlogers(pagen: "scrool");
      }
    }
  });
}

class BlogersList extends StatefulWidget {
  @override
  State<BlogersList> createState() => _BlogersListState();
}

class _BlogersListState extends State<BlogersList> {
  final scrollController = ScrollController();

  void setupScrollController(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          BlogersCubit blogersCubit = context.read<BlogersCubit>();
          blogersCubit.fetchBlogers(pagen: "scrool");
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    setupScrollController(context);
    BlocProvider.of<BlogersCubit>(context).fetchBlogers();

    print("state - $context");
    print("Открыл");
    print(filterModels.id);

    if (filterModels.date != "") {
      filterModels.clearAll();
    }

    return BlocBuilder<BlogersCubit, BlogersState>(builder: (context, state) {
      print("======================");
      print("state- $state");
      print("======================");

      if (state is BlogersLoadingState && state.isFirstFetch) {
        return _loadingIndicator();
      }

      List<BlogersModel> blogers = [];
      bool isLoading = false;

      if (state is BlogersLoadingState) {
        blogers = state.oldblogers as List<BlogersModel>;
        isLoading = true;
      } else if (state is BlogersLoadedState) {
        blogers = state.loadedBlogers as List<BlogersModel>;
      }

      BlogersCubit blogersCubit = context.read<BlogersCubit>();

      return RefreshIndicator(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 21.0),
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
                    print("filterModels.id: -${filterModels.id}-");

                    FilterCubit filterCubit = context.read<FilterCubit>();
                    filterCubit.fetchFilter();
                  });
                },
              ),
            ),
            Expanded(
              flex: 1,
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
            )
          ]),
          onRefresh: blogersCubit.fetchBlogers);
      return Text("Error");
    });
  }

  Widget _loadingIndicator() {
    return Center(child: CircularProgressIndicator());
  }
}
