import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:helper_repo/extentions/future.dart';
import 'package:helper_repo/widgets/base_widgets/text.dart';
import 'package:helper_repo/widgets/easy_pagination.dart';
import 'package:multiple_result/multiple_result.dart';

class ExtensionsTest extends StatefulWidget {
  const ExtensionsTest({super.key});

  @override
  State<ExtensionsTest> createState() => _ExtensionsTestState();
}

class _ExtensionsTestState extends State<ExtensionsTest> {
  Future<void> _anyNormalFuture()async{
    log('enter');
    // await Future.delayed(const Duration(seconds: 5));
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
    //  _anyMultiResultFuture()..when(
    //   onLoading: () => log('loading'),
    //   onSuccess: (data) => log('onSuccess'),
    //   onError: (error) => log('onError'),
    // )..openTimer(
    //    throwExceptionWhen: Duration(seconds: 100),
    //      onTimeoutException: (e) => log('exceptionnnnn'),
    //      onTimerChanged: (time) => log('message $time'),
    //      key: ValueKey('1')
    //  );

    // _anyNormalFuture().measureTime((duration) => log('duration is ${duration.inSeconds}'));

    FutureDebouncer.run(action: () => _anyNormalFuture());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          TextButton(
              onPressed: () => _test(),
              child: AppText('click')
          ),
          TextButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => PagifyExample())),
              child: AppText('click')
          ),
        ],
      ),
    );
  }
}
