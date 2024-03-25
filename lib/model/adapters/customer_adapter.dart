import 'package:hive/hive.dart';
import 'package:rg_track/model/customer.dart';

class CustomerAdapter extends TypeAdapter<Customer> {
  @override
  Customer read(BinaryReader reader) {
    Customer customer =
        Customer.fromMap(reader.readMap().cast<String, dynamic>());
    return customer;
  }

  @override
  int get typeId => 1;

  @override
  void write(BinaryWriter writer, Customer obj) {
    writer.writeMap(obj.toMap());
  }
}
