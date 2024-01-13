#import "MapboxMapsPlugin.h"
#import <mapbox_gl_flutterflow/mapbox_gl_flutterflow-Swift.h>

@implementation MapboxMapsPlugin 
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftMapboxGlFlutterPlugin registerWithRegistrar:registrar];
}
@end
