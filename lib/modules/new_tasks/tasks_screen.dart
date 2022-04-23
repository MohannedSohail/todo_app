import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/shared/components/components.dart';
import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:todo_app/shared/cubit/states.dart';

import '../../shared/components/constants.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var tasks = AppCubit.get(context).tasks;

          return tasks.length == 0
              ? Container(
                  child: Text("There Is No Tasks"),
                  alignment: Alignment.center,
                )
              : ListView.separated(
                  itemBuilder: (context, index) => buildTaskItem(tasks[index]),
                  separatorBuilder: (context, index) => Container(
                        width: double.infinity,
                        height: 2,
                        color: Colors.grey[300],
                      ),
                  itemCount: tasks.length);
        });
  }
}
