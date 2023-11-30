import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ProductsDatabase {
  final int version = 1;
  final String databaseName = "products.db";
  final String tableName = "products";

  Database? db;

  Future<Database> openDb() async {
    db ??= await openDatabase(join(await getDatabasesPath(), databaseName),
        onCreate: (database, version) {
      database.execute("create table $tableName (id int primary key,name text)");
    }, version: version);
    return db as Database;
  }
}