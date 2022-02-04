
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo/shared/component/cubit/cubit.dart';
import 'package:todo/shared/component/cubit/states.dart';


class HomeLayout extends StatelessWidget
{


  var scaffoldKey=GlobalKey<ScaffoldState>();
  var formKey=GlobalKey<FormState>();


  var titleController=TextEditingController();
  var timeController=TextEditingController();
  var dateController=TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>AppCubit()..createDataBase(),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (BuildContext context ,AppStates state)
        {
        },
        builder: (BuildContext context ,AppStates state){
          AppCubit cubit =AppCubit.get(context);
          return Scaffold(
            key:scaffoldKey ,
            appBar: AppBar(
              title: Text(
                cubit.titles[cubit.currentIndex],
              ),
            ),
            floatingActionButton: FloatingActionButton
              (
              onPressed: ()
              {
                if(cubit.isBottomSheetShown)
                {
                  if(formKey.currentState!.validate())
                  {
                    cubit.insertDataBase(title: titleController.text, time: timeController.text, date: dateController.text).then((value) {
                      Navigator.pop(context);
                    });


                  }{
                  }
                }else
                {
                  scaffoldKey.currentState!.showBottomSheet(
                        (context) =>Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(20.0),
                      child: Form(

                        key: formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children:
                          [
                            TextFormField(
                              controller: titleController,
                              keyboardType: TextInputType.text,
                              validator:( value) {
                                if (value!.isEmpty) {
                                  return 'title must not be empty';
                                }

                                return null;
                              },
                              decoration: InputDecoration(
                                labelText: 'Task title',

                                prefixIcon: Icon(
                                  Icons.title,
                                ),
                                border: OutlineInputBorder(),
                              ),

                            ),
                            SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              controller: timeController,
                              onTap: ()
                              {
                                showTimePicker(context: context,
                                  initialTime: TimeOfDay.now(),
                                ).then((value)
                                {
                                  timeController.text=value!.format(context).toString();
                                  print(value.format(context));
                                });
                              },
                              keyboardType: TextInputType.datetime,
                              validator: ( value) {
                                if (value!.isEmpty) {
                                  return 'time must not be empty';
                                }

                                return null;
                              },
                              decoration: InputDecoration(
                                labelText: 'tase time',

                                prefixIcon: Icon(
                                  Icons.access_time,
                                ),
                                border: OutlineInputBorder(),
                              ),

                            ),
                            SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              controller: dateController,
                              onTap: ()
                              async {
                                var taskDate =await  showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime.parse('2030-02-05'))
                                    .then((value)
                                {
                                  dateController.text= DateFormat.yMMMd().format(value!) ;

                                }
                                ).catchError((error)
                                {
                                  print('you made error $error');
                                });
                              },
                              keyboardType: TextInputType.datetime,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'date must not be empty';
                                }
                                return null;

                              },
                              decoration: InputDecoration(
                                labelText: 'task date',

                                prefixIcon: Icon(
                                  Icons.calendar_today,
                                ),
                                border: OutlineInputBorder(),
                              ),

                            ),

                          ],
                        ),
                      ),
                    ),
                    elevation:20.0 ,

                  ).closed.then((value)
                  {
                    cubit.changeBottomSheetState(
                        isShow: false,
                        icon: Icons.edit);
                  });
                  cubit.changeBottomSheetState(
                      isShow: true,
                      icon: Icons.add);
                }
              },
              child: Icon(
                cubit.fabIcon,
              ),


            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              showSelectedLabels:true ,
              currentIndex: cubit.currentIndex,
              onTap: (inedx)
              {
                cubit.changeIndex(inedx);
              },
              items:
              [
                BottomNavigationBarItem(
                    icon: Icon(Icons.menu,),
                    label:'tasks'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.check,),
                    label:'Done'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.archive,),
                    label:'Archive'),

              ],
            ),
            body: cubit.screens[cubit.currentIndex],
          );
        },

      ),
    );
  }
/*Future<String> getName() async
  {
    return 'ahmed ali';
  }*/




}


