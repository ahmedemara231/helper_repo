import 'dart:async';
import 'package:permission_handler/permission_handler.dart';

class PermissionManagerModel{
  final List<Permission> permissions;
  final FutureOr<void> Function(Permission permission)? onGranted;
  final FutureOr<void> Function(Permission permission)? onDenied;

  PermissionManagerModel({
    required this.permissions,
    this.onGranted,
    this.onDenied
  });
}