

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/components/components.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';

class DoneScreen extends StatelessWidget {
  const DoneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var tasks = AppCubit.get(context).doneTasks;

          return tasks.length == 0
              ? appNoData(icon: Icons.check_circle_outline,txt: "There Is No Done Tasks",color: Colors.green)
              : ListView.separated(
              itemBuilder: (context, index) => buildTaskItem(tasks[index],context,false,true),
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
