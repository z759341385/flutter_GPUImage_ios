#import "FlutterGpuimagePlugin.h"
#if __has_include(<flutter_gpuimage/flutter_gpuimage-Swift.h>)
#import <flutter_gpuimage/flutter_gpuimage-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_gpuimage-Swift.h"
#endif

@implementation FlutterGpuimagePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterGpuimagePlugin registerWithRegistrar:registrar];
}
@end
