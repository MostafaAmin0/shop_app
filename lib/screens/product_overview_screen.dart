import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widget/main_drawer.dart';
import '../providers/cart_provider.dart';
import '../widget/badge.dart';
import '../widget/product_grid.dart';
import '../screens/cart_screen.dart';

enum Filter {
  all,
  favorite,
}

class ProductOverviewScreen extends StatefulWidget {
  const ProductOverviewScreen({Key? key}) : super(key: key);

  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  bool _showFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Products'),
        actions: [
          Consumer<CartProvider>(
            builder: (_, cart, fixedChild) => Badge(
              child: fixedChild!,
              value: cart.itemCount.toString(),
            ),
            child: IconButton(
              onPressed: () => Navigator.of(context).pushNamed(CartScreen.route),
              icon: const Icon(Icons.shopping_cart),
            ),
          ),
          PopupMenuButton(
            itemBuilder: (_) => [
              const PopupMenuItem(child: Text('Show All'), value: Filter.all),
              const PopupMenuItem(
                  child: Text('Only Favorite'), value: Filter.favorite),
            ],
            onSelected: (Filter selectedFilter) {
              if (selectedFilter == Filter.favorite && !_showFavorite) {
                setState(() {
                  _showFavorite = true;
                });
              } else if (selectedFilter == Filter.all && _showFavorite) {
                setState(() {
                  _showFavorite = false;
                });
              }
            },
          ),
        ],
      ),
      body: ProductGrid(_showFavorite),
      drawer: const MainDrawer(),
    );
  }
}
