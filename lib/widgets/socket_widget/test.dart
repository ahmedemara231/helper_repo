import 'package:flutter/material.dart';
import 'package:helper_repo/widgets/socket_widget/factory.dart';
import 'package:helper_repo/widgets/socket_widget/socket_widget.dart';

class SocketImplementerTest extends StatelessWidget {
  const SocketImplementerTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SocketWidget<String>(
          socketType: SignalRImpl(
              url: 'server url',
              jsonToChatMessage: (jsonMessage) => jsonMessage['']
          ),
          builder: (context, snapshot) => Text(snapshot.requireData),
      ),
    );
  }
}
