import '../../domain/entities/item.dart';

abstract class ItemLocalDataSource {
  Future<List<Item>> getItems();
  Future<Item> getItemById(int id);
}