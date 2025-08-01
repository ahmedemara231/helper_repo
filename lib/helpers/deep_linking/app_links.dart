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

/*
Android:
in backend server should be set up : assetlinks.json
- Upload the assetlinks.json file to your website. It must be accessible via https://yourdomain/.well-known/assetlinks.json

You can generate your app's SHA256 fingerprint with this command:
keytool -list -v -keystore <keystore path> -alias <key alias> -storepass <store password> -keypass <key password>

[{
  "relation": ["delegate_permission/common.handle_all_urls"],
  "target": {
    "namespace": "android_app",
    "package_name": "com.example",
    "sha256_cert_fingerprints":
    ["00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00"]
  }
}]

IOS:
Create a new file named apple-app-site-association with no file extension.
{
  "applinks":{
    "apps":[

    ],
    "details":[
      {
        "appIDs":[
          "TeamID.BundleID"
        ],
        "components":[
          {
            "/":"/login",
            "comment":"Matches URL with a path /login"
          },
          {
            "/":"/product/*",
            "comment":"Matches any URL with a path that starts with /product/."
          },
          {
            "/":"/secret",
            "exclude":true,
            "comment":"Matches URL with a path /secret and instructs the system not to open it as a universal link."
          }
        ]
      }
    ]
  }
}

* test deep link on Android
* adb shell am start -a android.intent.action.VIEW \
  -c android.intent.category.BROWSABLE \
  -d https://yourDomain.com \
  <package name>

  test deep link on IOS:
  xcrun simctl openurl booted https://yourDomain.com/path

  * test - client server integration : https://developers.google.com/digital-asset-links/tools/generator
  */
 */