import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/layout/news_app/cubit/states.dart';
import 'package:todo/modules/business/busniess_screen.dart';
import 'package:todo/modules/science/science_screen.dart';
import 'package:todo/modules/sports/sports_screen.dart';
import 'package:todo/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates>
{
  NewsCubit(): super(NewsInitialState());
  static NewsCubit get(context)=>BlocProvider.of(context);

  int currentIndex=0;
  List<BottomNavigationBarItem>bottomItems =
  [
    BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.sports),
      label: 'Sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.science),
      label: 'Science',
    ),

  ];
  List<Widget>screens=[
    BusinesScreen(),
    SportsScreen(),
    ScienceScreen(),

  ];
  void onChangeBottomNavBar(int index){
    currentIndex=index;
    if(index==1)
      getSports();
    if(index==2)
      getScience();

    emit(NewsBottomNavState());
  }


List<dynamic> business=[];
  void getBusiness()
  {
    emit(NewsBusinessLoadingState());

    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country':'eg',
        'category':'business',
        'apiKey':'bc574e56ea174adca390ea5c88b6b654',
      },
    ).then((value){
      //print(value.data['articles'][0]['title']);
      business=value.data['articles'];
      print(business[0]['title']);
      emit(NewsgetBusinessSuccesState());
    }).catchError((error){
      print(error.toString());
      emit(NewsgetBusinessErorState(error.toString()));
    });
  }


  List<dynamic> sports=[];
  void getSports()
  {
    emit(NewsSportsLoadingState());
    if (sports.length==0)
    {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country':'eg',
          'category':'sports',
          'apiKey':'bc574e56ea174adca390ea5c88b6b654',
        },
      ).then((value){
        //print(value.data['articles'][0]['title']);
        sports=value.data['articles'];
        print(sports[0]['title']);
        emit(NewsgetSportsSuccesState());
      }).catchError((error){
        print(error.toString());
        emit(NewsgetSportsErorState(error.toString()));
      });
    }else
      {
        emit(NewsgetSportsSuccesState());
      }

  }


  List<dynamic> science=[];
  void getScience()
  {
    emit(NewsScienceLoadingState());
    if (science.length==0)
      {
        DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country':'eg',
            'category':'science',
            'apiKey':'bc574e56ea174adca390ea5c88b6b654',
          },
        ).then((value){
          //print(value.data['articles'][0]['title']);
          science=value.data['articles'];
          print(science[0]['title']);
          emit(NewsgetScienceSuccesState());
        }).catchError((error){
          print(error.toString());
          emit(NewsgetScienceErorState(error.toString()));
        });
      }
    else
      {
        emit(NewsgetScienceSuccesState());
      }

  }


}