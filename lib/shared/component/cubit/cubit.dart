import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/modules/archive_tasks/archive_tasks_screen.dart';
import 'package:todo/modules/done_tasks/done_tasks_screen.dart';
import 'package:todo/modules/new_tasks/new_tasks_screen.dart';
import 'package:todo/shared/component/cubit/states.dart';
import 'package:todo/shared/network/local/cache_helper.dart';

class AppCubit extends Cubit<AppStates>
{
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) =>BlocProvider.of(context);

  int currentIndex=0;
  List<Widget>screens=
  [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchiveTasksScreen(),
  ];
  List<String>titles=
  [
    'New tasks',
    'Done tasks',
    'Archive tasks',
  ];
  void changeIndex(int index)
  {
    currentIndex=index;
    emit(AppChangeBottomVavBarState());

  }
  late Database database;
  List<Map> newTasks= [];
  List<Map> doneTasks= [];
  List<Map> archiveTasks= [];


  void createDataBase()
  {
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database,version)
      {
        print('database created');
        database.execute(
            'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, time TEXT, date TEXT, status TEXT)').then((value)
        {
          print('table created');
        }).catchError((error)
        {
          print(' erroe when creating table ${error.toString()}');
        });

      },
      onOpen: (database)
      {
        getDataFromDataBase(database);
        print('database opened');
      },

    ).then((value) {
      database = value;
      emit(AppCreateDatabaseState());

    });
  }
  Future insertDataBase(
      {
        required title,
        required time,
        required date
      })
  async {
    await database.transaction((txn)async
    {
      txn.rawInsert(
          'INSERT INTO tasks (title,time,date,status) VALUES("$title","$time","$date","new")'
      ).then((value)
      {
        emit(AppInitialState());

        getDataFromDataBase(database);
        print('$value inserted successfully');
      }).catchError((error)
      {


        print('error in insert row ${error.toString()}');
      });

    });
  }
  void getDataFromDataBase(database)
  {
    newTasks=[];
    doneTasks=[];
    archiveTasks=[];


    database.rawQuery('SELECT * FROM tasks').then((value)
    {

      value.forEach((element) {
        if(element['status']=='new')
          newTasks.add(element);
        else if(element['status']=='done')
          doneTasks.add(element);
        else archiveTasks.add(element);


      });
      emit(AppGetDatabaseState());
    });
  }
  void updateData(
      {
        required String status,
        required int id,
      })async
  {
    database.rawUpdate(
        'UPDATE tasks SET status = ? WHERE id = ?',
        ['$status', id]
    ).then((value)
    {
      getDataFromDataBase(database);
      emit(AppUpdateDatabaseState());
    }
    );

  }

  void deleteData(
      {
        required int id,
      })async
  {
    database.rawDelete(
      'DELETE FROM tasks WHERE id = ?', [id],
    ).then((value)
    {
      getDataFromDataBase(database);
      emit(AppDeleteDatabaseState());
    }
    );

  }
  bool isBottomSheetShown=false;
  IconData fabIcon=Icons.edit;
  void changeBottomSheetState(
      {
        required bool isShow,
        required IconData icon,

      })
  {
    isBottomSheetShown= isShow;
    fabIcon=icon;
    emit(AppChangeBottomSheetState());
  }
  bool isDark=false;
  void changeAppMode({bool? fromShared}){
    if(fromShared !=null)
      {
        emit(AppChangeModeState());
        isDark=fromShared;

      }
    else
      {
        isDark=!isDark;
        CacheHelper.putBool(key: 'isDark', value: isDark).then((value)
        {
          emit(AppChangeModeState());
        });
      }


  }

}