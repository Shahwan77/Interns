import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:int_tst/cartmethod/cart.dart';
import 'package:int_tst/cartmethod/liked.dart';
import 'datas/product_data.dart';
import 'datas/products.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _storage = GetStorage();
  // Load the preferences for likes and cart from GetStorage

  _loadPreferences() {
    for (var product in products) {
      product.isLiked = _storage.read('like_${product.productId}') ?? false;
      product.isInCart = _storage.read('cart_${product.productId}') ?? false;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadPreferences();
  }

  // Toggle like and store it in GetStorage
  void _toggleLike(Product product) {
    setState(() {
      product.isLiked = !product.isLiked;
    });
    _storage.write('like_${product.productId}', product.isLiked);
  }

  // Toggle cart status and store it in GetStorage
  void _toggleCart(Product product) {
    setState(() {
      product.isInCart = !product.isInCart;
    });
    _storage.write('cart_${product.productId}', product.isInCart);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () async {
              await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LikedPage(),
                  ));
              setState(() {});
            },
            child: Icon(Icons.favorite)),
        actions: [
          GestureDetector(
              onTap: () async {
                await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartPage(),
                    ));
                setState(() {});
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(CupertinoIcons.cart),
              ))
        ],
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              title: Text(product.productName),
              subtitle: Text('\$${product.productPrice}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(
                      product.isLiked ? Icons.favorite : Icons.favorite_border,
                      color: product.isLiked ? Colors.red : null,
                    ),
                    onPressed: () => _toggleLike(product),
                  ),
                  IconButton(
                    icon: Icon(
                      product.isInCart
                          ? Icons.shopping_cart
                          : Icons.add_shopping_cart,
                      color: product.isInCart ? Colors.green : null,
                    ),
                    onPressed: () => _toggleCart(product),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
