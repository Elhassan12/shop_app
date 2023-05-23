import 'package:shop_app/shared/cubit/states.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../network/local/cache_helper.dart';
class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit getInstance(context) {
    return BlocProvider.of(context);
  }

  int currentindex = 0;
  List<Widget> screens = [
    // TasksScreen(),
    // DoneTasksScreen(),
    // Archived(),
  ];
  List<String> titles = [
    "Tasks",
    "Done Tasks",
    "Archived",
  ];

  void setCurrentindex(int index) {
    currentindex = index;
    emit(AppNavBarChangeState());
  }

  bool isshowbottomsheet = false;
  IconData bottomsheeticon = Icons.edit;

  void setShowBottomSheet({
    required bool isShow,
    required IconData icon,
  }) {
    isshowbottomsheet = isShow;
    bottomsheeticon = icon;
    emit(BottomsheetChangeState());
  }

  late Database database;

  List<Map> newtasks = [];
  List<Map> donetasks = [];
  List<Map> archivedtasks = [];

  void createDatabase() {
    openDatabase(
      "todo_new.db",
      version: 1,
      onCreate: (database, version) {
        print("database created");
        database
            .execute(
                "create table tasks (id integer primary key,title text, date text, time text, status text)")
            .then((value) {
          print("table created");
        }).catchError((error) {
          print("error is ${error.toString()}");
        });
      },
      onOpen: (database) {
        getFromDatabase(database);

        print("database opend");
      },
    ).then((value) {
      database = value;
      emit(DataBaseCreateState());
    });
  }

  void getFromDatabase(database) {
    newtasks = [];
    donetasks = [];
    archivedtasks = [];
    database.rawQuery("select * from tasks").then((value) {
      value.forEach((element) {
        if (element['status'] == 'Done')
          donetasks.add(element);
        else if (element['status'] == 'new')
          newtasks.add(element);
        else
          archivedtasks.add(element);
      });
      emit(DataBaseGetState());
    });
  }

  insertIntoDatabase({
    required String title,
    required String time,
    required String date,
  }) async {
    await database.transaction((txn) async {
      txn
          .rawInsert(
              "insert into tasks (title, date, time, status ) values('$title','$date','$time','new')")
          .then((value) {
        print("$value inserted successfully");
        emit(DataBaseInsertState());

        getFromDatabase(database);
      }).catchError((error) {
        print("an error while inserting in table tasks");
        return null;
      });
    }).catchError((error) {
      print("an error happened");
    });
  }

  // void updateraw({required int id, required String status})  {
  //    database.rawUpdate(
  //       'UPDATE tasks SET status = ? WHERE id = ?', ['$status', id]).then((value) {
  //         getFromDatabase(database);
  //         emit(DataBaseUpdateState());
  //   });
  //
  // }

  void updateData({
    required String status,
    required int id,
  }) async {
    database.rawUpdate(
      'UPDATE tasks SET status = ? WHERE id = ?',
      ['$status', id],
    ).then((value) {
      getFromDatabase(database);
      emit(DataBaseUpdateState());
    });
  }

  void deleteData({
    required int id,
  }) async {
    database.rawUpdate(
      'DELETE FROM tasks WHERE id= ?',
      ['$id'],
    ).then((value) {
      getFromDatabase(database);
      emit(DataBasedeleteState());
    });
  }

  bool isdark = false;

  void changeMode({bool? fromShared}) {
    if (fromShared != null) {
      isdark = fromShared;
      emit(Changemodestate());
    }
    else
    {
      isdark = !isdark;
      CacheHelper.putBoolean(key: "isdark", value: isdark).then((value) {
        emit(Changemodestate());
      });
    }
  }
}
