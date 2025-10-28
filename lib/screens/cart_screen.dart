import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../providers/auth_provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    final auth = Provider.of<AuthProvider>(context, listen: false);
    final cart = Provider.of<CartProvider>(context, listen: false);
    if (auth.user != null) {
      cart.fetchCartForUser(auth.user!.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: cart.loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (_, i) {
                final it = cart.items[i];
                return ListTile(title: Text('Product ${it.productId}'), subtitle: Text('Qty: ${it.qty}'));
              },
            ),
    );
  }
}