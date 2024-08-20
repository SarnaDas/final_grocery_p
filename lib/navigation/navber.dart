import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:grocery_p/screens/add_product.dart';
import 'package:grocery_p/screens/cart.dart';
import 'package:grocery_p/screens/home.dart';
import 'package:grocery_p/screens/my_product.dart';
import 'package:grocery_p/screens/notifications.dart';

class Navigation_bar extends StatefulWidget {
  const Navigation_bar({super.key});

  @override
  State<Navigation_bar> createState() => _Navigation_barState();
}

class _Navigation_barState extends State<Navigation_bar> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    Home(),
    CartScreen(),
    AddProduct(),
    MyProducts(),
    Notifications(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: Container(
        color: Colors.green.shade400,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
          child: GNav(
            gap: 8,
            backgroundColor: Colors.green.shade400,
            color: Colors.white,
            activeColor: Colors.green[800],
            tabBackgroundColor: Colors.green.shade300,
            padding: EdgeInsets.all(16),
            onTabChange: (index) {
              _onItemTapped(index);
            },
            tabs: const [
              GButton(
                icon: Icons.home,
                text: 'Home',
              ),
              GButton(
                icon: Icons.shopping_cart,
                text: 'Cart',
              ),
              GButton(
                //icon: Icons.shopping_bag,
                icon: Icons.add,
                text: 'Add Product',
              ),
              GButton(
                icon: Icons.shopping_basket,
                text: 'My Products',
              ),
              GButton(
                icon: Icons.notification_important,
                text: 'Notifications',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
