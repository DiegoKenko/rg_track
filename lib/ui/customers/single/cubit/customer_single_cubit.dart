import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:result_dart/result_dart.dart';
import 'package:rg_track/datasource/customer/customer_datasource.dart';
import 'package:rg_track/model/customer.dart';
import 'package:rg_track/model/error_entity.dart';
import 'package:rg_track/ui/customers/single/cubit/customer_single_state.dart';

class CustomerSingleCubit extends Cubit<CustomerSingleState> {
  CustomerSingleCubit() : super(CustomerSingleInitialState());

  Future<Result<Customer, ErrorEntity>> create(Customer customer) async {
    emit(CustomerSingleLoadingState());
    return await CustomerDatasource().create(customer).fold((success) {
      emit(CustomerSingleSuccessState(customer: success));
      return success.toSuccess();
    }, (error) {
      emit(CustomerSingleErrorState(exception: error));
      return Failure(error);
    });
  }

  Future<Result<Customer, ErrorEntity>> update(Customer customer) async {
    emit(CustomerSingleLoadingState());
    return await CustomerDatasource().update(customer).fold((success) {
      emit(CustomerSingleSuccessState(customer: success));
      return success.toSuccess();
    }, (error) {
      emit(CustomerSingleErrorState(exception: error));
      return Failure(error);
    });
  }

  Future<List<Customer>> getSubCustomerAllowed(
      String userId, Customer current) async {
    return await CustomerDatasource().getCustomersUser(userId).fold((success) {
      success.removeWhere((element) => element.id == current.id);
      return success;
    }, (error) => []);
  }
}
