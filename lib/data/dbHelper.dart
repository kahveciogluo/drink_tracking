import 'dart:async';
import 'package:drink_tracking/models/user.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:drink_tracking/models/consume.dart';
import 'package:drink_tracking/models/drink.dart';
import 'package:intl/intl.dart';

class DbHelper{
  Database _db;

  Future<Database> get db async {
    if(_db==null){
      _db = await initializeDb();
    }
    return _db;
  }

  Future<Database> initializeDb() async {
    String dbPath = join(await getDatabasesPath(), "drinktracking14.db");
    var drinkTrackingDb = await openDatabase(dbPath, version: 1, onCreate: createDb);
    return drinkTrackingDb;
  }

 void createDb(Database db, int version) async {
    await db.execute("CREATE TABLE drinks(id INTEGER PRIMARY KEY, name TEXT, minConsume INTEGER, maxConsume INTEGER, consumeStep INTEGER)");
    await db.execute("CREATE TABLE consumes(id INTEGER PRIMARY KEY, drinkId INTEGER, amount INTEGER, consumedTime TEXT, FOREIGN KEY (drinkId) REFERENCES drinks (id)) ");
    await db.execute("CREATE TABLE user(id INTEGER PRIMARY KEY, gender TEXT, age INTEGER, weight INTEGER, dailyNeedWater INTEGER)");
    await db.rawInsert("INSERT INTO user(gender,age,weight,dailyNeedWater) values('wm', 0, 0, 1500)");
    await db.rawInsert("INSERT INTO drinks(name,minConsume,maxConsume,consumeStep) values('water', 0, 500,100)");
    await db.rawInsert("INSERT INTO drinks(name,minConsume,maxConsume,consumeStep) values('coffee', 0, 600,150)");
    await db.rawInsert("INSERT INTO drinks(name,minConsume,maxConsume,consumeStep) values('tea', 0, 600,150)");

  }

  Future<int> insertDrink(Drink drink) async{
    Database db = await this.db;
    var result = await db.insert("drinks", drink.toMap());
    return result;
  }


  Future<List<Drink>> getDrinks() async{
    Database db = await this.db;
    var result = await db.query("drinks");
    return List.generate(result.length, (i){
      return Drink.fromMap(result[i]);
    });
  }

  Future<List<User>> getUser() async{
    Database db = await this.db;
    var result = await db.query("user");
    return List.generate(result.length, (i){
      return User.fromMap(result[0]);
    });
  }

  Future<int> getWaterYouNeed() async{
    Database db = await this.db;
    List result = await db.rawQuery("SELECT dailyNeedWater FROM user  WHERE id = 1");
    int value = result[0]["dailyNeedWater"];
    return value;

  }

  Future<int> updateUser(User user) async{
    Database db = await this.db;
    var result = await db.update("user", user.toMap(), where: "id=?", whereArgs: [user.id]);
    return result;
  }

  Future<List<Consume>> getConsumes() async{
    Database db = await this.db;
    var result = await db.rawQuery("SELECT consumes.id, amount, name, drinks.id did, consumedTime FROM consumes INNER JOIN drinks ON drinks.id = consumes.drinkId ");
    return List.generate(result.length, (i){
      return Consume.fromObject(result[i]);
    });
  }

  Future<List<Consume>> getSelectedDayConsumes(String selectedDay) async{
    Database db = await this.db;
    var result = await db.rawQuery("SELECT consumes.id, amount, name, drinks.id did, consumedTime FROM consumes INNER JOIN drinks ON drinks.id = consumes.drinkId where consumedTime = '$selectedDay'");
    return List.generate(result.length, (i){
      return Consume.fromObject(result[i]);
    });
  }


  Future<int> getWaterYouConsumedThisDay(String selectedDay) async{
    Database db = await this.db;
    List result = await db.rawQuery("SELECT SUM(amount) totalWater FROM consumes  WHERE consumedTime = '$selectedDay' AND  drinkId = 1");
    int value = result[0]["totalWater"];
    return value;

  }

  Future<int> insertConsume(Consume consume) async{
    Database db = await this.db;
    var result = await db.insert("consumes", consume.toMap());
    return result;
  }

  Future<int> deleteConsume(int id) async{
    Database db = await this.db;
    var result = await db.rawDelete("DELETE FROM consumes where id = $id");
    return result;
  }

  Future<int> updateConsume(Consume consume) async{
    Database db = await this.db;
    var result = await db.update("consumes", consume.toMap(), where: "id=?", whereArgs: [consume.id]);
    return result;
  }

}