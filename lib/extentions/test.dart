import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:helper_repo/extentions/future.dart';
import 'package:helper_repo/widgets/base_widgets/text.dart';
import 'package:multiple_result/multiple_result.dart';

class ExtensionsTest extends StatelessWidget {
  const ExtensionsTest({super.key});

  Future<void> _anyNormalFuture()async{
    await Future.delayed(const Duration(seconds: 5));
  }

  Future<Result<int, String>> _anyMultiResultFuture()async{
    try {
      await Future.delayed(const Duration(seconds: 5));
      return Result.success(1);

    } on Exception catch (e) {
      return Result.error(e.toString());
    }
  }

  void _test()async{
    // final result = _anyNormalFuture()..openTimer(executeOver: ,onTimerChanged: onTimerChanged);

    // final result = _anyMultiResultFuture()..on(
    //   onLoading: ,
    //   onSuccess: ,
    //   onError: ,
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
