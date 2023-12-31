import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_flutter/providers/cart_provider.dart';
import 'package:shop_app_flutter/widgets/cart_item.dart' as ci;

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Total',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const Spacer(),
                  Chip(
                    label: Text('\$${cart.totalAmount.toStringAsFixed(2)}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        )),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  // OrderButton(cart: cart),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (ctx, i) => ci.CartItem(
                cart.items.values.toList()[i].id,
                cart.items.values.toList()[i].productId,
                cart.items.values.toList()[i].price!,
                cart.items.values.toList()[i].quantity!,
                cart.items.values.toList()[i].title!,
              ),
              itemCount: cart.itemCount,
            ),
          ),
        ],
      ),
    );
  }
}

// class OrderButton extends StatefulWidget {
//   final Cart cart;
//
//   OrderButton({super.key, required this.cart});
//
//   @override
//   State<OrderButton> createState() => _OrderButtonState();
// }
//
// class _OrderButtonState extends State<OrderButton> {
//   var _isLoading = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return TextButton(
//       onPressed: (widget.cart.totalAmount <= 0 || _isLoading)
//           ? null
//           : () async {
//         setState(() {
//           _isLoading = true;
//         });
//         await Provider.of<Orders>(context, listen: false).addOrder(
//           widget.cart.items.values.toList(),
//           widget.cart.totalAmount,
//         );
//         widget.cart.clear();
//         Navigator.of(context)
//             .pushReplacementNamed(OrdersScreen.routeName);
//       },
//       style: TextButton.styleFrom(
//         foregroundColor: Theme.of(context).primaryColor,
//       ),
//       child: _isLoading
//           ? const CircularProgressIndicator()
//           : const Text('Order Now'),
//     );
//   }
// }
