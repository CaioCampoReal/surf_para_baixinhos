import '../repositories/item_repository.dart';

class DeleteItem {
  final ItemRepository repository;

  DeleteItem(this.repository);

  Future<void> call(String id) async {
    return await repository.deleteItem(id);
  }
}
