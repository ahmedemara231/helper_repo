import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'model.dart';

class PermissionHandler{
  late Permission permission;

  Future<void> checkPermission({
    required PermissionModel permissionManagerModel,
    bool openSetting = false
  }) async {
    for(Permission permission in permissionManagerModel.permissions){
      await _checkOnePermission(
          selectedPermission: permission,
          onGranted: permissionManagerModel.onGranted,
          onDenied: permissionManagerModel.onDenied,
          onPermissionDeniedForever: permissionManagerModel.onDeniedForever,
          onPermissionLimited: permissionManagerModel.onPermissionLimited,
          openSetting: openSetting
      );
    }
  }

  Future<void> _checkOnePermission({
    required Permission selectedPermission,
    FutureOr<void> Function(Permission permission)? onGranted,
    FutureOr<void> Function(Permission permission)? onDenied,
    FutureOr<void> Function(Permission permission)? onPermissionDeniedForever,
    FutureOr<void> Function(Permission permission)? onPermissionLimited,
    bool openSetting = false
  })async{
    permission = selectedPermission;

    await _askForPermission(
      onPermissionGranted: onGranted,
      onPermissionDenied: onDenied,
      onPermissionDeniedForever: onPermissionDeniedForever,
      onPermissionLimited: onPermissionLimited,
      openSetting: openSetting,
    );
  }

  Future<void> _askForPermission({
    FutureOr<void> Function(Permission permission)? onPermissionGranted,
    FutureOr<void> Function(Permission permission)? onPermissionDenied,
    FutureOr<void> Function(Permission permission)? onPermissionDeniedForever,
    FutureOr<void> Function(Permission permission)? onPermissionLimited,
    bool openSetting = false
  })async {
    PermissionStatus permissionStatus = await permission.status;
    if(permissionStatus != PermissionStatus.granted) {
      PermissionStatus status = await permission.request();
      switch(status) {
        case PermissionStatus.granted:
          await onPermissionGranted?.call(permission);
          break;

        case PermissionStatus.denied:
          await onPermissionDenied?.call(permission);
          break;

        case PermissionStatus.permanentlyDenied:
          await onPermissionDeniedForever?.call(permission);
          if(openSetting){
            await openAppSettings();
          }
          break;

        case PermissionStatus.limited:
          await onPermissionLimited?.call(permission);
          break;

        default:
          return;
      }
    }else{
      await onPermissionGranted?.call(permission);
    }
  }
}