import 'package:base_app_clean_arch/core/services/life_cycle/i_life_cycle_dispatcher.dart';
import 'package:flutter/material.dart';

class LifeCycleManager extends StatefulWidget {
  const LifeCycleManager({
    super.key,
    required this.child,
    required this.lifeCycleDispatcher,
  });
  final Widget child;
  final ILifeCycleDispatcher lifeCycleDispatcher;

  @override
  State<LifeCycleManager> createState() => _LifeCycleManagerState();
}

class _LifeCycleManagerState extends State<LifeCycleManager>
    with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    widget.lifeCycleDispatcher.onStart();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        return widget.lifeCycleDispatcher.onResume();
      case AppLifecycleState.paused:
        return widget.lifeCycleDispatcher.onPause();
      default:
        return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
