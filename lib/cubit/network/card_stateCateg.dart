<<<<<<< HEAD
import 'package:blogonomy/cubit/network/card_modelCateg.dart';
=======
>>>>>>> 50d9cf1265dc3f4d79fd3d70e05476ded861adcf
import 'package:flutter/material.dart';

abstract class CardState {}

class CardEmptyState extends CardState {}

class CardLoadingState extends CardState {}

class CardLoadedState extends CardState {
  List<dynamic>? loadedCard;
<<<<<<< HEAD
  CardLoadedState({this.loadedCard}) {}
=======
  CardLoadedState({this.loadedCard}) {
    print('card loaded  $loadedCard');
  }
>>>>>>> 50d9cf1265dc3f4d79fd3d70e05476ded861adcf
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
<<<<<<< HEAD

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
=======
>>>>>>> 50d9cf1265dc3f4d79fd3d70e05476ded861adcf
