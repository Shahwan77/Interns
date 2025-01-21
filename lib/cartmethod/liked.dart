import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'datas/product_data.dart';
import 'datas/products.dart';



class LikedPage extends StatefulWidget {
  final box = GetStorage();
  State<LikedPage> createState() => _LikedPageState();
}

class _LikedPageState extends State<LikedPage> {
  // final List<Product> products;
  void removeLike(Product product) {
    setState(() {
      product.isLiked = false;
    });
    widget.box.write('like_${product.productId}', product.isLiked);
  }

  @override
  Widget build(BuildContext context) {
    final likedProducts = products.where((product) => product.isLiked).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Liked Products'),
      ),
      body: ListView.builder(
        itemCount: likedProducts.length,
        itemBuilder: (context, index) {
          final product = likedProducts[index];
          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              title: Text(product.productName),
              subtitle: Text('\$${product.productPrice}'),
              trailing: GestureDetector(
                  onTap: () {
                    removeLike(product);
                  },
                  child: Icon(CupertinoIcons.delete)),
            ),
          );
        },
      ),
    );
  }
}
