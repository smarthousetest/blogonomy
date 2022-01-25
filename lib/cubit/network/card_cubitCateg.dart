import 'package:blogonomy/Repository/card_repositoriesCateg.dart';
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
    var oldPosts = <BlogersModel>[];

    print("size-1");

    if (pagen != "scrool") {
      page = 1;
      oldPosts.clear();

      print("size-2");
      emit(BlogersEmptyState());

      print("size-3");
    }

    print("size-4");
    if (state is BlogersLoadingState) return;

    print("size-5");
    final currentState = state;

    print("size-6");
    if (currentState is BlogersLoadedState) {
      oldPosts = currentState.loadedBlogers;

      print("size-6+");
    }

    print("size-7");
    emit(BlogersLoadingState(oldPosts, isFirstFetch: page == 1));

    print("size-8");
    blogersRepository.getAllBlogers(page).then((newPosts) {
      print("size-9");
      page++;

      print("size-10");
      final posts = (state as BlogersLoadingState).oldblogers;

      print("size-11");
      posts.addAll(newPosts);

      print("size-12");
      emit(BlogersLoadedState(posts));

      print("size-13");
    });
  }

  Future<void> clearBlogers() async {
    emit(BlogersEmptyState());
  }
}

class BlogersCubit2 extends Cubit<BlogersState2> {
  final BlogersRepository blogersRepository;

  BlogersCubit2(this.blogersRepository) : super(BlogersLoadedState2());

  Future<void> fetchBlogers({int page = 1}) async {
    try {
      emit(BlogersLoadingState2());
      final List<BlogersModel> _loaded2 =
          await blogersRepository.getAllBlogers(page);
      print("приватная  $_loaded2");
      emit(BlogersLoadedState2(loadedBlogers: _loaded2));
    } catch (_) {
      emit(BlogersErrorState2());
    }
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
