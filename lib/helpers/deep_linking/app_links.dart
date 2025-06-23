import 'dart:async';
import 'dart:developer';

import 'package:app_links/app_links.dart';

abstract interface class DeepLinkingService{
  FutureOr<void> init();
  Future<void> handleLinkStates(FutureOr<void> Function(Uri link) onOpenLink);
  void printLink(Uri link){
    log(link.path.toString());
  }
}

class AppLinksImpl extends DeepLinkingService{
  late final AppLinks appLinks;
  AppLinksImpl();

  @override
  FutureOr<void> init()async{
    appLinks = AppLinks();
  }

  @override
  Future<void> handleLinkStates(FutureOr<void> Function(Uri link) onOpenLink)async{
    await init();
    final Uri? result = await appLinks.getInitialLink();
    if(result != null){
      onOpenLink(result);
      printLink(result);
    }
    appLinks.uriLinkStream.listen((event) {
      onOpenLink(event);
      printLink(event);
    });
  }
}