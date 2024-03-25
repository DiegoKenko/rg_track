import 'package:equatable/equatable.dart';
import 'package:rg_track/model/customer.dart';

abstract class CustomerFormState extends Equatable {
  const CustomerFormState();

  @override
  List<Object> get props => [];
}

class CustomerFormInitial extends CustomerFormState {}

class ListCustomerFormState extends CustomerFormState {
  final List<Customer> customers;

  const ListCustomerFormState(this.customers);

  ListCustomerFormState.empty() : this([]);

  @override
  List<Object> get props => [customers];
}

class ListCustomerFormError extends CustomerFormState {
  final Exception error;

  const ListCustomerFormError(this.error);

  @override
  List<Object> get props => [error];
}
