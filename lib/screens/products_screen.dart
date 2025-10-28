import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';
import '../providers/favorites_provider.dart';
import '../widgets/product_tile.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});
  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final _searchCtl = TextEditingController();

  @override
  void initState() {
    super.initState();
    final p = Provider.of<ProductsProvider>(context, listen: false);
    p.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    final p = Provider.of<ProductsProvider>(context);
    final fav = Provider.of<FavoritesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          IconButton(icon: const Icon(Icons.favorite), onPressed: () => Navigator.pushNamed(context, '/favorites')),
          IconButton(icon: const Icon(Icons.shopping_cart), onPressed: () => Navigator.pushNamed(context, '/cart')),
          IconButton(icon: const Icon(Icons.person), onPressed: () => Navigator.pushNamed(context, '/profile')),
          IconButton(icon: const Icon(Icons.info_outline), onPressed: () => Navigator.pushNamed(context, '/info')),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              controller: _searchCtl,
              onChanged: (v) => p.search(v),
              decoration: const InputDecoration(
                hintText: 'Search products locally',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ),
      ),
      body: p.loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: p.filtered.length,
              itemBuilder: (_, i) {
                final prod = p.filtered[i];
                return ProductTile(
                  product: prod,
                  isFav: fav.isFav(prod.id),
                  onFavToggle: () => fav.toggleFavorite(prod.id),
                  onTap: () => Navigator.pushNamed(context, '/product', arguments: prod),
                );
              },
            ),
    );
  }
}