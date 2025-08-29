import 'dart:developer';

import 'package:easy_timer_count/easy_timer_count.dart';
import 'package:flutter/material.dart';
import 'package:helper_repo/widgets/base_widgets/text.dart';

class TimerTest extends StatelessWidget {
  const TimerTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: EasyTimerCount.builder(
          builder: (time) => AppText(time, fontWeight: FontWeight.bold,),
            // reCountAfterFinishing: true,
            // onTimerRestart: (context, number) => log('message onTimerRestart'),
            duration: const EasyTime(seconds: 0, hours: 1),
            onTimerStarts: (context) => log('message onTimerStarts'),
            onTimerEnds: (context) => log('message onTimerEnds'),
        ),
      ),
    );
  }
}
