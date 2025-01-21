import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:int_tst/cartmethod/cart.dart';
import 'package:int_tst/cartmethod/home_page.dart';
import 'package:int_tst/cartmethod/liked.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  List<Widget> pages = [HomePage(), LikedPage(), CartPage()];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      // IndexedStack(
      //   children: pages,
      //   index: currentIndex,
      // ),
      bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {
            setState(() {
              currentIndex = value;
            });
          },
          currentIndex: currentIndex,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Fav'),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.cart), label: 'Cart')
          ]),
    );
  }
}
