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

abstract class BlogersState {}

class BlogersEmptyState extends BlogersState {}

class BlogersLoadingState extends BlogersState {}

class BlogersLoadedState extends BlogersState {
  List<dynamic>? loadedBlogers;
  BlogersLoadedState({this.loadedBlogers}) {
    print('Blogers loaded  $loadedBlogers');
  }
}

class BlogersErrorState extends BlogersState {}

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
