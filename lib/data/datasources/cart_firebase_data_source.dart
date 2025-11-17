import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/entities/cart_item.dart';

class CartFirebaseDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  CartFirebaseDataSource({
    required this.firestore,
    required this.auth,
  });

  String get userId => auth.currentUser!.uid;

  Future<Map<String, CartItem>> loadCart(String uid) async {
    final snapshot = await firestore
        .collection('carts')
        .doc(uid)
        .collection('items')
        .get();

    final Map<String, CartItem> items = {};

    for (var doc in snapshot.docs) {
      items[doc.id] = CartItem.fromMap(doc.data());
    }

    return items;
  }

  Future<void> saveCart(String uid, Map<String, CartItem> items) async {
    final ref = firestore.collection('carts').doc(uid).collection('items');

    final existing = await ref.get();
    for (var doc in existing.docs) {
      await doc.reference.delete();
    }

    for (var entry in items.entries) {
      await ref.doc(entry.key).set(entry.value.toMap());
    }
  }
}
