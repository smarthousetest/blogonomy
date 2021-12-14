import 'package:blogonomy/Repository/card_repositoriesCateg.dart';
import 'package:blogonomy/cubit/network/card_cubitCateg.dart';
import 'package:blogonomy/cubit/network/card_stateCateg.dart';
import 'package:blogonomy/main.dart';
import 'package:blogonomy/screens/bloger_profile_screen.dart';
import 'package:blogonomy/widget/bloger_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogersList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BlogersCubit blogersCubit = context.read<BlogersCubit>();
    blogersCubit.fetchBlogers();

    return BlocBuilder<BlogersCubit, BlogersState>(builder: (context, state) {
      if (state is BlogersLoadingState) {
        return Center(child: CircularProgressIndicator());
      }
      if (state is BlogersLoadedState) {
        print("BlogersLoadedState");
        var i = 0;
        return RefreshIndicator(
            child: Column(children: [
              Container(
                height: MediaQuery.of(context).size.height - 250,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                    //     physics: PageScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.loadedBlogers?.length,
                    itemBuilder: (context, index) {
                      i++;
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BlogerProfileScreen(
                                      state.loadedBlogers![index])));
                        },
                        child: BlogerView(
                            id: '$i',
                            userName: '${state.loadedBlogers?[index].userName}',
                            //   fullName: '${state.loadedBlogers?[index].fullName}',
                            picUrl: '${state.loadedBlogers?[index].picUrl}',
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
