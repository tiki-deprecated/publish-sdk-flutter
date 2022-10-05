#import "TikiSdkFlutterPlugin.h"
#if __has_include(<tiki_sdk_flutter/tiki_sdk_flutter-Swift.h>)
#import <tiki_sdk_flutter/tiki_sdk_flutter-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "tiki_sdk_flutter-Swift.h"
#endif

@implementation TikiSdkFlutterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftTikiSdkFlutterPlugin registerWithRegistrar:registrar];
}
@end
