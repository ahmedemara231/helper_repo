import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:helper_repo/widgets/internet_supporter_widget/internet_supporter_widget.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class InternetSupporterTest extends StatelessWidget {
  const InternetSupporterTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InternetSupporterWidget(
          onChanged: (connectionStatus) => log('the status is changed $connectionStatus'),
          builder: (connectionStatus) => Center(
            child: connectionStatus == InternetConnectionStatus.connected ?
            const Text('connected') : const Text('disconnected'),
          ),
      ),
    );
  }
}
