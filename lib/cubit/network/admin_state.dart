import 'package:equatable/equatable.dart';

abstract class AdminState extends Equatable {}

class AdminInState extends AdminState {
  @override
  List<Object?> get props => [];
}

class NoAdminState extends AdminState {
  @override
  List<Object?> get props => [];
}
