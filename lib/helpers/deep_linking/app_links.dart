import 'dart:async';

import 'package:app_links/app_links.dart';

abstract interface class DeepLinkingService{
  FutureOr<void> init();
  Future<void> handleLinkStates(String? link);
}

class AppLinksImpl implements DeepLinkingService{
  late final AppLinks appLinks;
  final FutureOr<void> Function(Uri link) onOpenLink;
  AppLinksImpl({required this.onOpenLink});

  @override
  FutureOr<void> init()async{
    appLinks = AppLinks();
  }

  @override
  Future<void> handleLinkStates(String? link)async{
    await init();
    final Uri? result = await appLinks.getInitialLink();
    if(result != null){
      onOpenLink(result);
    }
    appLinks.uriLinkStream.listen((event) => onOpenLink(event));
  }
}