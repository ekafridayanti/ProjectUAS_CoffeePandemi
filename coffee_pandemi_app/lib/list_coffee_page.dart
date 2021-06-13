import 'package:coffee_pandemi_app/detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import './coffee.dart';

class ListCoffeePage extends StatefulWidget {
  final Coffee coffee;
  ListCoffeePage({this.coffee});
  @override
  _ListCoffeePageState createState() => _ListCoffeePageState();
}

class _ListCoffeePageState extends State<ListCoffeePage> {
  int jumlah = 1;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: ListCoffee.length,
      itemBuilder: (context, index) {
        Coffee coffeeModel = ListCoffee[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailMenu(
                  coffee: coffeeModel,
                ),
              ),
            );
          },
          child: Container(
            margin: EdgeInsets.fromLTRB(16, index == 0 ? 16 : 8, 16,
                index == ListCoffee.length - 1 ? 16 : 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black38,
                  offset: Offset(0, 0),
                  blurRadius: 6,
                ),
              ],
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20
                      // topLeft: Radius.circular(20),
                      // bottomLeft: Radius.circular(20),
                      // bottomRight: Radius.circular(20),
                      // topRight: Radius.circular(20),
                      ),
                  child: Hero(
                    tag: coffeeModel.image,
                    child: Image.asset(
                      coffeeModel.image,
                      fit: BoxFit.cover,
                      height: 85,
                      width: 85,
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(coffeeModel.name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            )),
                      ),
                      Text(
                        coffeeModel.desc,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                      ),
                      Text('Rp. ${coffeeModel.price}',
                          style: TextStyle(color: Colors.orange, fontSize: 18)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // InkWell(
                          //   onTap: () {
                          //     Coffee newcoffee = Coffee(
                          //       id: widget.coffee.id,
                          //       name: widget.coffee.name,
                          //       desc: widget.coffee.desc,
                          //       price: widget.coffee.price,
                          //       star: widget.coffee.star,
                          //       image: widget.coffee.image,
                          //       jumlah: jumlah,
                          //     );
                          //     DbHelper.myDB
                          //         .insertCoffee(newcoffee)
                          //         .then((value) {
                          //       if (value != null) {
                          //         print('Berhasil $value');
                          //       }
                          //     });
                          //   },
                          //   child: Icon(
                          //     Icons.shopping_cart_sharp,
                          //     color: Colors.brown,
                          //   ),
                          // ),
                          RatingBar.builder(
                            initialRating: coffeeModel.star,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 15,
                            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Icon(Icons.navigate_next),
              ],
            ),
          ),
        );
      },
    );
  }
}
