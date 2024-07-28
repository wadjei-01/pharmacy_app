import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pharmacy_app/screens/cart/cart_screen.dart';
import 'package:pharmacy_app/screens/home/home_screen.dart';
import 'package:pharmacy_app/screens/product/product_screen.dart';

class AppRoutes {
  static final routerProvider = Provider<GoRouter>((ref) {
    return GoRouter(initialLocation: '/', routes: [
      GoRoute(
        path: HomeScreen.id,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: ProductScreen.id,
        builder: (context, state) {
          final product = state.extra as Map<String, dynamic>;
          return ProductScreen(productDetails: product);
        },
      ),
      GoRoute(
        path: CartScreen.id,
        builder: (context, state) {
          return const CartScreen();
        },
      ),
    ]);
  });
}
