import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/layout/news_app/cubit/cubit.dart';
import 'package:todo/layout/news_app/cubit/states.dart';
import 'package:todo/shared/component/cubit/cubit.dart';

class NewsLayout extends StatelessWidget
{

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>NewsCubit()..getBusiness(),
      child: BlocConsumer<NewsCubit,NewsStates>(
         listener: (context,state){},
        builder: (context,state)
        {
          var cubit=NewsCubit.get(context);
           return Scaffold(
             appBar: AppBar(
               title: Text('News App',),
               actions: [
                 IconButton(onPressed: (){},
                     icon: Icon(Icons.search,size: 40.0,)),
                 IconButton(onPressed: ()
                 {
                   AppCubit.get(context).changeAppMode();
                 },
                     icon: Icon(Icons.brightness_4_outlined,size: 40.0,)),
               ],

             ),

             body: cubit.screens[cubit.currentIndex],
             bottomNavigationBar:BottomNavigationBar(
               items: cubit.bottomItems,
               currentIndex: cubit.currentIndex,
               onTap: (index)
               {
                 cubit.onChangeBottomNavBar(index);
               },

             ),

           );
        },
      ),
    );
  }
}
