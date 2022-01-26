//import 'package:collections_page/cubit/failure.dart';
import 'package:blogonomy/Repository/card_repositoriesCateg.dart';
import 'package:blogonomy/cubit/network/auth_mode.dart';
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
  Future<List<BlogersModel>> getBlogersBy(int page) async {
    return await blogersRepository.getAllBlogers(page);
  }
}

class GettAllFilters {
  final FilterRepository filterRepository;
  GettAllFilters(this.filterRepository);
  Future<Object> getFiltersBy() async {
    return await filterRepository.gettAllFilters();
  }
}

class GettAllOneBloger {
  final OneBlogerRepository oneBlogerRepository;
  GettAllOneBloger(this.oneBlogerRepository);
  Future<Object> getOneBlogerBy() async {
    return await oneBlogerRepository.getOneBloger();
  }
}
