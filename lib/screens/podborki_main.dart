import 'package:blogonomy/cubit/bottom_navigation_bar.dart';
import 'package:blogonomy/cubit/network/card_cubitCateg.dart';
import 'package:blogonomy/cubit/network/card_stateCateg.dart';
import 'package:blogonomy/cubit/network/filters_model.dart';
import 'package:blogonomy/cubit/panel_controller_cubit.dart';
import 'package:blogonomy/main.dart';
import 'package:blogonomy/widget/card_view.dart';
import 'package:blogonomy/widget/podborka.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/src/provider.dart';

class PodborkiMain extends StatelessWidget {
  const PodborkiMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    podborkaBool.public = false;
    CardCubit2 cardCubit2 = context.read<CardCubit2>();
    cardCubit2.fetchCard();

    return BlocBuilder<CardCubit2, CardState2>(builder: (context, state) {
      if (state is CardLoadingState2) {
        return Center(child: CircularProgressIndicator());
      }
      if (state is CardLoadedState2) {
        if (state.loadedCard?.isEmpty == true) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SvgPicture.asset('assets/icons/info_square.svg'),
                    ),
                    width: 60.0,
                    height: 60.0,
                    decoration: new BoxDecoration(
                      color: Color(0xFFfff9e6),
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Вы еще не создали ни одной подборки',
                    style: TextStyle(
                      fontFamily: 'Roboto-Bold.ttf',
                      fontSize: 18.0,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
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
                        context
                            .read<BottomNavigationControllerSelect>()
                            .select(1);
                        context.read<SlidingUpCubit2>().open();
                      },
                      child: const SizedBox(
                        height: 52,
                        child: Center(child: Text('Cоздать подборку')),
                      )),
                ],
              ),
            ),
          );
        } else {
          return RefreshIndicator(
              child: Column(children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                      physics: AlwaysScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.loadedCard?.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
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
                                    builder: (context) => Podborka()));
                          },
                          child: CardView(
                              id: '${state.loadedCard?[index].id}',
                              name: '${state.loadedCard?[index].name}',
                              image: state.loadedCard?[index].picUrl,
                              numberOfBloggers:
                                  state.loadedCard?[index].numBloggers ?? 1),
                        );
                      }),
                )
              ]),
              onRefresh: cardCubit2.fetchCard);
        }
      }
      return Text("Error");
    });
  }
}
