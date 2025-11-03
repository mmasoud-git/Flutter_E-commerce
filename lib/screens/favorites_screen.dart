import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/favorites_provider.dart';
import '../providers/products_provider.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final fav = Provider.of<FavoritesProvider>(context);
    final prod = Provider.of<ProductsProvider>(context);
    final favIds = fav.favoritesList;
    final favProducts = prod.all.where((p) => favIds.contains(p.id)).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: favProducts.isEmpty
          ? const Center(child: Text('No favorites yet'))
          : ListView.builder(
              itemCount: favProducts.length,
              itemBuilder: (_, i) {
                final p = favProducts[i];
                return ListTile(
                  title: Text(p.title),
                  subtitle: Text('\$${p.price.toStringAsFixed(2)}'),
                  trailing: IconButton(icon: const Icon(Icons.delete), onPressed: () => fav.toggleFavorite(p.id)),
                );
              },
            ),
    );
  }
}