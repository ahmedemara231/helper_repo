import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RouteHelper{
  final BuildContext context;
  RouteHelper(this.context){
    _init();
  }

  late final NavigatorState navigator;

  void _init(){
    navigator = Navigator.of(context);

    // navigator.push(route);
    // navigator.pushNamed(routeName);
    // navigator.pushNamedAndRemoveUntil(routeName, predicate);
    // navigator.pushReplacement(route);
    // navigator.pushReplacementNamed(routeName);
  }

  bool get canPop{
    return navigator.canPop();
  }

  void popUntil(bool Function(Route<dynamic>) condition){
    navigator.popUntil(condition);
  }

  void removeRoute(Route<dynamic> route){
    navigator.removeRoute(route);
  }

  void removeRoutesBelow(Route<dynamic> anchorRoute){
    navigator.removeRouteBelow(anchorRoute);
  }

  // RouteHelper.restorable(BuildContext context,  Widget page){
  //   _init();
  // }
  //
  // void restorablePush(){
  //   navigator.restorablePush(routeBuilder);
  // }
}

// Route routeBuilder(BuildContext context, Object? args) {
//   return MaterialPageRoute(builder: (context) => );
// }