import 'i_life_cycle_observer.dart';

abstract class ILifeCycleDispatcher extends ILifeCycleObserver {
  void addObserver(ILifeCycleObserver observer);
}
