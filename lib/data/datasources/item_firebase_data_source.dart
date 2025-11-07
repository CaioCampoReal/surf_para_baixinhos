import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meu_projeto_integrador/domain/entities/item.dart';

abstract class ItemFirestoreDataSource {
  Future<List<Item>> getItems();
  Future<Item> getItemById(int id);
  Future<void> addItem(Item item);
  Future<void> updateItem(Item item);
  Future<void> deleteItem(int id);
}

class ItemFirestoreDataSourceImpl implements ItemFirestoreDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<List<Item>> getItems() async {
    try {
      final querySnapshot = await _firestore.collection('products').get();

      final items = querySnapshot.docs.map((doc) {
        final data = doc.data();
        return Item(
          id: int.tryParse(doc.id) ?? 0,
          nome: data['nome'] as String,
          preco: (data['preco'] as num).toDouble(),
          imageUrl: data['imageUrl'] as String,
          descricao: data['descricao'] as String,
        );
      }).toList();

      return items;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Item> getItemById(int id) async {
    try {
      final doc = await _firestore.collection('products').doc(id.toString()).get();

      if (!doc.exists) {
        throw Exception('Produto com id $id não encontrado');
      }

      final data = doc.data()!;
      return Item(
        id: int.tryParse(doc.id) ?? 0,
        nome: data['nome'] as String,
        preco: (data['preco'] as num).toDouble(),
        imageUrl: data['imageUrl'] as String,
        descricao: data['descricao'] as String,
      );
    } catch (e) {
      throw Exception('Erro ao buscar produto: $e');
    }
  }

  @override
  Future<void> addItem(Item item) async {
    try {
      await _firestore.collection('products').doc(item.id.toString()).set({
        'nome': item.nome,
        'preco': item.preco,
        'imageUrl': item.imageUrl,
        'descricao': item.descricao,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Erro ao adicionar produto: $e');
    }
  }

  @override
  Future<void> updateItem(Item item) async {
    try {
      await _firestore.collection('products').doc(item.id.toString()).update({
        'nome': item.nome,
        'preco': item.preco,
        'imageUrl': item.imageUrl,
        'descricao': item.descricao,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Erro ao atualizar produto: $e');
    }
  }

  @override
  Future<void> deleteItem(int id) async {
    try {
      await _firestore.collection('products').doc(id.toString()).delete();
    } catch (e) {
      throw Exception('Erro ao excluir produto: $e');
    }
  }
}