import 'package:flutter/material.dart';

class RouteHelper{
  final BuildContext context;
  RouteHelper(this.context){
    _init();
  }

  late final NavigatorState? _navigator;

  void _init(){
    _navigator ??= Navigator.of(context);
  }

  // BuildContext get getContext => _navigator!.context;

  // ------------------------------------ Navigator level ------------------------------------
  void popUntil(bool Function(Route<dynamic>) condition) => _navigator!.popUntil(condition);

  void popToFirst() => popUntil((r) => r.isFirst);

  void removeRoute(Route<dynamic> route) => _navigator!.removeRoute(route);

  void removeRoutesBelow(Route<dynamic> anchorRoute) => _navigator!.removeRouteBelow(anchorRoute);

  // ------------------------------------ current route ------------------------------------
  RouteSettings? getSettingForRoute<T>() => ModalRoute.of<T>(context)?.settings;
  bool get canPop => ModalRoute.of(context)?.canPop?? false;

  bool get isCurrent => ModalRoute.of(context)?.isCurrent?? false;

  bool get isFirst => ModalRoute.of(context)?.isFirst?? false;

  BuildContext? get subtreeContext => ModalRoute.of(context)?.subtreeContext;


 // ------------------------------------ restorable ------------------------------------
  void _storePage(Widget page){
    RestorableScreen.setPage = page;
  }

  void restorablePush(Widget page){
    _storePage(page);
    _navigator!.restorablePush(routeBuilder);
  }

  void restorablePushAndRemoveUntil(Widget page){
    _storePage(page);
    _navigator!.restorablePushAndRemoveUntil(routeBuilder, (val) => false);
  }
  void restorablePushReplacement(Widget page){
    _storePage(page);
    _navigator!.restorablePushReplacement(routeBuilder);
  }
}

class RestorableScreen{
  static late Widget _page;
  static Widget get getPage => _page;
  static set setPage(Widget page) => _page = page;
}

Route routeBuilder(BuildContext context, Object? args) {
  return MaterialPageRoute(
      builder: (context) => RestorableScreen.getPage
  );
}