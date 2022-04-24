

import 'package:sqflite/sqflite.dart';

    Database? database;
    List<Map> tasks=[];


void createDatabase() async {
  database = await openDatabase(
    "todo.db",
    version: 1,
    onCreate: (db, version) {
      print("database created");
      db
          .execute(
              'create table "tasks" (id INTEGER PRIMARY KEY  AUTOINCREMENT , title TEXT, date TEXT , time TEXT, status TEXT)')
          .then((value) => print("table crated"))
          .catchError((error) {
        print("Error ${error.toString()}");
      });
    },
    onOpen: (database) {
      print("database Opened");

      getDataFromDatabase(database).then((value) {
        // setState(() {
        //   tasks = value;
        //
        // });
        print("tasks => $tasks");
      });
    },
  );
}

Future insertToDatabase(String title, String time, String date) async {
  await database!.transaction((txn) {
    var response = txn
        .rawInsert(
            "insert into tasks (title,date,time,status) VALUES ('${title}','${date}','${time}','new')")
        .then((value) =>
            print("value is ${value.toString()} Inserted Successfully"))
        .catchError((error) {
      print("Error When Inserting New Task   ==> ${error.toString()}");
    });

    return response;
  });
}

Future<List<Map>> getDataFromDatabase(database) async {
  return await database!.rawQuery("SELECT * FROM 'tasks' ");
}