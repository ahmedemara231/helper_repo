import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helper_repo/widgets/internet_supporter_widget/internet_supporter_widget.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../route_aware/test.dart';
import '../text.dart';

class InternetSupporterTest extends StatelessWidget {
  const InternetSupporterTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () => Navigator.push(context,
              MaterialPageRoute(
                  builder: (context) => RoureAwareTest()
              )
          ),
          child: InternetInterceptorWidget(
            loadingWidget: CupertinoActivityIndicator(),
            onChanged: (status) => status == InternetConnectionStatus.disconnected,
            builder: (status) => status == InternetConnectionStatus.disconnected?
            AppText('not connected') : AppText('connected'),
            onInitialStatusBuilder: (status) =>  status == InternetConnectionStatus.disconnected?
            AppText(' onInitialStatusBuilder not connected') : AppText(' onInitialStatusBuilder connected'),
          ),
        ),
      )
    );
  }
}
