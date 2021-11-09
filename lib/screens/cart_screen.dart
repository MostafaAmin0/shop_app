import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/orders_provider.dart';

import '../widget/main_drawer.dart';
import '../providers/cart_provider.dart' show CartProvider;
import '../widget/cart_item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  static const route = '/cart';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your cart'),
      ),
      drawer: const MainDrawer(),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  const Spacer(),
                  Chip(
                    label: Text(
                      '\$${cart.totalPrice}',
                      style: Theme.of(context).primaryTextTheme.headline6,
                    ),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  OrderButton(cart: cart)
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: cart.itemCount,
              itemBuilder: (ctx, index) {
                var item = cart.items.values.toList()[index];
                return CartItem(
                  id: item.id,
                  price: item.price,
                  title: item.title,
                  quantity: item.quantity,
                  productId: cart.items.keys.toList()[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key? key,
    required this.cart,
  }) : super(key: key);

  final CartProvider cart;

  @override
  State<OrderButton> createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TextButton(
          onPressed: widget.cart.totalPrice <= 0 || _isLoading
              ? null
              : () async {
                  setState(() {
                    _isLoading = true;
                  });
                  await Provider.of<OrdersProvider>(
                    context,
                    listen: false,
                  ).addOrder(widget.cart.items.values.toList(),
                      widget.cart.totalPrice);
                  setState(() {
                    _isLoading = false;
                  });
                  widget.cart.clearCart();
                },
          child: Text(
            'Order Now',
            style: TextStyle(
              color: widget.cart.totalPrice <= 0 || _isLoading
                  ? Colors.grey
                  : Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        if (_isLoading) const CircularProgressIndicator(),
      ],
      alignment: Alignment.center,
    );
  }
}
