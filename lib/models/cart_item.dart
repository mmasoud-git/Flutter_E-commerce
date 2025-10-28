class CartItem {
  final String id;
  final String userId;
  final String productId;
  final int qty;

  CartItem({
    required this.id,
    required this.userId,
    required this.productId,
    required this.qty,
  });

  factory CartItem.fromJson(Map<String, dynamic> j) => CartItem(
    id: j['id'].toString(),
    userId: j['userId'].toString(),
    productId: j['productId'].toString(),
    qty: (j['qty'] ?? 1) as int,
  );
}