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

  RouteSettings? getSettingForRoute<T>(){
    return ModalRoute.of<T>(context)?.settings;
  }

  bool get isCurrent{
    return ModalRoute.of(context)?.isCurrent?? false;
  }

  bool get isFirst{
    return ModalRoute.of(context)?.isFirst?? false;
  }

  BuildContext? get subtreeContext{
    return ModalRoute.of(context)?.subtreeContext;
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