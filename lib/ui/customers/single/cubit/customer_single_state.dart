import 'package:equatable/equatable.dart';
import 'package:rg_track/model/customer.dart';
import 'package:rg_track/model/error_entity.dart';

abstract class CustomerSingleState extends Equatable {
  const CustomerSingleState();

  @override
  List<Object> get props => [];
}

class CustomerSingleInitialState extends CustomerSingleState {}

class CustomerSingleLoadingState extends CustomerSingleState {}

class CustomerSingleErrorState extends CustomerSingleState {
  final ErrorEntity exception;

  const CustomerSingleErrorState({required this.exception});

  @override
  List<Object> get props => [exception];
}

class CustomerSingleSuccessState extends CustomerSingleState {
  final Customer customer;

  const CustomerSingleSuccessState({required this.customer});

  @override
  List<Object> get props => [customer];
}
