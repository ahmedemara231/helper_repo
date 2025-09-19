import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:helper_repo/widgets/base_widgets/text.dart';
import 'package:helper_repo/widgets/pop_scope_test/third_screen.dart';

class PopScopeScreen extends StatelessWidget {
  const PopScopeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.arrow_back)),
      ),
      body: PopScope(
        canPop: true,
        onPopInvokedWithResult: (didPop, result) => log('the pop is done!'),
        child: Column(
          children: [
            TextButton(
                onPressed: () => Navigator.pop(context),
              child: AppText('pop to screen 1'),
            ),
            TextButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ThirdScreen())),
              child: AppText('Go to screen 3'),
            ),
          ],
        ),
      )
    );
  }
}
