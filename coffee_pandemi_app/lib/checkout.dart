import 'package:coffee_pandemi_app/checkout_berhasil_page.dart';
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
  int pengiriman = 0;
  String pembayaran = '';
  var formScaffold = GlobalKey<ScaffoldState>();
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
      total = total + pengiriman;
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
      key: formScaffold,
      appBar: AppBar(
        backgroundColor: Color(0xFFDAB68C),
        title: Text('Checkout Page', style: TextStyle(color: Colors.brown)),
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
                        'Total Pembayaran',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text('Rp ${totalString.replaceAll(',', '.')}',
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.orange,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                RaisedButton(
                  color: Colors.brown,
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      if (pengiriman != 0 && pembayaran != '') {
                        _listCoffee.forEach((coffee) {
                          DbHelper.myDB.deleteWhereId(coffee.id);
                        });
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CheckoutBerhasil(),
                          ),
                        );
                      } else {
                        formScaffold.currentState.showSnackBar(SnackBar(
                            backgroundColor: Colors.brown,
                            duration: Duration(milliseconds: 2500),
                            behavior: SnackBarBehavior.floating,
                            content: Text(
                                'Pengiriman dan Pembayaran Wajib Terisi!')));
                      }
                    } else {}
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      'BUY NOW',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          )),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              child: _listCoffee.length > 0
                  ? ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: NeverScrollableScrollPhysics(),
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
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22),
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    'Rp ${coffee.price}',
                                    style: TextStyle(
                                        color: Colors.orange, fontSize: 20),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Qty : ${coffee.jumlah}',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Sub Total: Rp. ${coffee.price * coffee.jumlah}',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  SizedBox(height: 8),
                                ],
                              ),
                              Spacer(),
                            ],
                          ),
                        );
                      },
                    )
                  : Center(child: Text('Database Kosong')),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Lengkapi Data Diri!',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      validator: (value) {
                        if (value == '' || value == null) {
                          return 'Jangan Boleh Kosong';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.brown, width: 2)),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 2)),
                        disabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 2)),
                        hintText: 'Nama Lengkap',
                        // labelText: 'Input Nama',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        // prefix: Icon(Icons.attach_money),
                        // prefixIcon:
                        //     Icon(Icons.attach_money, color: Colors.grey),
                        // suffixIcon: Icon(Icons.search, color: Colors.green),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      validator: (value) {
                        if (value == '' || value == null) {
                          return 'Jangan Boleh Kosong';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.brown, width: 2)),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 2)),
                        disabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 2)),
                        hintText: 'Alamat ',
                        // labelText: 'Input Angka',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        // prefix: Icon(Icons.attach_money),
                        // prefixIcon:
                        //     Icon(Icons.attach_money, color: Colors.grey),
                        // suffixIcon: Icon(Icons.search, color: Colors.green),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      validator: (value) {
                        if (value == '' || value == null) {
                          return 'Jangan Boleh Kosong';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.brown, width: 2)),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 2)),
                        disabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 2)),
                        hintText: 'No.Tlp ',
                        // labelText: 'Input Angka',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        // prefix: Icon(Icons.attach_money),
                        // prefixIcon:
                        //     Icon(Icons.attach_money, color: Colors.grey),
                        // suffixIcon: Icon(Icons.search, color: Colors.green),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Pembayaran',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            RadioButtonGroup(
              labels: <String>[
                "Dana",
                "Ovo",
              ],
              onSelected: (String selected) {
                setState(() {
                  pembayaran = selected;
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Pengiriman',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 8),
            RadioButtonGroup(
              labels: <String>[
                "Gojek = 6000",
                "Grab = 5000",
              ],
              onSelected: (String selected) {
                setState(() {
                  if ('Grab = 5000' == selected) {
                    pengiriman = 5000;
                  } else {
                    pengiriman = 6000;
                  }
                });
                getCoffee();
              },
            ),
          ],
        ),
      ),
    );
  }
}
