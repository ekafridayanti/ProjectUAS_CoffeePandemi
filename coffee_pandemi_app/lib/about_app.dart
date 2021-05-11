import 'package:flutter/material.dart';

class AboutApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFDAB68C),
        title: Text("About This App"),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/pandemi.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              "PANDEMI COFFEE",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Container(
              padding: EdgeInsets.all(10),
              color: Colors.transparent,
              margin: EdgeInsets.symmetric(vertical: 50, horizontal: 10),
              child: Column(
                children: <Widget>[
                  Text(
                    "Life is like coffee: you can add as much sugar as you like but if you want it to be sweet, you’ve got to stir it. Unless you make a move, nothing happens. Stay Distance with Pandemi Coffee and get your better COFFEE with online order and amazing offer.",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                    ),
                    softWrap: true,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
