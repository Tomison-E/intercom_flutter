@JS()
library intercom;

import "package:js/js.dart";

@JS('Intercom')
external intercom(String method,[BootOptions options]);


@JS()
@anonymous // needed along with factory constructor
class BootOptions {
  external factory BootOptions({ app_id, email, user_id,name});
  external String get app_id;
  external String get email;
  external String get name;
  external String get user_id;
}
