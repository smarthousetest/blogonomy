import 'package:blogonomy/cubit/network/card_modelCateg.dart';

import 'package:flutter/material.dart';

abstract class CardState {}

class CardEmptyState extends CardState {}

class CardLoadingState extends CardState {}

class CardLoadedState extends CardState {
  List<dynamic>? loadedCard;
  CardLoadedState({this.loadedCard}) {}
}

class CardErrorState extends CardState {}

abstract class CardState2 {}

class CardEmptyState2 extends CardState2 {}

class CardLoadingState2 extends CardState2 {}

class CardLoadedState2 extends CardState2 {
  List<dynamic>? loadedCard;
  CardLoadedState2({this.loadedCard}) {}
}

class CardErrorState2 extends CardState2 {}

abstract class BlogersState {}

class BlogersEmptyState extends BlogersState {}

class BlogersInitial extends BlogersState {}

class BlogersLoadingState extends BlogersState {
  final List<BlogersModel> oldblogers;
  final bool isFirstFetch;

  BlogersLoadingState(this.oldblogers, {this.isFirstFetch = false});
}

class BlogersLoadedState extends BlogersState {
  List<BlogersModel> loadedBlogers;
  BlogersLoadedState(this.loadedBlogers) {
    print('Blogers loaded  $loadedBlogers');
  }
}

class BlogersErrorState extends BlogersState {}

abstract class BlogersState2 {}

class BlogersEmptyState2 extends BlogersState2 {}

class BlogersInitial2 extends BlogersState2 {}

class BlogersLoadingState2 extends BlogersState2 {
  final List<BlogersModel> oldblogers;
  final bool isFirstFetch;

  BlogersLoadingState2(this.oldblogers, {this.isFirstFetch = false});
}

class BlogersLoadedState2 extends BlogersState2 {
  List<BlogersModel> loadedBlogers;
  BlogersLoadedState2(this.loadedBlogers) {
    print('Blogers loaded  $loadedBlogers');
  }
}

class BlogersErrorState2 extends BlogersState2 {}

abstract class FilterState {}

class FilterEmptyState extends FilterState {}

class FilterLoadingState extends FilterState {}

class FilterLoadedState extends FilterState {
  FilterModel? loadedFilter;
  FilterLoadedState({this.loadedFilter}) {
    print('Filter loaded  $loadedFilter');
  }
}

class FilterErrorState extends FilterState {}

abstract class OneBlogerState {}

class OneBlogerEmptyState extends OneBlogerState {}

class OneBlogerLoadingState extends OneBlogerState {}

class OneBlogerLoadedState extends OneBlogerState {
  dynamic? loadedBloger;
  OneBlogerLoadedState({this.loadedBloger}) {
    print('Bloger loaded  $loadedBloger');
  }
}

class OneBlogerErrorState extends OneBlogerState {}
