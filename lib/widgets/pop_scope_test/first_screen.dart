import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:helper_repo/widgets/base_widgets/text.dart';
import 'package:helper_repo/widgets/pop_scope_test/pop_scope.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
   return Scaffold(
       appBar: AppBar(
         leading: IconButton(onPressed: () {
           NavigationNotification(canHandlePop: true).dispatch(context);
           Navigator.pop(context);
           }, icon: Icon(Icons.arrow_back)),
       ),
       body: TextButton(
         onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => PopScopeScreen())),
         child: AppText('Go to screen 2'),
       )
   );
  }
}
