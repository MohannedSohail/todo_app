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
          var tasks = AppCubit.get(context).newTasks;

          return tasks.length == 0
              ? appNoData(icon: Icons.menu,txt: "There Is No Tasks")
              : ListView.separated(
                  itemBuilder: (context, index) => buildTaskItem(tasks[index],context,true,true),
                  separatorBuilder: (context, index) => Container(
                    margin: EdgeInsets.only(left: 15,right: 15),
                        width: double.infinity,
                        height: 2,
                        color: Colors.grey[350],
                      ),
                  itemCount: tasks.length);
        });
  }
}
