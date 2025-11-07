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
  Future<Item> getItemById(int id) async {
    try {
      return await firestoreDataSource.getItemById(id);
    } catch (e) {
      print('Erro no Firestore, usando dados locais: $e');
      return await localDataSource.getItemById(id);
    }
  }
}