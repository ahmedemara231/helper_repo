import 'package:flutter/material.dart';
import 'package:helper_repo/widgets/base_widgets/text.dart';

class ForthScreen extends StatelessWidget {
  const ForthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: TextButton(
          onPressed: () => Navigator.pop(context),
          child: AppText('pop to screen 3'),
        )
    );
  }
}
