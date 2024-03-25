import 'package:equatable/equatable.dart';
import 'package:rg_track/model/customer.dart';
import 'package:rg_track/model/error_entity.dart';

abstract class CustomerListState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CustomerListInitialState extends CustomerListState {}

class CustomerListSuccessState extends CustomerListState {
  final List<Customer> customers;

  CustomerListSuccessState(this.customers);
}

class CustomerListErrorState extends CustomerListState {
  final ErrorEntity exception;

  CustomerListErrorState(this.exception);
}

class CustomerListLoadingState extends CustomerListState {}
