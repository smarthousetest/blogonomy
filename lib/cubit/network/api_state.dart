import 'package:equatable/equatable.dart';

abstract class ApiState extends Equatable {}

class Loading extends ApiState {
  @override
  List<Object?> get props => [];
}

class NoLoading extends ApiState {
  @override
  List<Object?> get props => [];
}
