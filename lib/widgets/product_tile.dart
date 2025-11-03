import 'package:flutter/material.dart';
import '../models/product.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductTile extends StatelessWidget {
  final Product product;
  final bool isFav;
  final VoidCallback onFavToggle;
  final VoidCallback onTap;

  const ProductTile({
    super.key,
    required this.product,
    required this.isFav,
    required this.onFavToggle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: product.image.isNotEmpty
          ? SizedBox(
              width: 56,
              child: CachedNetworkImage(imageUrl: product.image, fit: BoxFit.cover),
            )
          : null,
      title: Text(product.title),
      subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
      trailing: IconButton(icon: Icon(isFav ? Icons.favorite : Icons.favorite_border), onPressed: onFavToggle),
      onTap: onTap,
    );
  }
}