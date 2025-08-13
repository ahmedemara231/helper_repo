import 'dart:async';
import 'package:flutter/material.dart';

class SmartModalRoute<T> extends ModalRoute<T> {
  final WidgetBuilder builder;
  final FutureOr<void> Function() onPush;
  // .. etc

  SmartModalRoute({
    required this.builder,
    required this.onPush,
    RouteSettings? settings,
  }) : super(settings: settings);

  @override
  Duration get transitionDuration => Duration(milliseconds: 300);
  @override
  bool get opaque => true;
  @override
  bool get barrierDismissible => false;
  @override
  Color? get barrierColor => null;
  @override
  String? get barrierLabel => null;
  @override
  bool get maintainState => true;

  // ========== THE MAIN EVENT: didChangeNext Override ==========
  @override
  void didChangeNext(Route<dynamic>? nextRoute) {
    super.didChangeNext(nextRoute);
    if (nextRoute == null) {
      print('   ✅ This route is now the TOP route (no route above)');
      _onBecameTopRoute();
    } else {
      print('📱 Another route was pushed above this one');
    }
  }

  @override
  void didChangePrevious(Route? previousRoute) {
    // TODO: implement didChangePrevious
    super.didChangePrevious(previousRoute);
  }


  void _onBecameTopRoute() {
    // Professional actions when route becomes visible
    print('   🔥 Resuming background processes...');
    print('   🔥 Refreshing data...');
    print('   🔥 Re-enabling animations...');
  }

  @override
  void didAdd() {
    // TODO: implement didAdd
    super.didAdd();
  }

  @override
  bool didPop(T? result) {
    // TODO: implement didPop
    return super.didPop(result);
  }

  @override
  TickerFuture didPush() {
    // TODO: implement didPush
    onPush.call();
    return super.didPush();
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return builder(context);
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(opacity: animation, child: child);
  }
}

// class SmartRouteTest extends StatelessWidget {
//   const SmartRouteTest({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: TextButton(
//           onPressed: () => Navigator.push(
//               context,
//               SmartModalRoute(
//                   builder: (context) => ,
//                onPush: () {},
//                 // ... etc
//               )
//           ),
//           child: Text('test')
//       ),
//     );
//   }
// }
