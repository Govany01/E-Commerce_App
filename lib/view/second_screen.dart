import 'package:final_project/view/Nav_Screens/Home.dart';
import 'package:final_project/view/Nav_Screens/cart.dart';
import 'package:final_project/view/Nav_Screens/profile.dart';
import 'package:flutter/material.dart';

class second extends StatefulWidget {
  const second({super.key});

  @override
  State<second> createState() => _secondState();
}

class _secondState extends State<second> {
  int Selected = 0;
  List<Widget> screens = [products(), Cart(), profile()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.purple,
          centerTitle: true,
          title: const Text(
            "City Shop",
            style: TextStyle(fontSize: 30, color: Colors.white),
          ),),
          
      body: screens[Selected],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: Selected,
          onTap: onTapped,
          items: const [
            BottomNavigationBarItem(label: "Market", icon: Icon(Icons.shopify)),
            BottomNavigationBarItem(label: "Cart", icon: Icon(Icons.shopping_cart_outlined)),
            BottomNavigationBarItem(label: "profile", icon: Icon(Icons.person))
          ]),
    );
  }

  onTapped(int index) {
    Selected = index;
    setState(() {});
  }
}
