import 'package:flutter/material.dart';

class SmartModalRoute<T> extends ModalRoute<T> {
  final WidgetBuilder builder;

  SmartModalRoute({
    required this.builder,
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

    print('🚀 [SmartRoute] didChangeNext() triggered!');
    print('   → Previous next route: ${_currentNextRoute?.settings.name}');
    print('   → New next route: ${nextRoute?.settings.name}');

    if (nextRoute == null) {
      print('   ✅ This route is now the TOP route (no route above)');
      _onBecameTopRoute();
    } else {
      print('   📱 Another route was pushed above this one');
      _onCoveredByRoute(nextRoute);
    }

    _currentNextRoute = nextRoute;
  }

  Route<dynamic>? _currentNextRoute;

  void _onBecameTopRoute() {
    // Professional actions when route becomes visible
    print('   🔥 Resuming background processes...');
    print('   🔥 Refreshing data...');
    print('   🔥 Re-enabling animations...');
  }

  void _onCoveredByRoute(Route<dynamic> coveringRoute) {
    // Professional actions when route is covered
    print('   💤 Pausing background processes...');
    print('   💤 Reducing resource usage...');
    print('   💤 Covered by: ${coveringRoute.settings.name}');
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