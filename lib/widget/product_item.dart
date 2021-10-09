import 'package:flutter/material.dart';
import 'package:shop_app/screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  const ProductItem(this.id, this.title, this.imageUrl, {Key? key})
      : super(key: key);

  final String id;
  final String title;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailScreen.route,
              arguments: id,
            );
          },
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          title: Text(
            title,
            textAlign: TextAlign.center,
          ),
          leading: IconButton(
            icon: const Icon(Icons.favorite_border_outlined),
            color: Theme.of(context).colorScheme.secondary,
            onPressed: () {},
          ),
          trailing: IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            color: Theme.of(context).colorScheme.secondary,
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
