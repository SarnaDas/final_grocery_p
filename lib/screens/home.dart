import 'package:flutter/material.dart';
import 'package:grocery_p/screens/orders.dart';
import 'package:grocery_p/screens/profile.dart';
import 'package:grocery_p/screens/search.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(102, 187, 106, 1),
        title: Center(
            child: Text(
          'Chotto Bazar',
          style: TextStyle(color: Colors.white),
        )),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SearchProduct()));
              },
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ))
        ],
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.green,
          child: ListView(
            children: [
              DrawerHeader(
                  child: Center(
                child: Text(
                  'Chotto Bazar',
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
              )),
              ListTile(
                leading: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                title: Text(
                  'Profile',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => UserProfile()));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.shopping_bag,
                  color: Colors.white,
                ),
                title: Text(
                  'Orders',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => Orders()));
                },
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: Container(
          child: Text('Done!'),
        ),
      ),
    );
  }
}
