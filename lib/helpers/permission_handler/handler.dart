import 'dart:async';
import 'package:permission_handler/permission_handler.dart';
import 'model.dart';

class PermissionManager{
  late Permission permission;

  Future<void> checkPermission({
    required PermissionManagerModel permissionManagerModel,
    bool openSetting = false
  }) async {
    for(Permission permission in permissionManagerModel.permissions){
      await _checkOnePermission(
          selectedPermission: permission,
          onGranted: permissionManagerModel.onGranted,
          onDenied: permissionManagerModel.onDenied,
          openSetting: openSetting
      );
    }
  }

  Future<void> _checkOnePermission({
    required Permission selectedPermission,
    FutureOr<void> Function(Permission permission)? onGranted,
    FutureOr<void> Function(Permission permission)? onDenied,
    bool openSetting = false
  })async{
    permission = selectedPermission;
    await _askForPermission(
      onPermissionGranted: onGranted,
      onPermissionDenied: onDenied,
      openSetting: openSetting,
    );
  }

  Future<void> _askForPermission({
    FutureOr<void> Function(Permission permission)? onPermissionGranted,
    FutureOr<void> Function(Permission permission)? onPermissionDenied,
    bool openSetting = false
  })async {
    bool isGranted = await permission.status.isGranted;
    if(!isGranted) {
      PermissionStatus status = await permission.request();
      switch(status) {
        case PermissionStatus.granted:
            onPermissionGranted?.call(permission);

        default:
          onPermissionDenied?.call(permission);

          if(openSetting){
            openAppSettings();
          }
      }
    }else{
      onPermissionGranted?.call(permission);
    }
  }
}