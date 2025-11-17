import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/cart_item.dart';
import 'cart_state.dart';
import '../../../data/datasources/cart_firebase_data_source.dart';

class CartCubit extends Cubit<CartState> {
  final CartFirebaseDataSource cartDataSource;

  CartCubit(this.cartDataSource)
      : super(CartState(items: {}, loading: false)) {
    loadCart();
  }

  Future<void> loadCart() async {
    emit(state.copyWith(loading: true));
    try {
      final items = await cartDataSource.loadCart(cartDataSource.userId);
      emit(state.copyWith(items: items, loading: false));
    } catch (e) {
      emit(state.copyWith(loading: false));
    }
  }

  Future<void> saveCart() async {
    await cartDataSource.saveCart(cartDataSource.userId, state.items);
  }

  void addToCart(CartItem item) {
    final currentItems = Map<String, CartItem>.from(state.items);

    if (currentItems.containsKey(item.id)) {
      final oldItem = currentItems[item.id]!;
      currentItems[item.id] = CartItem(
        id: oldItem.id,
        name: oldItem.name,
        price: oldItem.price,
        imageUrl: oldItem.imageUrl,
        quantity: oldItem.quantity + item.quantity,
      );
    } else {
      currentItems[item.id] = item;
    }

    emit(state.copyWith(items: currentItems));
    saveCart();
  }

  void removeFromCart(String itemId) {
    final currentItems = Map<String, CartItem>.from(state.items);
    if (currentItems.containsKey(itemId)) {
      currentItems.remove(itemId);
      emit(state.copyWith(items: currentItems));
      saveCart();
    }
  }

  void increaseQuantity(String itemId) {
    final currentItems = Map<String, CartItem>.from(state.items);
    if (currentItems.containsKey(itemId)) {
      final oldItem = currentItems[itemId]!;
      currentItems[itemId] = CartItem(
        id: oldItem.id,
        name: oldItem.name,
        price: oldItem.price,
        imageUrl: oldItem.imageUrl,
        quantity: oldItem.quantity + 1,
      );
      emit(state.copyWith(items: currentItems));
      saveCart();
    }
  }

  void decreaseQuantity(String itemId) {
    final currentItems = Map<String, CartItem>.from(state.items);
    if (currentItems.containsKey(itemId)) {
      final oldItem = currentItems[itemId]!;
      if (oldItem.quantity > 1) {
        currentItems[itemId] = CartItem(
          id: oldItem.id,
          name: oldItem.name,
          price: oldItem.price,
          imageUrl: oldItem.imageUrl,
          quantity: oldItem.quantity - 1,
        );
      } else {
        currentItems.remove(itemId);
      }
      emit(state.copyWith(items: currentItems));
      saveCart();
    }
  }

  double get totalPrice {
    return state.items.values.fold(
      0.0,
      (sum, item) => sum + (item.price * item.quantity),
    );
  }
}
