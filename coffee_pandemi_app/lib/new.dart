import 'package:coffee_pandemi_app/coffee.dart';
import 'package:coffee_pandemi_app/database/cart/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:grouped_buttons/grouped_buttons.dart';

class Checkout extends StatefulWidget {
  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  var _formKey = GlobalKey<FormState>();
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
        title: Text('Checkout Page'),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Total+Ongkir',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text('Rp. ${totalString.replaceAll(',', '.')}',
                          style: TextStyle(fontSize: 25)),
                    ],
                  ),
                ),
                RaisedButton(
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
                      child: Text('BUY NOW',
                          style: TextStyle(fontSize: 20, color: Colors.white))),
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
                      // Image.asset(
                      //   coffee.image,
                      //   height: 100,
                      //   width: 100,
                      //   fit: BoxFit.cover,
                      // ),
                      SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            coffee.name,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 22),
                          ),
                          SizedBox(width: 4),
                          Text(
                            'Rp ${coffee.price}',
                            style:
                                TextStyle(color: Colors.orange, fontSize: 20),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Qty',
                            style: TextStyle(fontSize: 16),
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
                          ),
                          // SingleChildScrollView(
                          //   child: Padding(
                          //     padding: const EdgeInsets.all(16.0),
                          //     child: Form(
                          //       key: _formKey,
                          //       child: Column(
                          //         children: [
                          //           TextFormField(
                          //             validator: (value) {
                          //               if (value == '' || value == null) {
                          //                 return 'Jangan Boleh Kosong';
                          //               } else {
                          //                 return null;
                          //               }
                          //             },
                          //             decoration: InputDecoration(
                          //                 border: OutlineInputBorder(),
                          //                 focusedBorder: OutlineInputBorder(
                          //                     borderSide: BorderSide(
                          //                         color: Colors.green,
                          //                         width: 2)),
                          //                 enabledBorder: OutlineInputBorder(
                          //                     borderSide: BorderSide(
                          //                         color: Colors.green,
                          //                         width: 2)),
                          //                 disabledBorder: OutlineInputBorder(
                          //                     borderSide: BorderSide(
                          //                         color: Colors.green,
                          //                         width: 2)),
                          //                 hintText: '4',
                          //                 labelText: 'Input Angka',
                          //                 floatingLabelBehavior:
                          //                     FloatingLabelBehavior.always,
                          //                 // prefix: Icon(Icons.attach_money),
                          //                 prefixIcon: Icon(Icons.attach_money,
                          //                     color: Colors.grey),
                          //                 suffixIcon: Icon(Icons.search,
                          //                     color: Colors.green)),
                          //           ),
                          //           SizedBox(height: 8),
                          //           TextFormField(
                          //             validator: (value) {
                          //               if (value == '' || value == null) {
                          //                 return 'Jangan Boleh Kosong';
                          //               } else {
                          //                 return null;
                          //               }
                          //             },
                          //             decoration: InputDecoration(
                          //                 border: OutlineInputBorder(),
                          //                 focusedBorder: OutlineInputBorder(
                          //                     borderSide: BorderSide(
                          //                         color: Colors.green,
                          //                         width: 2)),
                          //                 enabledBorder: OutlineInputBorder(
                          //                     borderSide: BorderSide(
                          //                         color: Colors.green,
                          //                         width: 2)),
                          //                 disabledBorder: OutlineInputBorder(
                          //                     borderSide: BorderSide(
                          //                         color: Colors.green,
                          //                         width: 2)),
                          //                 hintText: '4',
                          //                 labelText: 'Input Angka',
                          //                 floatingLabelBehavior:
                          //                     FloatingLabelBehavior.always,
                          //                 // prefix: Icon(Icons.attach_money),
                          //                 prefixIcon: Icon(Icons.attach_money,
                          //                     color: Colors.grey),
                          //                 suffixIcon: Icon(Icons.search,
                          //                     color: Colors.green)),
                          //           ),
                          //         ],
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          // Text('Pembayaran'),
                          // SizedBox(height: 8),
                          // RadioButtonGroup(
                          //   labels: <String>[
                          //     "Dana",
                          //     "Ovo",
                          //   ],
                          //   onSelected: (String selected) => print(selected),
                          // ),
                          // Text('Pengiriman'),
                          // SizedBox(height: 8),
                          // RadioButtonGroup(
                          //   labels: <String>[
                          //     "JNE",
                          //     "JNT",
                          //   ],
                          //   onSelected: (String selected) => print(selected),
                          // ),
                        ],
                      ),
                      Spacer(),
                    ],
                  ),
                );
              },
            )
          : Center(child: Text('Database Kosong')),
    );
  }
}
