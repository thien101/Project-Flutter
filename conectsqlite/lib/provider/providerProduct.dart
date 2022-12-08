import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart'; //import these

import '../model/contacts.dart';

class DBProduct {
  static Future<Database> initDB() async {
    var dbPath = await getDatabasesPath();
    String path = join(dbPath, 'products.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  static Future _onCreate(Database db, int version) async {
    final sql = '''CREATE TABLE products(
      id INTEGER PRIMARY KEY,
      title TEXT,
      price INTEGER,
      category TEXT,
      image TEXT,
      sl INTEGER
    )''';
    await db.execute(sql);
  }

  static Future<int> createProducts(Customer customer) async {
    Database db = await DBProduct.initDB();
    return await db.insert('products', customer.toJson());
  }

  static Future<List<Customer>> readProducts() async {
    Database db = await DBProduct.initDB();
    var customer = await db.query('products', orderBy: 'title');
    List<Customer> customersList = customer.isNotEmpty
        ? customer.map((details) => Customer.fromJson(details)).toList()
        : [];
    return customersList;
  }

  static Future<int> updateProducts(Customer contact) async {
    Database db = await DBProduct.initDB();
    return await db.update('products', contact.toJson(),
        where: 'id = ?', whereArgs: [contact.id]);
  }

  static Future<int> deleteProducts(int id) async {
    Database db = await DBProduct.initDB();
    return await db.delete('products', where: 'id = ?', whereArgs: [id]);
  }
}
