import '../../domain/entities/item.dart';
import '../../domain/repositories/item_repository.dart';
import '../datasources/item_local_data_source.dart';
import '../datasources/item_firebase_data_source.dart';

class ItemRepositoryImpl implements ItemRepository {
  final ItemFirestoreDataSource firestoreDataSource;
  final ItemLocalDataSource localDataSource;

  ItemRepositoryImpl({
    required this.firestoreDataSource,
    required this.localDataSource,
  });

  @override
  Future<List<Item>> getItems() async {
    try {
      final items = await firestoreDataSource.getItems();
      return items;
    } catch (e) {
      print('Erro no Firestore: $e');
      return await localDataSource.getItems();
    }
  }

  @override
  Future<Item> getItemById(String id) async {
    try {
      return await firestoreDataSource.getItemById(id);
    } catch (e) {
      print('Erro no Firestore, usando dados locais: $e');
      return await localDataSource.getItemById(int.parse(id));
    }
  }

  @override
  Future<String> addItem(Item item) async {
    try {
      return await firestoreDataSource.addItem(item);
    } catch (e) {
      throw Exception('Erro ao adicionar item: $e');
    }
  }

  @override
  Future<void> updateItem(Item item) async {
    try {
      await firestoreDataSource.updateItem(item);
    } catch (e) {
      throw Exception('Erro ao atualizar item: $e');
    }
  }

  @override
  Future<void> deleteItem(String id) async {
    try {
      await firestoreDataSource.deleteItem(id);
    } catch (e) {
      throw Exception('Erro ao excluir item: $e');
    }
  }
}
