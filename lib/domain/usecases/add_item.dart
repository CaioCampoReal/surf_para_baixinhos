import '../entities/item.dart';
import '../repositories/item_repository.dart';

class AddItem {
  final ItemRepository repository;

  AddItem(this.repository);

  Future<String> call(Item item) async {
    return await repository.addItem(item);
  }
}
