import '../entities/item.dart';
import '../repositories/item_repository.dart';

class UpdateItem {
  final ItemRepository repository;

  UpdateItem(this.repository);

  Future<void> call(Item item) async {
    return await repository.updateItem(item);
  }
}

