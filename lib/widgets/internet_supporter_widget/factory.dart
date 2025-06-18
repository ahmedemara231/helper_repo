 import 'package:internet_connection_checker/internet_connection_checker.dart';

class InternetCheck{
  late InternetConnectionChecker connectionChecker;
  void init(){
    connectionChecker = InternetConnectionChecker.instance
      ..configure(slowConnectionConfig: SlowConnectionConfig(enableToCheckForSlowConnection: true))
    ..checkTimeout = Duration(seconds: 5);
  }

  void start(Function(InternetConnectionStatus connectionStatus) onChanged)async{
    connectionChecker.onStatusChange.listen(
            (event) => onChanged(event)
    );
  }

  Future<void> stop()async{
    connectionChecker.dispose();
  }

  Future<InternetConnectionStatus> get currentStatus async{
    return await connectionChecker.connectionStatus;
  }
}