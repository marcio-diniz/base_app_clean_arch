abstract class ILifeCycleObserver {
  Future<void> onStart() async {}

  Future<void> onResume() async {}

  Future<void> onPause() async {}
}
