import 'package:coffee_pandemi_app/home_page.dart';
import 'package:coffee_pandemi_app/main.dart';
import 'package:flutter/material.dart';

class CheckoutBerhasil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/success.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(10),
        child: Container(
          height: 100,
          width: 40,
          decoration: BoxDecoration(color: Colors.grey[200]),
          child: Column(
            children: [
              Text(
                'Checkout Berhasil',
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.brown,
                    fontWeight: FontWeight.bold),
              ),
              RaisedButton(
                color: Colors.brown,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text('Back Home',
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyApp(),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
