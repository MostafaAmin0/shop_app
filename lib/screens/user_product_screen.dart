import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/widget/main_drawer.dart';

import '../providers/products_provider.dart';
import '../widget/user_product_item.dart';
import './edit_products_screen.dart';

class UserProductScreen extends StatelessWidget {
  const UserProductScreen({Key? key}) : super(key: key);

  static const route = '/user-product';

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<ProductsProvider>(context, listen: false).fetchData(true);
  }

  @override
  Widget build(BuildContext context) {
    ///will triger infinite loop
    // final productsData = Provider.of<ProductsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(EditProductsScreen.route),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      drawer: const MainDrawer(),
      body: FutureBuilder(
          future: _refreshProducts(context),
          builder: (context, snapshot) {
            return snapshot.connectionState == ConnectionState.waiting
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : RefreshIndicator(
                    onRefresh: () => _refreshProducts(context),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Consumer<ProductsProvider>(
                        builder: (ctx, productsData, _) => ListView.builder(
                          itemCount: productsData.products.length,
                          itemBuilder: (_, index) => UserProductItem(
                            id: productsData.products[index].id,
                            title: productsData.products[index].title,
                            imageUrl: productsData.products[index].imageUrl,
                          ),
                        ),
                      ),
                    ),
                  );
          }),
    );
  }
}
