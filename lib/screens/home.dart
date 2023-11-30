import 'package:ecommerce_app/screens/favorite_products.dart';
import 'package:ecommerce_app/screens/login.dart';
import 'package:ecommerce_app/screens/search_products.dart';
import 'package:ecommerce_app/screens/shopping_cart.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedTab = 0;

  final List<Widget>_tabs = const [SearchProducts(),FavoriteProducts(),ShoppingCart()];

  _changeTab(int index){
    setState(() {
      _selectedTab = index;
    });
  }

  navigateTo(){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
      return const Login();
    }));
  }

  logout() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLogged');
    navigateTo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ecommerce App'),
        actions: [
          IconButton(
            onPressed: (){
              logout();
            },
            icon: const Icon(Icons.logout),
          )
        ],
      
      ),
      body: _tabs[_selectedTab],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTab,
        onTap: (int index) {
          _changeTab(index);
        },
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorite',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Shop',
          ),
        ],
      ),
    );
  }
}