import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/shared/components/components.dart';
import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:todo_app/shared/cubit/states.dart';

import '../modules/archived_tasks/archived_screen.dart';
import '../modules/done_tasks/done_screen.dart';
import '../modules/new_tasks/tasks_screen.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';

import '../shared/components/constants.dart';

class HomeLayout extends StatelessWidget {


  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();




  // @override
  // void initState() {
  //   super.initState();
  //   createDatabase();
  // }

  @override
  Widget build(BuildContext context) {


    return BlocProvider(
      create: (BuildContext context)=>AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (BuildContext context, state) {

          if(state is AppInsertDatabaseState){
            Navigator.pop(context);
          }
        },
        builder: (BuildContext context, Object? state) {

          AppCubit cubit=AppCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(
                cubit.appBarTitles[cubit.currentIndex],
                style: TextStyle(color: Colors.black),
              ),
              centerTitle: true,
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (cubit.isBottomSheetShown) {
                  if (formKey.currentState!.validate()) {

                    cubit.insertToDatabase(cubit.titleController.text, cubit.timeController.text,
                        cubit.dateController.text);
                    // insertToDatabase(titleController.text, timeController.text,
                    //     dateController.text)
                    //     .then((value) {
                    //   // Navigator.pop(context);
                    //   //
                    //   // getDataFromDatabase(database).then((value) {
                    //   //   // setState(() {
                    //   //   //   tasks = value;
                    //   //   //   fabIcon = Icons.edit_outlined;
                    //   //   //   isBottomSheetShown = false;
                    //   //   //   titleController.clear();
                    //   //   //   timeController.clear();
                    //   //   //   dateController.clear();
                    //   //   // });
                    //   //   print("tasks => $tasks");
                    //   // });
                    // });
                  }
                } else {
                  scaffoldKey.currentState!
                      .showBottomSheet(
                          (context) => Container(
                        color: Colors.white,
                        padding: EdgeInsets.all(20),
                        child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              defaultTextFormField(
                                  controller:cubit.titleController,
                                  type: TextInputType.text,
                                  validator: (value) {
                                    if (value.toString().isEmpty) {
                                      return "Title Is Empty";
                                    }
                                  },
                                  labelTxt: "Title",
                                  prefixIcon: Icons.title_rounded),
                              SizedBox(
                                height: 15,
                              ),
                              defaultTextFormField(
                                controller:cubit.timeController,
                                type: TextInputType.datetime,
                                readOnly: true,
                                validator: (value) {
                                  if (value.toString().isEmpty) {
                                    return "Time Is Empty";
                                  }
                                },
                                labelTxt: "Time",
                                prefixIcon: Icons.access_time,
                                onTap: () {
                                  showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  ).then((value) {
                                    // setState(() {
                                  cubit.timeController.text = value!
                                          .format(context)
                                          .toString();

                                    // cubit.changeTimeControllerState(time: cubit.timeController);

                                    // })
                                  });
                                },
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              defaultTextFormField(
                                controller: cubit.dateController,
                                type: TextInputType.datetime,
                                readOnly: true,
                                validator: (value) {
                                  if (value.toString().isEmpty) {
                                    return "Date Is Empty";
                                  }
                                },
                                labelTxt: "Date",
                                prefixIcon: Icons.date_range_rounded,
                                onTap: () {
                                  showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate:
                                      DateTime.parse("2030-03-30"))
                                      .then((value) {
                                    // setState(() {
                                      cubit.dateController.text =
                                          DateFormat.yMMMd()
                                              .format(value!);

                                      // cubit.changeDateControllerState(date: cubit.dateController);
                                    // })
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      elevation: 25)
                      .closed
                      .then((value) {

                        cubit.changeBottomSheetState(isShow: false, icon: Icons.edit_outlined);
                    // cubit.isBottomSheetShown = false;
                    // setState(() {
                    //   fabIcon = Icons.edit_outlined;
                    //   titleController.clear();
                    //   timeController.clear();
                    //   dateController.clear();
                    // });
                  });
                  cubit.changeBottomSheetState(isShow: true, icon: Icons.add);

                  // cubit.isBottomSheetShown = true;
                  // setState(() {
                  //   fabIcon = Icons.add;
                  // });
                }
              },
              child: Icon(cubit.fabIcon, size: 28, color: Colors.black),
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              elevation: 30,
              currentIndex: cubit.currentIndex,
              onTap: (index) {

                cubit.changeIndex(index);
                // setState(() {
                //   _currentIndex = index;
                // });
                print("On Tap Index ==> $index");
              },
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.menu), label: "Tasks"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.check_circle_outline), label: "Done"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.archive_outlined), label: "Archived"),
              ],
            ),
            // body: tasks!.length == 0

            body: state is AppGetDatabaseLoadingState
                ? Center(
                child: CircularProgressIndicator(
                  strokeWidth: 6,
                ))
                : cubit.screens[cubit.currentIndex],
          );

        },
      ),
    );
  }

  // void createDatabase() async {
  //   database = await openDatabase(
  //     "todo.db",
  //     version: 1,
  //     onCreate: (db, version) {
  //       print("database created");
  //       db
  //           .execute(
  //               'create table "tasks" (id INTEGER PRIMARY KEY  AUTOINCREMENT , title TEXT, date TEXT , time TEXT, status TEXT)')
  //           .then((value) => print("table crated"))
  //           .catchError((error) {
  //         print("Error ${error.toString()}");
  //       });
  //     },
  //     onOpen: (database) {
  //       print("database Opened");
  //
  //       getDataFromDatabase(database).then((value) {
  //         // setState(() {
  //         //   tasks = value;
  //         //
  //         // });
  //         print("tasks => $tasks");
  //       });
  //     },
  //   );
  // }
  //
  // Future insertToDatabase(String title, String time, String date) async {
  //   await database!.transaction((txn) {
  //     var response = txn
  //         .rawInsert(
  //             "insert into tasks (title,date,time,status) VALUES ('${title}','${date}','${time}','new')")
  //         .then((value) =>
  //             print("value is ${value.toString()} Inserted Successfully"))
  //         .catchError((error) {
  //       print("Error When Inserting New Task   ==> ${error.toString()}");
  //     });
  //
  //     return response;
  //   });
  // }
  //
  // Future<List<Map>> getDataFromDatabase(database) async {
  //   return await database!.rawQuery("SELECT * FROM 'tasks' ");
  // }
}
