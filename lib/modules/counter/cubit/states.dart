
abstract class CounterStates{}


class CounterInitialState extends CounterStates{}

class CounterPlusState extends CounterStates{

  final int counter;

  CounterPlusState(this.counter);

}

class CounterMinusState extends CounterStates{

  final int counter;

  CounterMinusState(this.counter);

}

class CounterResetState extends CounterStates{

  final int counter;

  CounterResetState(this.counter);
}