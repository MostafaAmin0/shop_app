import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/auth_provider.dart';
import '../screens/order_screen.dart';
import './providers/orders_provider.dart';
import './screens/cart_screen.dart';
import './screens/product_detail_screen.dart';
import './screens/product_overview_screen.dart';
import './providers/products_provider.dart';
import './providers/cart_provider.dart';
import './screens/user_product_screen.dart';
import './screens/edit_products_screen.dart';
import '../screens/auth_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => AuthProvider(),
        ),
        ChangeNotifierProxyProvider<AuthProvider, ProductsProvider>(
          create: (ctx) => ProductsProvider('', ''),
          update: (ctx, auth, _) =>
              ProductsProvider(auth.token as String, auth.userId),
        ),
        ChangeNotifierProvider(
          create: (ctx) => CartProvider(),
        ),
        ChangeNotifierProxyProvider<AuthProvider, OrdersProvider>(
          create: (ctx) => OrdersProvider('', ''),
          update: (ctx, auth, previousOrders) =>
              OrdersProvider(auth.token as String, auth.userId),
        ),
      ],
      child: Consumer<AuthProvider>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'Shop App',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)
                .copyWith(secondary: Colors.deepOrange),
            fontFamily: 'Lato',
          ),
          routes: {
            '/': (ctx) => auth.isAuth
                ? const ProductOverviewScreen()
                : const AuthScreen(),
            ProductDetailScreen.route: (ctx) => const ProductDetailScreen(),
            CartScreen.route: (ctx) => const CartScreen(),
            OrderScreen.route: (ctx) => const OrderScreen(),
            UserProductScreen.route: (ctx) => const UserProductScreen(),
            EditProductsScreen.route: (ctx) => const EditProductsScreen(),
          },
        ),
      ),
    );
  }
}
