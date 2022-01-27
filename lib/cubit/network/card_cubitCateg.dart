import 'package:blogonomy/Repository/card_repositoriesCateg.dart';
import 'package:blogonomy/cubit/locator_services.dart';
import 'package:blogonomy/cubit/network/auth_mode.dart';
import 'package:blogonomy/cubit/network/card_modelCateg.dart';
import 'package:blogonomy/cubit/network/card_stateCateg.dart';
import 'package:blogonomy/cubit/network/filters_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../main.dart';

class CardCubit extends Cubit<CardState> {
  final CardRepository cardRepository;

  CardCubit(this.cardRepository) : super(CardLoadedState());

  Future<void> fetchCard() async {
    try {
      emit(CardLoadingState());
      List<CardModel> _loaded = await cardRepository.getAllCards();
      print("приватная  $_loaded");
      emit(CardLoadedState(loadedCard: _loaded));
    } catch (_) {
      emit(CardErrorState());
    }
  }

  Future<void> clearCard() async {
    emit(CardEmptyState());
  }
}

class CardCubit2 extends Cubit<CardState2> {
  final CardRepository cardRepository;

  CardCubit2(this.cardRepository) : super(CardLoadedState2());

  Future<void> fetchCard() async {
    try {
      emit(CardLoadingState2());
      List<CardModel> _loaded = await cardRepository.getAllCards();
      print("приватная  $_loaded");
      emit(CardLoadedState2(loadedCard: _loaded));
    } catch (_) {
      emit(CardErrorState2());
    }
  }

  Future<void> clearCard() async {
    emit(CardEmptyState2());
  }
}

class BlogersCubit extends Cubit<BlogersState> {
  BlogersCubit(this.blogersRepository) : super(BlogersInitial());
  final BlogersRepository blogersRepository;
  int page = 1;

  Future<void> fetchBlogers({String pagen = "1"}) async {
    if (state is BlogersLoadingState) return;
    var oldPosts = <BlogersModel>[];

    if (pagen != "scrool") {
      page = 1;
      oldPosts.clear();
      emit(BlogersEmptyState());
      print("state-clear");
    }

    final currentState = state;
    if (currentState is BlogersLoadedState) {
      oldPosts = currentState.loadedBlogers;
    }
    emit(BlogersLoadingState(oldPosts, isFirstFetch: page == 1));
    giveBlogers();
  }

  Future<void> giveBlogers() async {
    blogersRepository.getAllBlogers(page).then((newPosts) {
<<<<<<< HEAD
      // if (newPosts.isEmpty == false) {
      page++;
      final posts = (state as BlogersLoadingState).oldblogers;
      posts.addAll(newPosts);
      emit(BlogersLoadedState(posts));
      if (newPosts == null) {
        return print("no new");
      }
      //}
=======
      if (newPosts != null) {
        page++;
        final posts = (state as BlogersLoadingState).oldblogers;
        posts.addAll(newPosts);
        emit(BlogersLoadedState(posts));
      }
>>>>>>> bf916b3e494f4739f4269c95c5679e82e359c574
    });
  }

  Future<void> clearBlogers() async {
    emit(BlogersEmptyState());
  }
}

class BlogersCubit2 extends Cubit<BlogersState2> {
  BlogersCubit2(this.blogersRepository) : super(BlogersInitial2());
  final BlogersRepository blogersRepository;
  int page = 1;

  Future<void> fetchBlogers({String pagen = "1"}) async {
    if (state is BlogersLoadingState2) return;
    var oldPosts = <BlogersModel>[];

    print("fetcj");

    if (pagen != "scrool") {
      page = 1;
      oldPosts.clear();
      emit(BlogersEmptyState2());
      print("state-clear");
    }

    final currentState = state;
    if (currentState is BlogersLoadedState2) {
      oldPosts = currentState.loadedBlogers;
    }
    emit(BlogersLoadingState2(oldPosts, isFirstFetch: page == 1));

    blogersRepository.getAllBlogers(page).then((newPosts) {
      if (newPosts != null) {
        page++;
        final posts = (state as BlogersLoadingState2).oldblogers;
        posts.addAll(newPosts);
        emit(BlogersLoadedState2(posts));
      }
    });
  }

  Future<void> clearBlogers() async {
    emit(BlogersEmptyState2());
  }
}

class FilterCubit extends Cubit<FilterState> {
  final FilterRepository filterRepository;

  FilterCubit(this.filterRepository) : super(FilterLoadedState());

  Future<void> fetchFilter() async {
    print("fetchFilter");

    try {
      print("1");
      emit(FilterLoadingState());
      print("2");
      final FilterModel _loaded = await filterRepository.gettAllFilters();
      print("3");
      print("приватная  $_loaded");
      emit(FilterLoadedState(loadedFilter: _loaded));
      print("4");
    } catch (_) {
      emit(FilterErrorState());
    }
    print("fetchFilter");
  }

  Future<void> clearFilter() async {
    emit(FilterEmptyState());
  }
}

class OneBlogerCubit extends Cubit<OneBlogerState> {
  final OneBlogerRepository oneBlogerRepository;

  OneBlogerCubit(this.oneBlogerRepository) : super(OneBlogerLoadedState());

  Future<void> fetchBloger() async {
    try {
      emit(OneBlogerLoadingState());
      final OneBlogerModel _loaded2 = await oneBlogerRepository.getOneBloger();
      print("приватная  $_loaded2");
      emit(OneBlogerLoadedState(loadedBloger: _loaded2));
    } catch (_) {
      emit(OneBlogerErrorState());
    }
  }

  Future<void> clearBloger() async {
    emit(OneBlogerEmptyState());
  }
}
