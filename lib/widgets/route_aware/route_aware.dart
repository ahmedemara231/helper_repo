import 'package:flutter/material.dart';
import 'package:helper_repo/widgets/route_aware/route_observer.dart';

// Use Flutter's built-in RouteObserver
// material/cupertino/Popup page route extends ModalRoute extends route
// RouteObserver<R extends Route<dynamic>> extends NavigatorObserver

// class AppRouteObserver {
//   static final RouteObserver<ModalRoute<void>> _instance = RouteObserver<ModalRoute<dynamic>>();
//   static RouteObserver<ModalRoute<void>> get instance => _instance;
// }

class NavigationAwareWidget extends StatefulWidget {
  final Widget child;
  final VoidCallback? onNavigatedTo;
  final VoidCallback? onNavigatedFrom;
  final VoidCallback? onPoppedTo;
  final VoidCallback? onPoppedFrom;

  const NavigationAwareWidget({
    super.key,
    required this.child,
    this.onNavigatedTo,
    this.onNavigatedFrom,
    this.onPoppedTo,
    this.onPoppedFrom,
  });

  @override
  State<NavigationAwareWidget> createState() => _NavigationAwareWidgetState();
}

class _NavigationAwareWidgetState extends State<NavigationAwareWidget>
    with RouteAware {

  final observer = AppNavigationObserver.instance;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Subscribe to route changes using Flutter's built-in RouteObserver
    final route = ModalRoute.of(context);
    if (route != null) {
      observer.subscribe(this, route);
    }
  }

  @override
  void dispose() {
    observer.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPush() {
    // Called when this screen is first pushed
    widget.onNavigatedTo?.call();
  }


  @override
  void didPopNext() {
    // Called when we return to this screen from another screen
    widget.onPoppedTo?.call();
  }

  @override
  void didPushNext() {
    // Called when we navigate from this screen to another
    widget.onNavigatedFrom?.call();
  }

  @override
  void didPop() {
    // Called when this screen is popped
    widget.onPoppedFrom?.call();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}