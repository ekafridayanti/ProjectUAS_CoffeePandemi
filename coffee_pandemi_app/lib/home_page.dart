import 'package:coffee_pandemi_app/about_app.dart';
import 'package:coffee_pandemi_app/detail_page.dart';
import 'package:coffee_pandemi_app/list_coffee_page.dart';
import 'package:coffee_pandemi_app/wishlist/list_wishlist.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // Padding(
        //   padding: const EdgeInsets.only(right: 45.0, left: 20.0),
        //   child: Text(
        //     "Welcome to Pandemi Coffee",
        //     style: TextStyle(
        //         fontSize: 25.0,
        //         fontWeight: FontWeight.bold,
        //         color: Color(0xFF473D3A)),
        //   ),
        // ),
        SizedBox(height: 8.0),
        Padding(
          padding: const EdgeInsets.only(right: 45.0, left: 20.0),
          child: Container(
            child: Text(
              'Let\'s select the best taste for your next coffee break!',
              style: TextStyle(
                fontFamily: 'nunito',
                fontSize: 17.0,
                fontWeight: FontWeight.w300,
                color: Color(0xFFB0AAA7),
              ),
            ),
          ),
        ),
        SizedBox(height: 8.0),
        Container(
          height: 250,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: AssetImage('assets/images/header1.jpeg'),
              fit: BoxFit.cover,
            ),
          ),
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(left: 16, right: 16),
          width: MediaQuery.of(context).size.width,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Caramel Latte',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                      Row(
                        children: <Widget>[
                          Icon(Icons.star, color: Colors.orange),
                          Icon(Icons.star, color: Colors.orange),
                          Icon(Icons.star, color: Colors.orange),
                          Spacer(),
                          Text(
                            'Rp. 20.000',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25.0,
                                color: Colors.orangeAccent),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Categories',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  Text('All')
                ],
              ),
              SizedBox(height: 8.0),
              Container(
                height: 150,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    makeCategory(
                        image: 'assets/images/late.jpg', title: 'Late'),
                    makeCategory(
                        image: 'assets/images/frape.jpg', title: 'Frappe'),
                    makeCategory(
                        image: 'assets/images/machiato.jpg', title: 'Machiato'),
                    makeCategory(
                        image: 'assets/images/espresso.jpg', title: 'Espreso'),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Best Selling',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  new GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ListCoffeePage()));
                    },
                    child: Text('All'),
                  )
                ],
              ),
              SizedBox(height: 8.0),
              Container(
                height: 150,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    makeBestSell(
                        image: 'assets/images/late1.jpg',
                        title: 'Vanila Late',
                        price: 'Rp.20.000'),
                    makeBestSell(
                        image: 'assets/images/frape1.jpg',
                        title: 'Choco Frappe',
                        price: 'Rp.22.000'),
                    makeBestSell(
                        image: 'assets/images/maciato.jpg',
                        title: 'Machiato Caramel',
                        price: 'Rp.25.000'),
                    makeBestSell(
                        image: 'assets/images/espreso.jpg',
                        title: 'Espreso',
                        price: 'Rp.15.000'),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget makeCategory({image, title}) {
    return AspectRatio(
      aspectRatio: 2 / 2.2,
      child: Container(
        margin: EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: AssetImage(image),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              colors: [
                Colors.black.withOpacity(.8),
                Colors.black.withOpacity(.0),
              ],
            ),
          ),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              title,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  Widget makeBestSell({image, title, price}) {
    return AspectRatio(
      aspectRatio: 3 / 2.2,
      child: Container(
        margin: EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: AssetImage(image),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              colors: [
                Colors.black.withOpacity(.8),
                Colors.black.withOpacity(.0),
              ],
            ),
          ),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      price,
                      style: TextStyle(
                          color: Colors.orange,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                        icon: Icon(Icons.shopping_cart_outlined,
                            color: Colors.white),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ListCoffeePage()));
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
