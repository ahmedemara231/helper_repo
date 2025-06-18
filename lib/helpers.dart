// import 'dart:async';
// import 'dart:io';
// import 'package:flutter/material.dart';
//
// class Helpers{
//   static String get deviceType => Platform.isIOS? "ios" : "android";
//
//   static bool isBlocProvided<T extends StateStreamableSource>(BuildContext context) {
//     try {
//       BlocProvider.of<T>(context, listen: false);
//       return true;
//     } catch (e) {
//       return false;
//     }
//   }
//
//   static Future<void> manageBlocListener(BaseStatus baseStatus, {
//     String? msg,
//     Function? actionWhenSuccess,
//     Function? actionWhenError,
//   }) async{
//     switch(baseStatus){
//       case BaseStatus.success:
//         if(msg != null){
//           MessageUtils.showSimpleToast(msg: msg);
//         }
//         if(actionWhenSuccess != null){
//           await actionWhenSuccess();
//         }
//         break;
//
//       case BaseStatus.error:
//         MessageUtils.showSimpleToast(msg: msg ?? LocaleKeys.thereIsErrorOccurs, color: Colors.red);
//         if(actionWhenError != null){
//           await actionWhenError();
//         }
//         break;
//
//       default:
//         return;
//     }
//   }
// }
//
// class PermissionManagerModel{
//   final List<Permission> permissions;
//   final FutureOr Function(Permission permission)? onGranted;
//   final FutureOr Function(Permission permission)? onDenied;
//
//   PermissionManagerModel({
//     required this.permissions,
//     this.onGranted,
//     this.onDenied
//   });
// }
//
// class PermissionManager{
//   late Permission permission;
//
//   Future<void> checkPermission({
//     required PermissionManagerModel permissionManagerModel,
//     bool openSetting = false
//   }) async {
//     for(Permission permission in permissionManagerModel.permissions){
//       await _checkOnePermission(
//           selectedPermission: permission,
//           onGranted: permissionManagerModel.onGranted,
//           onDenied: permissionManagerModel.onDenied,
//           openSetting: openSetting
//       );
//     }
//   }
//
//   Future<void> _checkOnePermission({
//     required Permission selectedPermission,
//     FutureOr Function(Permission permission)? onGranted,
//     FutureOr Function(Permission permission)? onDenied,
//     bool openSetting = false
//   })async{
//     permission = selectedPermission;
//     await askForPermission(
//       onPermissionGranted: onGranted,
//       onPermissionDenied: onDenied,
//       openSetting: openSetting,
//     );
//   }
//
//   Future<void> askForPermission({
//     FutureOr Function(Permission permission)? onPermissionGranted,
//     FutureOr Function(Permission permission)? onPermissionDenied,
//     bool openSetting = false
//   })async {
//     bool isGranted = await permission.status.isGranted;
//     if(!isGranted) {
//       PermissionStatus status = await permission.request();
//       switch(status) {
//         case PermissionStatus.granted:
//           if(onPermissionGranted != null){
//             onPermissionGranted(permission);
//           }
//
//         default:
//           if(onPermissionDenied != null){
//             onPermissionDenied(permission);
//           }
//
//           if(openSetting){
//             openAppSettings();
//           }
//       }
//     }
//     else {
//       if (onPermissionGranted != null) {
//         onPermissionGranted(permission);
//       }
//     }
//   }
// }