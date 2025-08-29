import 'dart:async';

import 'package:multiple_result/multiple_result.dart';

extension FutureTimer<T> on Future<T>{
  void openTimer({Duration? executeOver, required FutureOr<void> Function(int seconds) onTimerChanged}){
    Timer.periodic(executeOver?? const Duration(seconds: 1), (time){
      onTimerChanged.call(time.tick);
    });
  }

  Future<T> measureTime(void Function(Duration duration) callback) async {
    final start = DateTime.now();
    final result = await this;
    final end = DateTime.now();
    callback(end.difference(start));
    return result;
  }

  Future<T> delayBefore(Duration duration) async {
    await Future.delayed(duration);
    return await this;
  }

  // Future<void> retry({
  //   required int triesNumber,
  //   FutureOr<void> Function(int failTryIndex, Exception e)? onFail,
  //   FutureOr<void> Function(Exception e)? onFinallyFail,
  // })async{
  //   int numberOfTries = 0;
  //   for(int i = 0; i < triesNumber; i++){
  //     try {
  //       numberOfTries ++;
  //       await this;
  //     } on Exception catch (e) {
  //       if(numberOfTries == triesNumber){
  //         onFinallyFail?.call(e);
  //
  //       }else{
  //         await onFail?.call(numberOfTries, e);
  //       }
  //     }
  //   }
  // }

}

extension FutureHelpers<T,E> on Future<Result<T,E>>{
  Future<void> on({
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