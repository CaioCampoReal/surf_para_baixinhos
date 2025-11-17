import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meu_projeto_integrador/domain/entities/item.dart';

abstract class ItemFirestoreDataSource {
  Future<List<Item>> getItems();
  Future<Item> getItemById(String id);
  Future<String> addItem(Item item);
  Future<void> updateItem(Item item);
  Future<void> deleteItem(String id);
}

class ItemFirestoreDataSourceImpl implements ItemFirestoreDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<List<Item>> getItems() async {
    try {
      final querySnapshot = await _firestore.collection('products').get();

      return querySnapshot.docs.map((doc) {
        final data = doc.data();

        return Item(
          id: doc.id,
          nome: data['nome'] as String,
          preco: (data['preco'] as num).toDouble(),
          imageUrl: data['imageUrl'] as String,
          descricao: data['descricao'] as String,
          quantidade: (data['quantidade'] as num).toInt(),
        );
      }).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Item> getItemById(String id) async {
    try {
      final doc = await _firestore.collection('products').doc(id).get();

      if (!doc.exists) {
        throw Exception('Produto com id $id não encontrado');
      }

      final data = doc.data()!;
      return Item(
        id: doc.id,
        nome: data['nome'],
        preco: (data['preco'] as num).toDouble(),
        imageUrl: data['imageUrl'],
        descricao: data['descricao'],
        quantidade: (data['quantidade'] as num).toInt(),
      );
    } catch (e) {
      throw Exception('Erro ao buscar produto: $e');
    }
  }

  @override
  Future<String> addItem(Item item) async {
    try {
      final docRef = await _firestore.collection('products').add({
        'nome': item.nome,
        'preco': item.preco,
        'imageUrl': item.imageUrl,
        'descricao': item.descricao,
        'quantidade': item.quantidade,
        'createdAt': FieldValue.serverTimestamp(),
      });

      return docRef.id;
    } catch (e) {
      throw Exception('Erro ao adicionar produto: $e');
    }
  }

  @override
  Future<void> updateItem(Item item) async {
    try {
      await _firestore.collection('products').doc(item.id).update({
        'nome': item.nome,
        'preco': item.preco,
        'imageUrl': item.imageUrl,
        'descricao': item.descricao,
        'quantidade': item.quantidade,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Erro ao atualizar produto: $e');
    }
  }

  @override
  Future<void> deleteItem(String id) async {
    try {
      await _firestore.collection('products').doc(id).delete();
    } catch (e) {
      throw Exception('Erro ao excluir produto: $e');
    }
  }
}
