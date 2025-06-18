import 'dart:async';

abstract interface class SocketHelper<T>{
  final String url;
  T Function(Map<String, dynamic> jsonMessage) jsonToChatMessage;
  SocketHelper({required this.url, required this.jsonToChatMessage});

  FutureOr<void> connect();
  FutureOr<void> disconnect();
  // ChatMessages jsonToChatMessage(Map<String, dynamic> jsonMessage) => ChatMessages.initial();
  Stream<T> onReceiveMessage(); // should make json parsing here to chat message
}

class PusherImpl<T> extends SocketHelper<T>{
  PusherImpl({required super.url, required super.jsonToChatMessage});
  @override
  FutureOr<void> connect() {
    // TODO: implement connect
    throw UnimplementedError();
  }

  @override
  FutureOr<void> disconnect() {
    // TODO: implement disconnect
    throw UnimplementedError();
  }

  @override
  Stream<T> onReceiveMessage() {
    // TODO: implement onReceiveMessage
    throw UnimplementedError();
  }

}

class SignalRImpl<T> extends SocketHelper<T>{
  SignalRImpl({required super.url, required super.jsonToChatMessage});

  @override
  FutureOr<void> connect() {
    // TODO: implement connect
    throw UnimplementedError();
  }

  @override
  FutureOr<void> disconnect() {
    // TODO: implement disconnect
    throw UnimplementedError();
  }

  @override
  Stream<T> onReceiveMessage() {
    // TODO: implement onReceiveMessage
    throw UnimplementedError();
  }
}

class ClientIOImpl<T> extends SocketHelper<T>{
  ClientIOImpl({required super.url, required super.jsonToChatMessage});

  @override
  FutureOr<void> connect() {
    // TODO: implement connect
    throw UnimplementedError();
  }

  @override
  FutureOr<void> disconnect() {
    // TODO: implement disconnect
    throw UnimplementedError();
  }

  @override
  Stream<T> onReceiveMessage() {
    // TODO: implement onReceiveMessage
    throw UnimplementedError();
  }
}
