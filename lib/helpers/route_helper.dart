import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RestorableScreen{
  static late Widget _page;
  static Widget get getPage => _page;
  static set setPage(Widget page) => _page = page;
}

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

  void restorablePush(Widget page){
    RestorableScreen.setPage = page;
    navigator.restorablePush(routeBuilder);
  }
}

Route routeBuilder(BuildContext context, Object? args) {
  return MaterialPageRoute(
      builder: (context) => RestorableScreen.getPage
  );
}