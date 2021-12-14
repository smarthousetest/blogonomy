//import 'package:collections_page/cubit/failure.dart';
import 'package:blogonomy/Repository/card_repositoriesCateg.dart';
import 'package:blogonomy/cubit/network/card_modelCateg.dart';
import 'package:dartz/dartz.dart';

class GettAllCards {
  final CardRepository cardRepository;

  GettAllCards(this.cardRepository);
  Future<List<CardModel>> getCardBy() async {
    return await cardRepository.getAllCards();
  }
}

class GettAllBlogers {
  final BlogersRepository blogersRepository;

  GettAllBlogers(this.blogersRepository);
  Future<List<BlogersModel>> getBlogersBy() async {
    return await blogersRepository.getAllBlogers();
  }
}
