import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

class WishlistDatabase {
  static Future<Database> getDatabase() async {
    final databasesPath = await sql.getDatabasesPath();
    final db = await sql.openDatabase(
      path.join(databasesPath, 'wCycleWish.db'),
      onCreate: (db, version) {
        return db.execute("CREATE TABLE wishlist (productId TEXT PRIMARY KEY)");
      },
      version: 2,
    );
    return db;
  }
}
