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

  late final NavigatorState _navigator;

  void _init(){
    _navigator = Navigator.of(context);
  }

  BuildContext get getContext => _navigator.context;
  bool get canPop => _navigator.canPop();

  void popUntil(bool Function(Route<dynamic>) condition) => _navigator.popUntil(condition);

  void removeRoute(Route<dynamic> route) => _navigator.removeRoute(route);

  void removeRoutesBelow(Route<dynamic> anchorRoute) => _navigator.removeRouteBelow(anchorRoute);

  RouteSettings? getSettingForRoute<T>() => ModalRoute.of<T>(context)?.settings;

  bool get isCurrent => ModalRoute.of(context)?.isCurrent?? false;

  bool get isFirst => ModalRoute.of(context)?.isFirst?? false;

  BuildContext? get subtreeContext => ModalRoute.of(context)?.subtreeContext;


  void restorablePush(Widget page){
    RestorableScreen.setPage = page;
    _navigator.restorablePush(routeBuilder);
  }
}

Route routeBuilder(BuildContext context, Object? args) {
  return MaterialPageRoute(
      builder: (context) => RestorableScreen.getPage
  );
}