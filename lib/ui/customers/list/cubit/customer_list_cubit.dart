import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:result_dart/result_dart.dart';
import 'package:rg_track/datasource/customer/customer_datasource.dart';
import 'package:rg_track/model/customer.dart';
import 'package:rg_track/model/error_entity.dart';
import 'package:rg_track/ui/customers/list/cubit/customer_list_state.dart';

class CustomerListCubit extends Cubit<CustomerListState> {
  CustomerListCubit() : super(CustomerListInitialState());

  Future<void> load(String userId) async {
    emit(CustomerListLoadingState());
    await CustomerDatasource().getCustomersUser(userId).fold((success) {
      emit(CustomerListSuccessState(success));
    }, (error) => emit(CustomerListErrorState(error)));
  }

  Future<Result<bool, ErrorEntity>> delete(Customer customer) async {
    return await CustomerDatasource().delete(customer.id!);
  }

  refreshCustomers() {}
}
