import 'package:blogonomy/Repository/card_repositoriesCateg.dart';
import 'package:blogonomy/cubit/bottom_navigation_bar.dart';
import 'package:blogonomy/cubit/network/admin_cubit.dart';
import 'package:blogonomy/cubit/network/admin_state.dart';
import 'package:blogonomy/cubit/network/card_cubitCateg.dart';
import 'package:blogonomy/cubit/network/card_stateCateg.dart';
import 'package:blogonomy/cubit/network/filters_model.dart';
import 'package:blogonomy/main.dart';
import 'package:blogonomy/screens/blogers_sliding.dart';
import 'package:blogonomy/widget/card_view.dart';
import 'package:blogonomy/widget/podborka.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Popular extends StatefulWidget {
  const Popular({Key? key}) : super(key: key);

  @override
  State<Popular> createState() => _PopularState();
}

class _PopularState extends State<Popular> {
  @override
  Widget build(BuildContext context) {
    podborkaBool.public = true;
    CardCubit cardCubit = context.read<CardCubit>();
    cardCubit.fetchCard();
    return BlocBuilder<AdminCubit, AdminState>(
      builder: (context, state) {
        if (state is AdminInState) {
          return BlocBuilder<CardCubit, CardState>(builder: (context, state) {
            if (state is CardLoadingState) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is CardLoadedState) {
              return RefreshIndicator(
                  child: Column(children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.loadedCard?.length,
                          itemBuilder: (context, index) => GestureDetector(
                                onTap: () {
                                  // BlogersCubit blogersCubit =
                                  //     context.read<BlogersCubit>();
                                  // context
                                  //     .read<BottomNavigationControllerSelect>()
                                  //     .select(1);

                                  // filterModels.clearAll();

                                  // ListCategotyFilters one = ListCategotyFilters(
                                  //     id: state.loadedCard?[index].id,
                                  //     name: state.loadedCard?[index].name);

                                  // filterModels.id!.add(one);

                                  // print("filterModels: ${filterModels.id}");
                                  // filterModels.ermin = "";
                                  // filterModels.ermax = "";

                                  // //     blogersCubit.fetchBlogers();

                                  // FilterCubit filterCubit =
                                  //     context.read<FilterCubit>();
                                  // filterCubit.fetchFilter();

                                  filterModels.clearAll();
                                  ListCategotyFilters one = ListCategotyFilters(
                                      id: state.loadedCard?[index].id,
                                      name: state.loadedCard?[index].name);
                                  filterModels.id!.add(one);

                                  filterModels.date = state
                                      .loadedCard?[index].creationTime
                                      .toString();

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Podborka(
                                              index: index,
                                              name:
                                                  state.loadedCard?[index].name,
                                            )),
                                  );
                                },
                                child: CardView(
                                    id: '${state.loadedCard?[index].id}',
                                    name: '${state.loadedCard?[index].name}',
                                    // image:
                                    //     'https://img.desktopwallpapers.ru/animals/pics/wide/1920x1200/6369fc18cca723f6a53f8730d420e7ee.jpg',

                                    image: '${state.loadedCard?[index].picUrl}',
                                    numberOfBloggers:
                                        state.loadedCard?[index].numBloggers ??
                                            1),
                              )),
                    )
                  ]),
                  onRefresh: cardCubit.fetchCard);
            }
            return Text("Error");
          });
        } else if (state is NoAdminState) {
          return BlocBuilder<CardCubit, CardState>(builder: (context, state) {
            if (state is CardLoadingState) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is CardLoadedState) {
              return RefreshIndicator(
                  child: Column(children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.loadedCard?.length,
                          itemBuilder: (context, index) => GestureDetector(
                                onTap: () {
                                  BlogersCubit blogersCubit =
                                      context.read<BlogersCubit>();
                                  context
                                      .read<BottomNavigationControllerSelect>()
                                      .select(1);

                                  filterModels.clearAll();

                                  ListCategotyFilters one = ListCategotyFilters(
                                      id: state.loadedCard?[index].id,
                                      name: state.loadedCard?[index].name);

                                  filterModels.id!.add(one);

                                  print("filterModels: ${filterModels.id}");
                                  filterModels.ermin = "";
                                  filterModels.ermax = "";

                                  //     blogersCubit.fetchBlogers();

                                  FilterCubit filterCubit =
                                      context.read<FilterCubit>();
                                  filterCubit.fetchFilter();

                                  // filterModels.clearAll();
                                  // ListCategotyFilters one = ListCategotyFilters(
                                  //     id: state.loadedCard?[index].id,
                                  //     name: state.loadedCard?[index].name);
                                  // filterModels.id!.add(one);

                                  // filterModels.date = state
                                  //     .loadedCard?[index].creationTime
                                  //     .toString();

                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) => Podborka()));
                                },
                                child: CardView(
                                    id: '${state.loadedCard?[index].id}',
                                    name: '${state.loadedCard?[index].name}',
                                    // image:
                                    //     'https://img.desktopwallpapers.ru/animals/pics/wide/1920x1200/6369fc18cca723f6a53f8730d420e7ee.jpg',

                                    image: '${state.loadedCard?[index].picUrl}',
                                    numberOfBloggers:
                                        state.loadedCard?[index].numBloggers ??
                                            1),
                              )),
                    )
                  ]),
                  onRefresh: cardCubit.fetchCard);
            }
            return Text("Error");
          });
        }
        return Text('');
      },
    );
  }
}
