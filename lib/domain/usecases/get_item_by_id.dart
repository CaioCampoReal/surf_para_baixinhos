import '../entities/item.dart';
import '../repositories/item_repository.dart';

class GetItemById {
  final ItemRepository repository;

  GetItemById(this.repository);

  Future<Item> call(String id) async {
    return await repository.getItemById(id);
  }
}
