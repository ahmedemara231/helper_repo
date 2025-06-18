import 'package:flutter/material.dart';
import 'factory.dart';

class SocketWidget<T> extends StatefulWidget {
  final SocketHelper socket;
  final Widget Function(BuildContext context, AsyncSnapshot<T> snapshot) builder;

  const SocketWidget({super.key,
    required this.socket,
    required this.builder
  });

  @override
  State<SocketWidget<T>> createState() => _SocketWidgetState<T>();
}

class _SocketWidgetState<T> extends State<SocketWidget<T>> {

  @override
  void initState() {
    widget.socket.connect();
    super.initState();
  }

  @override
  void dispose() {
    widget.socket.disconnect();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      stream: widget.socket.onReceiveMessage() as Stream<T>,
      builder: widget.builder,
    );
  }
}

// class SocketTest extends StatelessWidget {
//   const SocketTest({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SocketWidget<String>(
//           socket: SignalRImpl(url: url, jsonToChatMessage: jsonToChatMessage),
//           builder: (context, snapshot) => ,
//       ),
//     );
//   }
// }