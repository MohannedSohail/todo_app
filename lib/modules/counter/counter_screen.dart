import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/modules/counter/cubit/states.dart';

import 'cubit/cubit.dart';

class CounterScreen extends StatelessWidget {
  const CounterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CounterCubit(),
      child: BlocConsumer<CounterCubit, CounterStates>(
        listener: (BuildContext context, state) {
          if(state is CounterMinusState) print("MinusState ${state.counter}");
          if(state is CounterPlusState) print("PlusState ${state.counter}");
          if(state is CounterResetState) print("ResetState ${state.counter}");
        },
        builder: (BuildContext context, Object? state) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Counter Screen"),
              centerTitle: true,
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                        onPressed: () {

                          CounterCubit.get(context).minus();

                        },
                        child: Text("Minus", style: TextStyle(fontSize: 25))),
                    Text(
                      "${CounterCubit.get(context).counter}",
                      style: TextStyle(
                          fontSize: 40,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                        onPressed: () {

                          CounterCubit.get(context).plus();

                        },
                        child: Text(
                          "Plus",
                          style: TextStyle(fontSize: 25),
                        )),
                  ],
                ),
                SizedBox(height: 20,),


                TextButton(
                    onPressed: () {

                      CounterCubit.get(context).resetCounter();

                    },
                    child: Text("Reset Counter", style: TextStyle(fontSize: 25,color: Colors.red))),



              ],
            ),
          );
        },
      ),
    );
  }
}
