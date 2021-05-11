import 'package:coffee_pandemi_app/database/cart/db_helper.dart';
import 'package:coffee_pandemi_app/list_cart.dart';
import 'package:flutter/material.dart';
import 'package:coffee_pandemi_app/coffee.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class DetailMenu extends StatefulWidget {
  final Coffee coffee;
  DetailMenu({this.coffee});
  @override
  _DetailMenuState createState() => _DetailMenuState();
}

class _DetailMenuState extends State<DetailMenu> {
  //inisialisasi variabel star
  int jumlah = 1;
  @override
  Widget build(BuildContext context) {
    //membuat star secara dinamis sesuai dengan jumlah star yang dikirim dari list produk

    //widget Scaffold sebagai isi halaman
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFDAB68C),
        title: new Text(
          "${widget.coffee.name}",
          style: TextStyle(color: Colors.brown),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.brown,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ListCart(
                      // getCofee: coffee,
                      ),
                ),
              );
            },
          )
        ],
      ),
      // bottomNavigationBar: _buildBottom(),
      body: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                alignment: Alignment.topCenter,
                height: MediaQuery.of(context).size.height - 20.0,
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  '${widget.coffee.image}',
                  height: MediaQuery.of(context).size.height * 0.7,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                  top: MediaQuery.of(context).size.height / 2,
                  child: Container(
                      height: MediaQuery.of(context).size.height / 2 - 20.0,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(40.0),
                              topLeft: Radius.circular(40.0)),
                          color: Colors.white))),
              //conten
              Positioned(
                  top: MediaQuery.of(context).size.height / 2 + 25.0,
                  left: 15.0,
                  child: Container(
                    height: (MediaQuery.of(context).size.height / 2) - 150.0,
                    width: MediaQuery.of(context).size.width,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: 300,
                            child: Text(
                              "${widget.coffee.name}",
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          // Row(
                          //   children: childrenstar,
                          // ),

                          Text(
                            "DETAILS",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            "${widget.coffee.desc}",
                            style: TextStyle(
                              color: Colors.black38,
                            ),
                          ),
                          SizedBox(height: 16),
                          Text('Rating'),
                          RatingBar.builder(
                            initialRating: widget.coffee.star,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 25,
                            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
                          ),

                          SizedBox(height: 8),
                          Text('Qty'),
                          SizedBox(height: 4),
                          Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: Colors.black),
                                borderRadius: BorderRadius.circular(5)),
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    jumlah = jumlah - 1 <= 0 ? 1 : jumlah - 1;
                                    setState(() {});
                                  },
                                  child: Container(
                                    height: 30,
                                    width: 30,
                                    color: Colors.amber,
                                    alignment: Alignment.center,
                                    child: Text(
                                      '-',
                                      style: TextStyle(fontSize: 30),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text(jumlah.toString(),
                                    style: TextStyle(fontSize: 20)),
                                SizedBox(width: 8),
                                GestureDetector(
                                  onTap: () {
                                    jumlah = jumlah + 1 <= 0 ? 1 : jumlah + 1;
                                    setState(() {});
                                  },
                                  child: Container(
                                    height: 30,
                                    width: 30,
                                    color: Colors.amber,
                                    alignment: Alignment.center,
                                    child: Text(
                                      '+',
                                      style: TextStyle(fontSize: 30),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 16),
                          // Row(
                          //   children: <Widget>[
                          //     _buildImage("assets/images/coffee.jpg"),
                          //     _buildImage("assets/images/coffee2.jpg"),
                          //     _buildImage("assets/images/coffee3.jpg"),
                          //   ],
                          // )
                        ],
                      ),
                    ),
                  )),
              Positioned(
                bottom: 0,
                child: _buildBottom(),
              ),
              Positioned(
                  top: MediaQuery.of(context).size.height / 4,
                  left: 200.0,
                  child: Container(
                      height: 300.0,
                      width: 300.0,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/pinkcup.png'),
                              fit: BoxFit.cover)))),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildBottom() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 1,
            blurRadius: 10,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "PRICE",
                style: TextStyle(
                  color: Colors.black26,
                ),
              ),
              Text(
                "Rp. ${widget.coffee.price}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
            ],
          ),
          Material(
            color: Colors.brown,
            borderRadius: BorderRadius.all(
              Radius.circular(50),
            ),
            child: InkWell(
              borderRadius: BorderRadius.all(
                Radius.circular(50),
              ),
              onTap: () {
                Coffee newcoffee = Coffee(
                  id: widget.coffee.id,
                  name: widget.coffee.name,
                  desc: widget.coffee.desc,
                  price: widget.coffee.price,
                  star: widget.coffee.star,
                  image: widget.coffee.image,
                  jumlah: jumlah,
                );
                DbHelper.myDB.insertCoffee(newcoffee).then((value) {
                  if (value != null) {
                    print('Berhasil $value');
                  }
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 50,
                ),
                child: Text(
                  "ADD CART",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildColorOption(Color color) {
  //   return Container(
  //     width: 20,
  //     height: 20,
  //     margin: EdgeInsets.only(right: 8),
  //     decoration: BoxDecoration(
  //       color: color,
  //       borderRadius: BorderRadius.all(
  //         Radius.circular(50),
  //       ),
  //     ),
  //   );
  // }

  // Widget _buildImage(String image) {
  //   return Container(
  //     width: 20,
  //     height: 20,
  //     margin: EdgeInsets.only(right: 8),
  //     decoration: BoxDecoration(
  //       image: DecorationImage(
  //           image: AssetImage("${widget.coffee.image}"), fit: BoxFit.cover),
  //       borderRadius: BorderRadius.all(
  //         Radius.circular(50),
  //       ),
  //     ),
  //   );
  // }
}
