import 'dart:async';
import 'package:flutter/material.dart';
import 'factory.dart';

class SocketWidget<T> extends StatefulWidget {
  final SocketHelper socketType;
  final FutureOr<void> Function(BuildContext context)? onConnect;
  final FutureOr<void> Function(BuildContext context)? onDisconnect;
  final Widget Function(BuildContext context, AsyncSnapshot<T> snapshot) builder;

  const SocketWidget({super.key,
    required this.socketType,
    required this.builder,
    this.onConnect,
    this.onDisconnect
  });

  @override
  State<SocketWidget<T>> createState() => _SocketWidgetState<T>();
}

class _SocketWidgetState<T> extends State<SocketWidget<T>> {

  Future<void> _startServerConnection()async{
    widget.socketType.connect();
    if(widget.onConnect != null) {
      widget.onConnect!(context);
    }
  }

  Future<void> _stopServerConnection()async{
    widget.socketType.disconnect();
    if(widget.onDisconnect != null) {
      widget.onDisconnect!(context);
    }
  }
  @override
  void initState() {
    _startServerConnection();
    super.initState();
  }

  @override
  void dispose() {
    _stopServerConnection();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      stream: widget.socketType.onReceiveMessage() as Stream<T>,
      builder: widget.builder,
    );
  }
}