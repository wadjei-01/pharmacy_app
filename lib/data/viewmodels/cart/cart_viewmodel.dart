import 'package:collection/collection.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pharmacy_app/data/model/cart/cart_item.dart';
import 'package:pharmacy_app/data/model/product/product.dart';

class CartViewmodel extends Notifier<List<CartItem>> {
  @override
  List<CartItem> build() {
    return [];
  }

  double get subTotal =>
      state.fold(0, (value, item) => (item.quantity * item.price) + value);

  bool addToCart(Product product, int quantity) {
    final cartItem = CartItem.fromProduct(product, quantity);
    if (containsCartItem(cartItem)) return false;
    state.add(cartItem);
    ref.notifyListeners();
    return true;
  }

  bool containsCartItem(CartItem cartItem) {
    final item = state.firstWhereOrNull((element) => element.id == cartItem.id);
    return item != null;
  }

  void changeQuantity(CartItem cartItem, int quantity, int index) {
    state[index] = cartItem.copyWith(quantity: quantity);
    ref.notifyListeners();
  }

  void deleteAt(int index) {
    state.removeAt(index);
    ref.notifyListeners();
  }

  bool isCartEmpty() {
    return state.isEmpty;
  }

  static final provider =
      NotifierProvider<CartViewmodel, List<CartItem>>(CartViewmodel.new);
}
