import 'package:sqflite/sqflite.dart' as sql;

class DatabaseHelper{
  static Future<void> createTables(sql.Database database) async{
    await database.execute("""CREATE TABLE data(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      name TEXT,
      protein TEXT,
      carb TEXT,
      fat TEXT,
      fiber TEXT,
      createAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )""");
  }

  static Future<sql.Database> db() async{
    return sql.openDatabase(
      "database_name.db",
      version: 1,
      onCreate: (sql.Database database, int version) async{
        await createTables(database);
      }
    );
  }

  static Future<int> createData(String name, String? protein, String? carb, String? fat, String? fiber) async{
    final db = await DatabaseHelper.db();

    final data = {'name': name, 'protein': protein, 'carb': carb, 'fat': fat, 'fiber': fiber};
    final id = await db.insert('data', data, conflictAlgorithm: sql.ConflictAlgorithm.replace);

    return id;
  }

  static Future<List<Map<String, dynamic>>> getAllData() async{
    final db = await DatabaseHelper.db();
    return db.query('data', orderBy: 'id');
  }

  static Future<List<Map<String, dynamic>>> getSingleData(int id) async{
    final db = await DatabaseHelper.db();
    return db.query('data', where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<int> updateData(int id, String name, String? protein, String? carb, String? fat, String? fiber) async{
    final db = await DatabaseHelper.db();
    final data = {
      'name': name, 
      'protein': protein, 
      'carb': carb, 
      'fat': fat, 
      'fiber': fiber,
      'createAt': DateTime.now().toString()
    };
    final result = await db.update('data', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  static Future<void> deleteData(int id) async{
    final db = await DatabaseHelper.db();
    try{
      await db.delete('data', where: "id = ?", whereArgs: [id]);
    }catch(e){
      print(e);
    }
  }
}