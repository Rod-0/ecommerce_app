import 'package:ecommerce_app/database/products_database.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:sqflite/sqflite.dart';

class ProductsRepository{
  Future insert(Product products) async {
    Database db = await ProductsDatabase().openDb();
    db.insert(ProductsDatabase().tableName, products.toMap());
  }

  Future delete(Product products) async {
    Database db = await ProductsDatabase().openDb();
    db.delete(ProductsDatabase().tableName,
        where: "id = ?", whereArgs: [products.id]);
  }

  Future<bool> isFavorite(Product products) async {
    Database db = await ProductsDatabase().openDb();
    final maps = await db.query(ProductsDatabase().tableName,
        where: "id=?", whereArgs: [products.id]);
    return maps.isNotEmpty;
  }

  Future <List<Product>> getAll() async{
    Database db = await ProductsDatabase().openDb();
    final maps = await db.query(ProductsDatabase().tableName);
    return maps.map((map) => Product.fromMap(map)).toList();
  }
}