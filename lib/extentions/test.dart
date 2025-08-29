import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:helper_repo/extentions/future.dart';
import 'package:helper_repo/widgets/base_widgets/text.dart';
import 'package:multiple_result/multiple_result.dart';

class ExtensionsTest extends StatelessWidget {
  const ExtensionsTest({super.key});

  Future<void> _anyNormalFuture()async{
    log('enter');
    await Future.delayed(const Duration(seconds: 5));
  }

  Future<Result<int, String>> _anyMultiResultFuture()async{
    try {
      await Future.delayed(const Duration(seconds: 2));
      return Result.success(1);

    } on Exception catch (e) {
      return Result.error(e.toString());
    }
  }

  void _test()async{
    // final result = _anyNormalFuture()..openTimer(executeOver: const Duration(seconds: 2),
    //     onTimerChanged: (time) => log('message'));

    
     _anyMultiResultFuture()..on(
      onLoading: () => log('loading'),
      onSuccess: (data) => log('onSuccess'),
      onError: (error) => log('onError'),
    )..openTimer(executeOver: const Duration(seconds: 2),
         onTimerChanged: (time) => log('message'));

    // final result = _anyNormalFuture().retry(
    //   triesNumber: 3,
    //   onFail: (n, e) => log('$e $n')
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: TextButton(
          onPressed: () => _test(),
          child: AppText('click')
      ),
    );
  }
}
