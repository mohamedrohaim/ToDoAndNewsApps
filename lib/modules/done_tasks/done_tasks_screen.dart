import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/shared/component/component.dart';
import 'package:todo/shared/component/cubit/cubit.dart';
import 'package:todo/shared/component/cubit/states.dart';
class DoneTasksScreen extends StatelessWidget {
  const DoneTasksScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<AppCubit , AppStates>(
      listener: (context , state){},
      builder: (context , state)
      {
        var tasks=AppCubit.get(context).doneTasks;

        return tasksBuilder(
          tasks: tasks,
        );
      },
    );

  }
}