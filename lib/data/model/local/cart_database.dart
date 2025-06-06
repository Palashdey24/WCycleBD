import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

class CartDatabase {
  static Future<Database> getDatabase() async {
    final databasesPath = await sql.getDatabasesPath();
    final db = await sql.openDatabase(
      path.join(databasesPath, 'wCycle.db'),
      onCreate: (db, version) {
        return db.execute(
            "CREATE TABLE carts (id TEXT PRIMARY KEY, userID TEXT, productId TEXT, storeId TEXT, quantity INTEGER)");
      },
      version: 2,
    );
    return db;
  }
}
