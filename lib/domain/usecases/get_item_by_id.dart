import '../entities/item.dart';
import '../repositories/item_repository.dart';

class GetItemById {
  final ItemRepository repository;
  
  GetItemById(this.repository);
  
  Future<Item> call(int id) async {
    return await repository.getItemById(id);
  }
}