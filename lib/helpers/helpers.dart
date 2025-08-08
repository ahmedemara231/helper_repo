import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum BaseStatus {
  initial,

  loading,

  success,

  error,
}

extension BasseStatusExt on BaseStatus {
  bool get isInitial => this == BaseStatus.initial;

  bool get isLoading => this == BaseStatus.loading;

  bool get isSuccess => this == BaseStatus.success;

  bool get isError => this == BaseStatus.error;

  T when<T>({
    T Function()? onInitial,
    required T Function() onSuccess,
    required T Function() onLoading,
    required T Function() onError,
  }) {
    switch (this) {
      case BaseStatus.initial:
        return onInitial?.call() ?? onLoading();
      case BaseStatus.loading:
        return onLoading();
      case BaseStatus.success:
        return onSuccess();
      case BaseStatus.error:
        return onError();
    }
  }
}


class Helpers{

  // static void navigateWithCubit<T extends Cubit>(BuildContext context, {required Widget page}){
  //   Go.to(
  //       BlocProvider.value(
  //         value: context.read<T>(),
  //         child: page,
  //       )
  //   );
  // }
  static Future<void> manageBlocListener(BaseStatus baseStatus, {
    String? msg,
    FutureOr<void> Function()? actionWhenSuccess,
    FutureOr<void> Function()? actionWhenError,
    FutureOr<void> Function()? actionWhenLoading,
  }) async{
    switch(baseStatus){
      case BaseStatus.loading:
        await actionWhenLoading?.call();

      case BaseStatus.success:
        await actionWhenSuccess?.call();
        if(msg != null){
          // MessageUtils.showSimpleToast(msg: msg, color: AppColors.primary);
        }
        break;

      case BaseStatus.error:
        await actionWhenError?.call();
        if(msg != null){
          // MessageUtils.showSimpleToast(msg: msg, color: Colors.red);
        }
        break;

      default:
        return;
    }
  }


  static String get deviceType => Platform.isIOS? "ios" : "android";

  static bool isBlocProvided<T extends StateStreamableSource>(BuildContext context) {
    try {
      BlocProvider.of<T>(context, listen: false);
      return true;
    } catch (e) {
      return false;
    }
  }
}