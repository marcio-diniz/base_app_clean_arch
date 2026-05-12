import 'package:base_app_clean_arch/core/services/life_cycle/i_life_cycle_dispatcher.dart';
import 'package:base_app_clean_arch/core/services/life_cycle/i_life_cycle_observer.dart';
import 'package:flutter/material.dart';

class LifeCycleDispatcher implements ILifeCycleDispatcher {
  final List<ILifeCycleObserver> observers = [];
  @override
  void addObserver(ILifeCycleObserver observer) {
    observers.add(observer);
  }

  @override
  Future<void> onStart() async {
    debugPrint('--[LifeCycleDispatcher][onStart]');
    await Future.wait(observers.map((observer) => observer.onStart()));
  }

  @override
  Future<void> onResume() async {
    debugPrint('--[LifeCycleDispatcher][onResume]');
    await Future.wait(observers.map((observer) => observer.onResume()));
  }

  @override
  Future<void> onPause() async {
    debugPrint('--[LifeCycleDispatcher][onPause]');
    await Future.wait(observers.map((observer) => observer.onPause()));
  }
}
