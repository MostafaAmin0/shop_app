import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products_provider.dart';

import '../screens/edit_products_screen.dart';

class UserProductItem extends StatelessWidget {
  const UserProductItem(
      {Key? key, required this.title, required this.imageUrl, required this.id})
      : super(key: key);

  final String id;
  final String title;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final scaffoldMessenger=ScaffoldMessenger.of(context);
    return Column(
      children: [
        ListTile(
          title: Text(title),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(imageUrl),
          ),
          trailing: SizedBox(
            width: 100,
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      EditProductsScreen.route,
                      arguments: id,
                    );
                  },
                  icon: const Icon(Icons.edit),
                  color: Theme.of(context).colorScheme.primary,
                ),
                IconButton(
                  onPressed: () async{
                    try {
                      await Provider.of<ProductsProvider>(
                        context,
                        listen: false,
                      ).deleteProduct(id);
                    } catch (error) {
                      scaffoldMessenger.showSnackBar(
                        SnackBar(
                          content: Text(error.toString()),
                        ),
                      );
                    }
                  },
                  icon: const Icon(Icons.delete),
                  color: Theme.of(context).colorScheme.error,
                ),
              ],
            ),
          ),
        ),
        const Divider(),
      ],
    );
  }
}
