import 'package:flutter/material.dart';
import 'package:helper_repo/widgets/base_widgets/text.dart';
import 'package:helper_repo/widgets/pop_scope_test/forth_screen.dart';

class ThirdScreen extends StatelessWidget {
  const ThirdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: AppText('pop to screen 2'),
            ),
            TextButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ForthScreen())),
              child: AppText('Go to screen 4'),
            ),
          ],
        ),
    );
  }
}
