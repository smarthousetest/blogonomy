//import 'package:collections_page/cubit/failure.dart';
import 'package:blogonomy/Repository/card_repositoriesCateg.dart';
import 'package:blogonomy/cubit/network/card_modelCateg.dart';
import 'package:dartz/dartz.dart';

class GettAllCards {
  final CardRepository cardRepository;
<<<<<<< HEAD
=======

>>>>>>> 50d9cf1265dc3f4d79fd3d70e05476ded861adcf
  GettAllCards(this.cardRepository);
  Future<List<CardModel>> getCardBy() async {
    return await cardRepository.getAllCards();
  }
}

class GettAllBlogers {
  final BlogersRepository blogersRepository;
<<<<<<< HEAD
=======

>>>>>>> 50d9cf1265dc3f4d79fd3d70e05476ded861adcf
  GettAllBlogers(this.blogersRepository);
  Future<List<BlogersModel>> getBlogersBy() async {
    return await blogersRepository.getAllBlogers();
  }
}
<<<<<<< HEAD

class GettAllFilters {
  final FilterRepository filterRepository;
  GettAllFilters(this.filterRepository);
  Future<Object> getFiltersBy() async {
    return await filterRepository.gettAllFilters();
  }
}
=======
>>>>>>> 50d9cf1265dc3f4d79fd3d70e05476ded861adcf
