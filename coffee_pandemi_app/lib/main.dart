import 'package:coffee_pandemi_app/Flutter_Api/ui/list_pelanggan.dart';
import 'package:coffee_pandemi_app/penjualan_coffee/list_penjualan.dart';
import 'package:flutter/material.dart';
//import halaman yang akan diload kemusian beri alias
import './home_page.dart';
import './list_coffee_page.dart';
import './list_cart.dart';

//top level root
void main() {
  runApp(new MaterialApp(
    title: "tab Bar",
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primarySwatch: Colors.brown),
    home: new MyApp(),
  ));
}

//menggunakan StatefulWidget
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

//panggil juga SingleTickerProviderStateMixin
class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  //deklarasikan variabel controller untuk mengatur tabbar
  int _currentIndex = 0;
  List<Map> _listNav = [
    {'icon': Icons.home, 'label': 'Home'},
    {'icon': Icons.list, 'label': 'List'},
    {'icon': Icons.shopping_cart, 'label': 'Cart'},
    {'icon': Icons.add_chart, 'label': 'Penjualan'},
    {'icon': Icons.add_box, 'label': 'Pelanggan'},
  ];
  List<Widget> _listPage = [
    HomePage(),
    ListCoffeePage(),
    ListCart(),
    Home(),
    ListPelanggan(),
  ];

  // TabController controller;
  // //tambah initState unutk inisialisasi dan mengaktifkan tab
  // @override
  // void initState() {
  //   controller = new TabController(length: 2, vsync: this);
  //   super.initState();
  // }

  // //tambah dispose unutk berpindah halaman
  // @override
  // void dispose() {
  //   controller.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    //gunakan widget Scaffold
    return Scaffold(
      body: _listPage[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color(0xFFDAB68C),
          currentIndex: _currentIndex,
          selectedItemColor: Colors.brown,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: false,
          onTap: (newValue) {
            setState(() {
              _currentIndex = newValue;
            });
          },
          items: List.generate(_listNav.length, (index) {
            return BottomNavigationBarItem(
              label: _listNav[index]['label'],
              icon: Icon(_listNav[index]['icon']),
            );
          })),
      //widget TabBarView
      // body: new TabBarView(
      //   //terdapat controller untuk mengatur halaman
      //   controller: controller,
      //   children: <Widget>[
      //     //pemanggil halaman dimulai dari alias.ClassName halaman yang diload
      //     new HomePage.HomePage(),
      //     new ListCoffee.ListCoffeePage(),
      //     // new Home.Home(),
      //   ],
      // ),
      //membuat bottom tab
      // bottomNavigationBar: new Material(
      //   color: Color(0xFFDAB68C),
      //   child: new TabBar(
      //     controller: controller,
      //     tabs: <Widget>[
      //       //menggunakan icon untuk mempercantik tab
      //       //icon berurutan sesuai penggilan halaman
      //       new Tab(icon: new Icon(Icons.home)),
      //       new Tab(icon: new Icon(Icons.list)),
      //       // new Tab(icon: new Icon(Icons.add_shopping_cart)),
      //     ],
      //   ),
      // ),
    );
  }
}
