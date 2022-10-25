#import "TikiSdkFlutterPlugin.h"
#if __has_include(<tiki_sdk_flutter_plugin/tiki_sdk_flutter_plugin-Swift.h>)
#import <tiki_sdk_flutter_plugin/tiki_sdk_flutter_plugin-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "tiki_sdk_flutter_plugin-Swift.h"
#endif

#import <tiki_sdk_flutter_plugin/TikiSdkFlutterPlugin.h>
@implementation TikiSdkFlutterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [TikiSdkFlutterPlugin registerWithRegistrar:registrar];
}
@end
