import 'package:blogonomy/cubit/network/auth_state.dart';
import 'package:equatable/equatable.dart';

abstract class ApiState {}

class Loading extends ApiState {
  @override
  List<Object?> get props => [];
}

class NoLoading extends ApiState {
  @override
  List<Object?> get props => [];
}
