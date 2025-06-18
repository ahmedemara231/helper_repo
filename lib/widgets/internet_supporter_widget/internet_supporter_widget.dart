import 'dart:async';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'factory.dart';

class InternetSupporterWidget extends StatefulWidget {

  final FutureOr<void> Function(InternetConnectionStatus connectionStatus) onChanged;
  final Widget Function(InternetConnectionStatus connectionStatus) builder;
  final Widget Function(InternetConnectionStatus connectionStatus)? onInitialStatusBuilder;

  const InternetSupporterWidget({super.key,
    required this.onChanged,
    required this.builder,
    this.onInitialStatusBuilder,
  });

  @override
  State<InternetSupporterWidget> createState() => _InternetSupporterWidgetState();
}

class _InternetSupporterWidgetState extends State<InternetSupporterWidget> {

  late InternetCheck internetCheck;

  bool _loading = false;
  Future<void> _getInitialStatus()async{
    setState(() => _loading = true);
    await internetCheck.getInitialStatus();
    setState(() => _loading = false);
  }

  Future<void> _init()async{
    internetCheck = InternetCheck()..init();
    await _getInitialStatus();
    internetCheck.start((connectionStatus) =>
        setState(() {
          flag = 1;
          widget.onChanged(connectionStatus);
          internetCheck.status = connectionStatus;
        })
    );
  }

  @override
  void initState() {
    _init();
    super.initState();
  }

  Widget get _buildInitialView{
    if(widget.onInitialStatusBuilder != null){
      return widget.onInitialStatusBuilder!(internetCheck.status);
    }
    return widget.builder(internetCheck.status);
  }

  int flag = 0;
  Widget get _buildStatusView{
    if(flag == 0){
      return _buildInitialView;
    }else{
      return widget.builder(internetCheck.status);
    }
  }

  @override
  void dispose() {
    internetCheck.stop();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return _loading? Center(child: const CircularProgressIndicator()) :
    _buildStatusView;
  }
}
