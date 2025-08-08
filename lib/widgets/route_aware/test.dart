import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:helper_repo/widgets/easy_pagination.dart';
import 'package:helper_repo/widgets/route_aware/route_aware.dart';
import 'package:helper_repo/widgets/text.dart';

class RoureAwareTest extends StatelessWidget {
  const RoureAwareTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: NavigationAwareWidget(
          onNavigatedTo: () => log('onNavigatedTo'),
          onPoppedTo: () => log('onPoppedTo'),
          onNavigatedFrom: () => log('onNavigatedFrom'),
          onPoppedFrom: () => log('onPoppedFrom'),
          child: InkWell(
            onTap: () => Navigator.push(context,
                MaterialPageRoute(
                    builder: (context) => EasyPaginationTest()
                )
            ),
              child: Center(child: AppText('text', fontSize: 100,)))
      ),
    );
  }
}
