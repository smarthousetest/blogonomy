//import 'package:collections_page/cubit/failure.dart';

import 'package:blogonomy/cubit/network/apiCateg.dart';
import 'package:blogonomy/cubit/network/card_modelCateg.dart';
<<<<<<< HEAD
import 'package:blogonomy/cubit/network/getAllCardsCateg.dart';
=======
>>>>>>> 50d9cf1265dc3f4d79fd3d70e05476ded861adcf
import 'package:dartz/dartz.dart';

class CardRepository {
  CardApi cardApi = CardApi();
  Future<List<CardModel>> getAllCards() => cardApi.getCard();
}

class BlogersRepository {
  BlogersApi blogersdApi = BlogersApi();
  Future<List<BlogersModel>> getAllBlogers() => blogersdApi.getBloger();
}
<<<<<<< HEAD

class FilterRepository {
  FilterLoadApi filterLoadApi = FilterLoadApi();

  Future<FilterModel> gettAllFilters() => filterLoadApi.getFilterLoad();
}
=======
>>>>>>> 50d9cf1265dc3f4d79fd3d70e05476ded861adcf
