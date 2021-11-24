import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/user_product_screen.dart';
import '../screens/cart_screen.dart';
import '../screens/order_screen.dart';
import '../providers/auth_provider.dart';
// import '../screens/auth_screen.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text('Hey you !'),
            automaticallyImplyLeading: false,
          ),
          buildTile(
            Icons.shop,
            'Shop',
            () {
              Navigator.of(context).pushNamed('/');
            },
          ),
          buildTile(
            Icons.shopping_cart,
            'Cart',
            () {
              Navigator.of(context).pushNamed(CartScreen.route);
            },
          ),
          buildTile(
            Icons.payment,
            'Orders',
            () {
              Navigator.of(context).pushNamed(OrderScreen.route);
            },
          ),
          buildTile(
            Icons.edit,
            'Manage Products',
            () {
              Navigator.of(context).pushNamed(UserProductScreen.route);
            },
          ),
          buildTile(
            Icons.exit_to_app,
            'Log Out',
            () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/');
              Provider.of<AuthProvider>(context, listen: false).logOut();
            },
          ),
        ],
      ),
    );
  }

  Column buildTile(IconData icon, String text, VoidCallback tapHandler) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon),
          title: Text(
            text,
            style: const TextStyle(
                fontFamily: 'RobotoCondensed',
                fontSize: 24,
                fontWeight: FontWeight.bold),
          ),
          onTap: tapHandler,
        ),
        const Divider(
          thickness: 2,
        ),
      ],
    );
  }
}
