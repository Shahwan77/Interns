class Product {
  final int productId;
  final String productName;
  final double productPrice;
  bool isLiked;
  bool isInCart;

  Product({
    required this.productId,
    required this.productName,
    required this.productPrice,
    this.isLiked = false,
    this.isInCart = false,
  });
}
