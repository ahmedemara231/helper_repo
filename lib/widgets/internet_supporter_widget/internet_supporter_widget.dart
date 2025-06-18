import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'factory.dart';


class InternetSupporterWidget extends StatefulWidget {

  final void Function(InternetConnectionStatus connectionStatus) onChanged;
  final Widget Function(InternetConnectionStatus connectionStatus) builder;
  const InternetSupporterWidget({super.key,
    required this.onChanged,
    required this.builder
  });

  @override
  State<InternetSupporterWidget> createState() => _InternetSupporterWidgetState();
}

class _InternetSupporterWidgetState extends State<InternetSupporterWidget> {

  late InternetCheck internetCheck;
  late InternetConnectionStatus _status;
  @override
  void initState() {
    internetCheck = InternetCheck()..init()
      ..start((connectionStatus) {
        widget.onChanged(connectionStatus);
        setState(() => _status = connectionStatus);
      });
    super.initState();
  }

  @override
  void dispose() {
    internetCheck.stop();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return widget.builder(_status);
  }
}
