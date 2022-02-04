import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/layout/news_app/cubit/cubit.dart';
import 'package:todo/layout/news_app/cubit/states.dart';
import 'package:todo/shared/component/cubit/cubit.dart';
import 'package:todo/shared/component/cubit/states.dart';
import 'package:todo/shared/network/remote/dio_helper.dart';
import 'package:todo/shared/styles/block_observer.dart';
import 'layout/news_app/news_layout.dart';

void main() {
  DioHelper.init();
  BlocOverrides.runZoned(
        () {
          runApp(MyApp());
      // Use cubits...
    },
    blocObserver: MyBlocObserver(),
  );

}
class MyApp extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return BlocProvider(
      create: (BuildContext context)=>AppCubit(),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context,states){},
        builder: (context,states){
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData
                (
                primarySwatch: Colors.deepOrange,
                floatingActionButtonTheme: FloatingActionButtonThemeData(
                    backgroundColor:  Colors.deepOrange
                ),
                scaffoldBackgroundColor: Colors.white,
                appBarTheme: AppBarTheme(
                  titleSpacing: 20.0,
                  iconTheme: IconThemeData(color: Colors.black,),
                  backwardsCompatibility: false,
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.red,
                    statusBarIconBrightness:Brightness.dark,
                  ),
                  backgroundColor: Colors.white,
                  elevation: 0.0,
                  titleTextStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  type:  BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.deepOrange,
                  unselectedItemColor: Colors.black,
                  elevation: 20.0,
                  backgroundColor: Colors.white,
                ),
                textTheme: TextTheme(
                  bodyText1: TextStyle( fontSize: 18.0,fontWeight: FontWeight.w600,color: Colors.black),
                ),
              ),
              themeMode: AppCubit.get(context).isDark?ThemeMode.dark : ThemeMode.light,
              darkTheme: ThemeData(
                primarySwatch: Colors.deepOrange,
                scaffoldBackgroundColor: Colors.black12,
                floatingActionButtonTheme: FloatingActionButtonThemeData(
                    backgroundColor:  Colors.deepOrange
                ),
                appBarTheme: AppBarTheme(
                  titleSpacing: 20.0,
                  iconTheme: IconThemeData(color: Colors.white,),
                  backwardsCompatibility: false,
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.black12,
                    statusBarIconBrightness:Brightness.light,
                  ),
                  backgroundColor: Colors.black12,
                  elevation: 0.0,
                  titleTextStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  type:  BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.deepOrange,
                  unselectedItemColor: Colors.white,
                  elevation: 20.0,
                  backgroundColor: Colors.black12,
                ),
                textTheme: TextTheme(
                  bodyText1: TextStyle( fontSize: 18.0,fontWeight: FontWeight.w600,color: Colors.white),
                ),


              ),
              home:NewsLayout()
          );
        },
      ),
    );
  }

}
