import '../../domain/entities/item.dart';
import '../mocks/item_list.dart';
import 'item_local_data_source.dart';

class ItemLocalDataSourceImpl implements ItemLocalDataSource {
  @override
  Future<List<Item>> getItems() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return itemsMock;
  }

  @override
  Future<Item> getItemById(int id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final item = itemsMock.firstWhere((item) => item.id == id);
    return item;
  }
}