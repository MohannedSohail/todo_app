
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/shared/cubit/states.dart';

import '../../modules/archived_tasks/archived_screen.dart';
import '../../modules/done_tasks/done_screen.dart';
import '../../modules/new_tasks/tasks_screen.dart';
import '../components/constants.dart';

class AppCubit extends Cubit<AppStates>{

  AppCubit():super(AppInitialState());



  static AppCubit get(context) => BlocProvider.of(context);

  Database? database;
  List<Map> tasks=[];

  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit_outlined;

  int currentIndex = 0;


  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  List<Widget> screens = [
    TasksScreen(),
    DoneScreen(),
    ArchivedScreen(),
  ];

  List appBarTitles = [
    "Tasks Screen",
    "Done Screen",
    "Archived Screen",
  ];

  void changeIndex(int index){
    currentIndex=index;
    emit(AppChangeBottomNavBarState());
  }

  void changeBottomSheetState({required bool isShow,required IconData icon}){

    isBottomSheetShown=isShow;
    fabIcon=icon;

    emit(AppChangeBottomSheetState());
  }


  // void changeTimeControllerState({ required TextEditingController time}){
  //
  //   timeController=time;
  //   emit(AppChangeTimeControllerState());
  // }
  //
  // void changeDateControllerState({ required TextEditingController date}){
  //
  //   dateController=date;
  //
  //   emit(AppChangeDateControllerState());
  // }







  void createDatabase()  {
    openDatabase(
      'todo.db',
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
            tasks = value;
            print("tasks => $tasks");

            emit(AppGetDatabaseState());

          //
          // });
        });
      },
    ).then((value) {
      database=value;
      emit(AppCreateDatabaseState());
    });
  }

  Future insertToDatabase(String title, String time, String date) async {
    await database!.transaction((txn) {
      var response = txn
          .rawInsert(
          "insert into tasks (title,date,time,status) VALUES ('${title}','${date}','${time}','new')")
          .then((value) {
            emit(AppInsertDatabaseState());

            getDataFromDatabase(database).then((value) {

              tasks = value;
              print("tasks => $tasks");

              titleController.clear();
              timeController.clear();
              dateController.clear();

              emit(AppGetDatabaseState());

            });        print("value is ${value.toString()} Inserted Successfully");
      }
          )
          .catchError((error) {
        print("Error When Inserting New Task   ==> ${error.toString()}");
      });

      return response;
    });
  }

  Future<List<Map>> getDataFromDatabase(database) async {

    emit(AppGetDatabaseLoadingState());
    return await database!.rawQuery("SELECT * FROM 'tasks' ");
  }

}