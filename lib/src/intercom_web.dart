import 'package:flutter/services.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'intercom_web_interop.dart';

class IntercomWeb {
  static void registerWith(Registrar registrar) {
    final MethodChannel methodChannel = MethodChannel(
      'maido.io/intercom',
      const StandardMethodCodec(),
      registrar,
    );
    final instance = IntercomWeb();
    methodChannel.setMethodCallHandler(instance.handleMethodCall);
  }

  String _appID;

    String get getAppID=> _appID;

   Future<dynamic> handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'displayMessenger':
        return intercom("show");
      case 'logout':
        return intercom("shutdown");
      case 'initialize':
        return intercom("boot",BootOptions(app_id: call.arguments["appId"]));
      case 'registerIdentifiedUserWithUserId':
        return setUpRegisteredUser(userId:  call.arguments["userId"]);
      case 'registerIdentifiedUserWithEmail':
        return setUpRegisteredUser(email: call.arguments["email"]);
      case 'update':
        return intercom(call.method);
      case 'hideMessenger':
        return intercom("hide");
      case 'showMessages':
        return intercom(call.method);
      case 'showNewMessage':
        return intercom(call.method);
      case 'boot':
        final options = call.arguments['options'];
        return intercom(call.method,options);
      default:
        throw PlatformException(
          code: 'Unimplemented',
            details: "The intercom plugin for web doesn't implement the method '${call.method}'",
        );
    }
  }


  Future setUpRegisteredUser({String email, String userId})=> intercom("boot",BootOptions(app_id: _appID,user_id: userId,email: email));
}
