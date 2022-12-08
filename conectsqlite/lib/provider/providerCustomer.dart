import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart'; //import these

import '../model/contacts.dart';

class DBHelper {
  static Future<Database> initDB() async {
    var dbPath = await getDatabasesPath();
    String path = join(dbPath, 'customers.db');
    //this is to create database
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  //build _onCreate function
  static Future _onCreate(Database db, int version) async {
    final sql = '''CREATE TABLE customers(
      id INTEGER PRIMARY KEY,
      name TEXT,
      phone TEXT,
      email TEXT,
      user TEXT,
      pass TEXT
    )''';
    //sqflite is only support num, string, and unit8List format
    //please refer to package doc for more details
    await db.execute(sql);
  }

  //build create function (insert)
  static Future<int> createCustomers(Customer customer) async {
    Database db = await DBHelper.initDB();
    //create customer using insert()
    return await db.insert('customers', customer.toJson());
  }

  //build read function
  static Future<List<Customer>> readCustomers() async {
    Database db = await DBHelper.initDB();
    var customer = await db.query('customers', orderBy: 'name');
    //this is to list out the customer list from database
    //if empty, then return empty []
    List<Customer> customersList = customer.isNotEmpty
        ? customer.map((details) => Customer.fromJson(details)).toList()
        : [];
    return customersList;
  }

  //build update function
  static Future<int> updateCustomers(Customer contact) async {
    Database db = await DBHelper.initDB();
    //update the existing customer
    //according to its id
    return await db.update('customers', contact.toJson(),
        where: 'id = ?', whereArgs: [contact.id]);
  }

  //build delete function
  static Future<int> deleteCustomers(int id) async {
    Database db = await DBHelper.initDB();
    //delete existing customer
    //according to its id
    return await db.delete('customers', where: 'id = ?', whereArgs: [id]);
  }
}
