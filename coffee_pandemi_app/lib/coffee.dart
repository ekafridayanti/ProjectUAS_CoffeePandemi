import 'package:coffee_pandemi_app/database/cart/db_helper.dart';

class Coffee {
  final int id;
  final String name;
  final String desc;
  final int price;
  final String image;
  final double star;
  final int jumlah;
  int idUser;
  int idWishlist;

  Coffee(
      {this.id,
      this.name,
      this.desc,
      this.price,
      this.image,
      this.star,
      this.jumlah,
      this.idUser,
      this.idWishlist});

  factory Coffee.fromMap(Map<String, dynamic> map) {
    return Coffee(
        id: int.parse(map[DbHelper.COLUMN_ID].toString()),
        name: map[DbHelper.COLUMN_NAME],
        desc: map[DbHelper.COLUMN_DESC],
        price: int.parse(map[DbHelper.COLUMN_PRICE].toString()),
        image: map[DbHelper.COLUMN_IMAGE],
        star: double.parse(map[DbHelper.COLUMN_STAR].toString()),
        jumlah: int.parse(map[DbHelper.COLUMN_JUMLAH].toString()));
  }

  factory Coffee.fromWishlist(Map<String, dynamic> map) {
    return Coffee(
        name: map['name'],
        desc: map['description'],
        price: int.parse(map['price'].toString()),
        image: map['image'],
        star: double.parse(map['star'].toString()),
        idUser: int.parse(map['id_user'].toString()),
        idWishlist: int.parse(map['id_wishlist'].toString()),
        jumlah: int.parse(map['jumlah'].toString()));
  }

  Map<String, dynamic> toMap() {
    return {
      DbHelper.COLUMN_NAME: this.name,
      DbHelper.COLUMN_DESC: this.desc,
      DbHelper.COLUMN_PRICE: this.price,
      DbHelper.COLUMN_IMAGE: this.image,
      DbHelper.COLUMN_STAR: this.star,
      DbHelper.COLUMN_JUMLAH: this.jumlah,
    };
  }

  Map<String, dynamic> toWishlist() {
    return {
      'name': this.name,
      'description': this.desc,
      'price': this.price.toString(),
      'image': this.image,
      'star': this.star.toString(),
      'jumlah': this.jumlah.toString(),
      'id_user': this.idUser.toString(),
    };
  }
}

final ListCoffee = [
  Coffee(
    name: "Americano",
    desc:
        "Caffè Americano atau Amerikano adalah minuman kopi yang dibuat dengan mencampurkan satu seloki espresso dengan air panas. Air panas yang digunakan dalam minuman ini adalah sebanyak 6 hingga 8 ons",
    price: 25000,
    image: "assets/images/americano.jpg",
    star: 4,
    jumlah: 1,
  ),
  Coffee(
    name: "Espresso",
    desc: "Espresso adalah inti semesta kopi. Well, Must Try.",
    price: 15000,
    image: "assets/images/espreso.jpg",
    star: 4,
    jumlah: 1,
  ),
  Coffee(
    name: "Macchiato 19",
    desc: "Macchiato memberi kelembutan macchiato yang menyegarkan.",
    price: 19000,
    image: "assets/images/machiato.jpg",
    star: 5,
    jumlah: 1,
  ),
  Coffee(
    name: "Cappucino",
    desc:
        "Cappucino adalah minuman khas Italia yang dibuat dari espresso dan susu, dengan selera pecinta coffee.",
    price: 19000,
    image: "assets/images/cappuccino.jpg",
    star: 5,
    jumlah: 1,
  ),
  Coffee(
    name: "Caramel Latte",
    desc:
        "Kombinasi pahit espresso short serta creamy susu dan sirup caramel .",
    price: 20000,
    image: "assets/images/header1.jpeg",
    star: 3,
    jumlah: 1,
  ),
  Coffee(
    name: "Vanila Late",
    desc: "Kombinasi pahit espresso short serta creamy susu dan sirup Vanila .",
    price: 20000,
    image: "assets/images/late1.jpg",
    star: 4,
    jumlah: 1,
  ),
  Coffee(
    name: "Choco Frappe",
    desc: "Kombinasi creamy susu dan chocolate.",
    price: 22000,
    image: "assets/images/frape1.jpg",
    star: 5,
    jumlah: 1,
  ),
  Coffee(
    name: "Machiato Caramel",
    desc: "Kombinasi creamy susu,sirup caramel dan machioto yang menyegarkan.",
    price: 25000,
    image: "assets/images/maciato.jpg",
    star: 4,
    jumlah: 1,
  )
];
