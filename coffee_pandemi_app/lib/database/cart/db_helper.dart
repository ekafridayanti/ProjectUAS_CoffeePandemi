import 'package:coffee_pandemi_app/coffee.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static const DATABASE_NAME = 'coffee.db';
  static const DATABASE_VERSION = 1;
  static const TABLE_NAME = 'tb_name';
  static const COLUMN_ID = 'id';
  static const COLUMN_NAME = 'name';
  static const COLUMN_DESC = 'description';
  static const COLUMN_PRICE = 'price';
  static const COLUMN_IMAGE = 'image';
  static const COLUMN_STAR = 'star';
  static const COLUMN_JUMLAH = 'jumlah';

  DbHelper._();
  static final DbHelper myDB = DbHelper._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await createDatabase();
    return _database;
  }

  Future<Database> createDatabase() async {
    String databasesPath = await getDatabasesPath();
    return await openDatabase(
      join(
        databasesPath,
        DATABASE_NAME,
      ),
      version: DATABASE_VERSION,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE $TABLE_NAME (
          $COLUMN_ID INTEGER PRIMARY KEY AUTOINCREMENT,
          $COLUMN_NAME TEXT,
          $COLUMN_DESC TEXT,
          $COLUMN_PRICE INTEGER,
          $COLUMN_STAR DOUBLE,
          $COLUMN_JUMLAH INTEGER,
          $COLUMN_IMAGE TEXT
        )
        ''');
        // await db.execute('''
        //           CREATE TABLE penjualan (
        //             id INTEGER PRIMARY KEY AUTOINCREMENT,
        //             name TEXT,
        //             desc TEXT,
        //             jumlah TEXT,
        //             tanggal TEXT
        //           )
        //         ''');
      },
    );
  }

  Future<List<Coffee>> getAllCoffee() async {
    final db = await database;
    var coffees = await db.query(TABLE_NAME, columns: [
      COLUMN_ID,
      COLUMN_NAME,
      COLUMN_DESC,
      COLUMN_PRICE,
      COLUMN_IMAGE,
      COLUMN_STAR,
      COLUMN_JUMLAH,
    ]);
    List<Coffee> listCoffee = List<Coffee>();
    coffees.forEach(
      (element) {
        listCoffee.add(Coffee.fromMap(element));
      },
    );
    return listCoffee;
  }

  Future<int> insertCoffee(Coffee coffee) async {
    final db = await database;
    var coffees = await db.query(
      TABLE_NAME,
      columns: [
        COLUMN_ID,
        COLUMN_NAME,
        COLUMN_DESC,
        COLUMN_PRICE,
        COLUMN_IMAGE,
        COLUMN_STAR,
        COLUMN_JUMLAH,
      ],
      where: '$COLUMN_NAME=?',
      whereArgs: [coffee.name],
    );
    if (coffees.length > 0) {
      // print('jumlah=${coffees[0][COLUMN_JUMLAH] + coffee.jumlah}');
      Coffee newcoffee = Coffee(
        id: coffees[0][COLUMN_ID],
        name: coffee.name,
        desc: coffee.desc,
        price: coffee.price,
        star: coffee.star,
        image: coffee.image,
        jumlah: coffees[0][COLUMN_JUMLAH] + coffee.jumlah,
      );
      return await db.update(TABLE_NAME, newcoffee.toMap(),
          where: '$COLUMN_ID=?', whereArgs: [newcoffee.id]);
    } else {
      return await db.insert(TABLE_NAME, coffee.toMap());
    }
  }

  Future<int> deleteWhereId(int id) async {
    final db = await database;
    return await db.delete(
      TABLE_NAME,
      where: '$COLUMN_ID=?',
      whereArgs: [id],
    );
  }

  Future<int> updateWhereId(Coffee coffee) async {
    final db = await database;
    return await db.update(
      TABLE_NAME,
      coffee.toMap(),
      where: '$COLUMN_ID=?',
      whereArgs: [coffee.id],
    );
  }

  // Future<List<Map<String, dynamic>>> select() async {
  //   Database db = await this.database;
  //   var mapList = await db.query('penjualan', orderBy: 'tanggal');
  //   return mapList;
  // }

  // Future<int> insert(Penjualan object) async {
  //   Database db = await this.database;
  //   int count = await db.insert('penjualan', object.toMap());
  //   return count;
  // }

  // Future<int> update(Penjualan object) async {
  //   Database db = await this.database;
  //   int count = await db.update('penjualan', object.toMap(),
  //       where: 'id=?', whereArgs: [object.id]);
  //   return count;
  // }

  // Future<int> delete(int id) async {
  //   Database db = await this.database;
  //   int count = await db.delete('penjualan', where: 'id=?', whereArgs: [id]);
  //   return count;
  // }

  // Future<List<Penjualan>> getPenjualanList() async {
  //   var penjualanMapList = await select();
  //   int count = penjualanMapList.length;
  //   print("Ini Jumlah $count");
  //   List<Penjualan> penjualanList = List<Penjualan>();
  //   for (int i = 0; i < count; i++) {
  //     penjualanList.add(Penjualan.fromMap(penjualanMapList[i]));
  //   }
  //   return penjualanList;
  // }
}
