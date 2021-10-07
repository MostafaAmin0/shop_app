import 'package:flutter/material.dart';

import '../model/product.dart';

class ProductItem extends StatelessWidget {
  const ProductItem(this.product, {Key? key}) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: Image.network(
        product.imageUrl,
        fit: BoxFit.cover,
      ),
      footer: GridTileBar(
        backgroundColor: Colors.black54,
        title: Text(
          product.title,
          textAlign: TextAlign.center,
        ),
        leading: IconButton(
          icon: const Icon(Icons.favorite_border_outlined),
          onPressed: () {},
        ),
        trailing: IconButton(
          icon: const Icon(Icons.shopping_cart_outlined),
          onPressed: () {},
        ),
      ),
    );
  }
}
