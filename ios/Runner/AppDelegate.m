#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
@import Firebase; // Kannski eyða þessari línu og laga útgáfur af dependencies?
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [FIRApp configure]; // Kannski eyða þessari línu og laga útgáfur af dependencies?
  [GeneratedPluginRegistrant registerWithRegistry:self];
  // Override point for customization after application launch.
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
