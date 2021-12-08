//import 'package:collections_page/cubit/failure.dart';

import 'package:blogonomy/cubit/network/apiCateg.dart';
import 'package:blogonomy/cubit/network/card_modelCateg.dart';
import 'package:dartz/dartz.dart';

class CardRepository {
  CardApi cardApi = CardApi();
  Future<List<CardModel>> getAllCards() => cardApi.getCard();
}

class BlogersRepository {
  BlogersApi blogersdApi = BlogersApi();
  Future<List<BlogersModel>> getAllBlogers() => blogersdApi.getBloger();
}
