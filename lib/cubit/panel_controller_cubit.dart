import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BaseState extends Equatable {}

class CloseState extends BaseState {
  @override
  List<Object?> get props => [];
}

class OpenState extends BaseState {
  @override
  List<Object?> get props => [];
}

class HideState extends BaseState {
  @override
  List<Object?> get props => [];
}

class ShowState extends BaseState {
  @override
  List<Object?> get props => [];
}

class SlidingUpCubit extends Cubit<BaseState> {
  SlidingUpCubit() : super(CloseState());

  Future<void> open() async {
    if (state is OpenState) emit(CloseState());

    emit(OpenState());
  }

  Future<void> hide() async {
    if (state is HideState) return;

    emit(HideState());
  }

  Future<void> show() async {
    if (state is HideState) return;

    emit(ShowState());
  }

  Future<void> close() async {
    if (state is CloseState) return;

    emit(CloseState());
  }
}

class SlidingUpCubit2 extends Cubit<BaseState> {
  SlidingUpCubit2() : super(CloseState());

  Future<void> open() async {
    if (state is OpenState) emit(CloseState());
    emit(OpenState());
  }

  Future<void> hide() async {
    if (state is HideState) return;
    emit(HideState());
  }

  Future<void> show() async {
    if (state is HideState) return;
    emit(ShowState());
  }

  Future<void> close() async {
    if (state is CloseState) return;
    emit(CloseState());
  }
}

class SlidingUpCubit3 extends Cubit<BaseState> {
  SlidingUpCubit3() : super(CloseState());

  Future<void> open() async {
    if (state is OpenState) emit(CloseState());
    emit(OpenState());
  }

  Future<void> hide() async {
    if (state is HideState) return;
    emit(HideState());
  }

  Future<void> show() async {
    if (state is HideState) return;
    emit(ShowState());
  }

  Future<void> close() async {
    if (state is CloseState) return;
    emit(CloseState());
  }
}

class SlidingUpCubit4 extends Cubit<BaseState> {
  SlidingUpCubit4() : super(CloseState());

  Future<void> open() async {
    if (state is OpenState) emit(CloseState());
    emit(OpenState());
  }

  Future<void> hide() async {
    if (state is HideState) return;
    emit(HideState());
  }

  Future<void> show() async {
    if (state is HideState) return;
    emit(ShowState());
  }

  Future<void> close() async {
    if (state is CloseState) return;
    emit(CloseState());
  }
}
