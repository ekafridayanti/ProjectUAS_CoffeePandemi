import 'package:coffee_pandemi_app/checkout.dart';
import 'package:coffee_pandemi_app/coffee.dart';
import 'package:coffee_pandemi_app/database/cart/db_helper.dart';
import 'package:coffee_pandemi_app/detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';

class ListCart extends StatefulWidget {
  @override
  _ListCartState createState() => _ListCartState();
}

class _ListCartState extends State<ListCart> {
  List<Coffee> _listCoffee = [];
  String totalString = '';
  int total = 0;
  void getCoffee() {
    total = 0;
    DbHelper.myDB.getAllCoffee().then((value) {
      _listCoffee = value;
      _listCoffee.forEach((element) {
        total = total + (element.price * element.jumlah);
      });
      FlutterMoneyFormatter fmf =
          FlutterMoneyFormatter(amount: double.parse(total.toString()));
      totalString = fmf.output.withoutFractionDigits;
      setState(() {});
    });

    // var newlist = await DbHelper.myDB.getAllAnimal();
    // _listCoffee = newlist;
    // setState(() {
    // });
  }

  @override
  void initState() {
    getCoffee();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFDAB68C),
        title: Center(
          child: Text(
            'LIST CART COFFEE',
            style: TextStyle(
              color: Colors.brown,
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
          padding: EdgeInsets.all(8),
          child: Container(
            height: 100,
            width: 40,
            decoration: BoxDecoration(color: Colors.grey[200]),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Total',
                          style: TextStyle(fontSize: 18),
                        ),
                        Text('Rp. ${totalString.replaceAll(',', '.')}',
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.orange,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    color: Colors.brown,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Checkout(),
                        ),
                      );
                    },
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text('CHECK OUT',
                            style:
                                TextStyle(fontSize: 20, color: Colors.white))),
                  ),
                )
              ],
            ),
          )),
      body: _listCoffee.length > 0
          ? ListView.separated(
              separatorBuilder: (context, index) {
                return Divider(color: Colors.brown, height: 4);
              },
              itemCount: _listCoffee.length,
              itemBuilder: (context, index) {
                Coffee coffee = _listCoffee[index];
                return Container(
                  padding: EdgeInsets.all(5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        coffee.image,
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            coffee.name,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          SizedBox(width: 4),
                          Text(
                            'Rp. ${coffee.price}',
                            style:
                                TextStyle(color: Colors.orange, fontSize: 20),
                          ),
                          SizedBox(height: 8),
                          Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: Colors.black),
                                borderRadius: BorderRadius.circular(5)),
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    int newjumlah = coffee.jumlah - 1 <= 0
                                        ? 1
                                        : coffee.jumlah - 1;
                                    Coffee newcoffee = Coffee(
                                      id: coffee.id,
                                      name: coffee.name,
                                      desc: coffee.desc,
                                      price: coffee.price,
                                      star: coffee.star,
                                      image: coffee.image,
                                      jumlah: newjumlah,
                                    );
                                    DbHelper.myDB
                                        .updateWhereId(newcoffee)
                                        .then((value) {
                                      print('value: $value');
                                    });
                                    getCoffee();
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
                                Text(coffee.jumlah.toString(),
                                    style: TextStyle(fontSize: 20)),
                                SizedBox(width: 8),
                                GestureDetector(
                                  onTap: () {
                                    int newjumlah = coffee.jumlah + 1 >= 100
                                        ? 100
                                        : coffee.jumlah + 1;
                                    Coffee newcoffee = Coffee(
                                      id: coffee.id,
                                      name: coffee.name,
                                      desc: coffee.desc,
                                      price: coffee.price,
                                      star: coffee.star,
                                      image: coffee.image,
                                      jumlah: newjumlah,
                                    );
                                    DbHelper.myDB
                                        .updateWhereId(newcoffee)
                                        .then((value) {
                                      print('Value: $value');
                                    });
                                    getCoffee();
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
                          )
                        ],
                      ),
                      Spacer(),
                      SizedBox(
                        height: 100,
                        child: Column(
                          children: [
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                DbHelper.myDB.deleteWhereId(coffee.id);
                                getCoffee();
                                setState(() {});
                              },
                              child: Container(
                                height: 50,
                                width: 30,
                                alignment: Alignment.center,
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.brown,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
                // return ListTile(
                //   onTap: () => Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => DetailMenu(),
                //     ),
                //   ),
                //   title: Text('Nama: ${coffee.name}'),
                //   subtitle: Row(
                //     children: [
                //       FlatButton(
                //         onPressed: () {
                //           // Navigator.push(
                //           //   context,
                //           //   MaterialPageRoute(
                //           //     builder: (context) => UpdateCoffee(
                //           //       getAnimal: coffee,
                //           //     ),
                //           //   ),
                //           // ).then((value) {
                //           //   getCoffee();
                //           // });
                //         },
                //         child: Text('Edit'),
                //         color: Colors.amber,
                //       ),
                //       FlatButton(
                //         onPressed: () {
                //           DbHelper.myDB.deleteWhereId(coffee.id);
                //           getCoffee();
                //         },
                //         child: Text('delete'),
                //         color: Colors.orange,
                //       ),
                //     ],
                //   ),
                // );
              },
            )
          : Center(child: Text('Database Kosong')),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => AddCoffee(),
      //     ),
      //   ).then((value) {
      //     getCoffee();
      //   }),
      //   child: Icon(Icons.add),
      // ),
    );
  }
}
