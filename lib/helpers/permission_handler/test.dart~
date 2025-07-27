import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:helper_repo/helpers/permission_handler/handler.dart';
import 'package:helper_repo/helpers/permission_handler/model.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionTest extends StatefulWidget {
  const PermissionTest({super.key});

  @override
  State<PermissionTest> createState() => _PermissionTestState();
}

class _PermissionTestState extends State<PermissionTest> {
  void _checkPermissions(){
    PermissionManager().checkPermission(
        permissionManagerModel: PermissionManagerModel(
          permissions: [Permission.storage, Permission.camera],
          onGranted: (permission) => log('the permission $permission is granted'),
          onDenied: (permission) => log('the permission $permission is denied'),
        )
    );
  }

  @override
  void initState() {
    _checkPermissions();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Permission test'),
      ),
    );
  }
}
