import 'dart:async';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/cupertino.dart';
import 'package:multiple_result/multiple_result.dart';

extension FutureTimer<T> on Future<T>{
  static final Map<Key, Timer> _timers = {};
  void openTimer({
    required Key key,
    required FutureOr<void> Function(int seconds) onTimerChanged,
    String? timeoutMessage,
    required Duration throwExceptionWhen,
    required FutureOr<void> Function(TimeoutException e)? onTimeoutException,
  }){
    if(_timers[key]?.isActive?? false){
      return;
    }

    try {
      _runTimer(
          timeoutMessage: timeoutMessage,
          key: key,
          onTimerChanged: onTimerChanged,
          throwExceptionWhen: throwExceptionWhen
      );

    } on TimeoutException catch (e) {
      onTimeoutException?.call(e);
    }
  }

  static void closeTimer({required Key key}){
    _timers[key]?.cancel();
  }

  void _runTimer({
    required Key key,
    String? timeoutMessage,
    required Duration throwExceptionWhen,
    required FutureOr<void> Function(int seconds) onTimerChanged,
}){
    _timers[key] = Timer.periodic(const Duration(seconds: 1), (time){
      if(throwExceptionWhen.inSeconds == time.tick){
        time.cancel();
        throw TimeoutException(timeoutMessage?? 'time out ${throwExceptionWhen.inSeconds}');
      }

      onTimerChanged.call(time.tick);
    });
  }

  // debug
  Future<void> measureTime(void Function(Duration duration) callback) async {
    final start = DateTime.now();
    final result = await this;
    final end = DateTime.now();
    callback(end.difference(start));
    // return result;
  }

  Future<T> delayBefore(Duration duration) async {
    await Future.delayed(duration);
    return await this;
  }
}

extension FutureHelpers<T,E> on Future<Result<T,E>>{
  Future<void> when({
    FutureOr<void> Function()? onLoading,
    FutureOr<void> Function(T data)? onSuccess,
    FutureOr<void> Function(E error)? onError,
  })async{
    onLoading?.call();
    final result = await this;
    result.when(
            (T data) => onSuccess?.call(data),
            (E error) => onError?.call(error)
    );
  }
}

extension FutureDebouncer<T> on Future<T>{
  static void run({
    Duration? duration,
    required void Function() action
  }){
    EasyDebounce.debounce(
      'debouncer',
      duration?? Duration(milliseconds: 500),
          () => action.call(),
    );
  }
}

// mixin AutoTimerCloser<T extends StatefulWidget> on State<T>, RouteAware {
//
//   final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();
//   final ValueKey timerKey = ValueKey(T);
//
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     routeObserver.subscribe(this, ModalRoute.of(context)! as PageRoute);
//   }
//
//   @override
//   void dispose() {
//     routeObserver.unsubscribe(this);
//     super.dispose();
//   }
//
//   @override
//   void didPopNext() {}
//
//   @override
//   void didPushNext() {
//     // 🔥 Automatically close the timer when navigating away
//     FutureTimer.closeTimer(timerKey);
//   }
//
//   @override
//   void didPop() {
//     // 🔥 Also close it when this screen is popped
//     FutureTimer.closeTimer(timerKey);
//   }
// }
