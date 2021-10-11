import 'package:flutter/material.dart';
import 'package:shop_app/providers/products_provider.dart';

import '../widget/product_item.dart';
import 'package:provider/provider.dart';

class ProductOverviewScreen extends StatelessWidget {
  const ProductOverviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loadedProducts = Provider.of<ProductsProvider>(context).products;
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Products'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: loadedProducts.length,
        itemBuilder: (ctx, index) {
          return ChangeNotifierProvider.value(
            value: loadedProducts[index],
            child: const ProductItem(
                // loadedProducts[index].id,
                // loadedProducts[index].title,
                // loadedProducts[index].imageUrl,
                ),
          );
        },
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
      ),
    );
  }
}
