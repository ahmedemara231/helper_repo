import 'package:flutter/material.dart';
import 'package:helper_repo/widgets/pop_scope_test/first_screen.dart';

import '../base_widgets/text.dart';

class ZeroScreen extends StatelessWidget {
  const ZeroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: TextButton(
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => FirstScreen())),
          child: AppText('Go to screen 1'),
        )
    );
  }
}
