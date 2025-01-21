import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';


import 'datas/product_data.dart';
import 'datas/products.dart';

class CartPage extends StatefulWidget {
  final box = GetStorage();
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  void removeCart(Product product) {
    setState(() {
      product.isInCart = false;
    });
    widget.box.write('cart_${product.productId}', product.isInCart);
  }

  @override
  Widget build(BuildContext context) {
    final cartProducts = products.where((product) => product.isInCart).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: ListView.builder(
        itemCount: cartProducts.length,
        itemBuilder: (context, index) {
          final product = cartProducts[index];
          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              title: Text(product.productName),
              subtitle: Text('\$${product.productPrice}'),
              trailing: GestureDetector(
                  onTap: () {
                    removeCart(product);
                  },
                  child: Icon(CupertinoIcons.delete)),
            ),
          );
        },
      ),
    );
  }
}
