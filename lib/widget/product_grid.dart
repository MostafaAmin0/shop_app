import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';
import './product_item.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid(this.showFavs, {Key? key}) : super(key: key);

  final bool showFavs;

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductsProvider>(context);
    final loadedProducts =
        showFavs ? productsData.favoriteProducts : productsData.products;

    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: loadedProducts.length,
      itemBuilder: (ctx, index) {
        return ChangeNotifierProvider.value(
          value: loadedProducts[index],
          child: ProductItem(
            key: ValueKey(loadedProducts[index].id),
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
    );
  }
}
