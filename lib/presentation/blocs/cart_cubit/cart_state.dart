import '../../../domain/entities/cart_item.dart';

class CartState {
  final Map<String, CartItem> items;
  final bool loading;

  CartState({
    required this.items,
    required this.loading,
  });

  factory CartState.initial() => CartState(items: {}, loading: true);

  double get totalPrice {
    return items.values
        .fold(0, (sum, item) => sum + item.price * item.quantity);
  }

  CartState copyWith({
    Map<String, CartItem>? items,
    bool? loading,
  }) {
    return CartState(
      items: items ?? this.items,
      loading: loading ?? this.loading,
    );
  }
}
