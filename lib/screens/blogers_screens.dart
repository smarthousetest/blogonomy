import 'package:blogonomy/Repository/card_repositoriesCateg.dart';
import 'package:blogonomy/cubit/network/bloger_find_model.dart';
import 'package:blogonomy/cubit/network/card_cubitCateg.dart';
import 'package:blogonomy/cubit/network/card_stateCateg.dart';
import 'package:blogonomy/main.dart';
import 'package:blogonomy/screens/bloger_profile_screen.dart';
import 'package:blogonomy/widget/bloger_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class BlogersList extends StatefulWidget {
  @override
  State<BlogersList> createState() => _BlogersListState();
}

class _BlogersListState extends State<BlogersList> {
  @override
  void initState() {
    BlogersCubit blogersCubit = context.read<BlogersCubit>();
    blogersCubit.fetchBlogers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("Открыл");
    print(filterModels.id);

    BlogersCubit blogersCubit = context.read<BlogersCubit>();
    // blogersCubit.fetchBlogers();

    return BlocBuilder<BlogersCubit, BlogersState>(builder: (context, state) {
      if (state is BlogersLoadingState) {
        return Center(child: CircularProgressIndicator());
      }
      if (state is BlogersLoadedState) {
        print("BlogersLoadedState");
        var i = 0;

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
                      filterModels.id!.remove(value);
                      print("filterModels.id: -${filterModels.id}-");
                      BlogersCubit blogersCubit = context.read<BlogersCubit>();
                      blogersCubit.fetchBlogers();

                      FilterCubit filterCubit = context.read<FilterCubit>();
                      filterCubit.fetchFilter();
                    });
                  },
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 4 / 5,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                    physics: ClampingScrollPhysics(),
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
            onRefresh: blogersCubit.fetchBlogers);
      }
      return Text("Error");
    });
  }
}
