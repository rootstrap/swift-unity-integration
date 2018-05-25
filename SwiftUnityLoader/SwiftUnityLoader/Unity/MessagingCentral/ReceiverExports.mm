//
//  ReceiverExports.m
//  SwiftUnityLoader
//
//  Created by German on 5/23/18.
//  Copyright © 2018 Rootstrap Inc. All rights reserved.
//

#import "SwiftUnityLoader-Swift.h"

extern "C" {
  
  //Optional Objective C class to handle messages
  @interface UnityMessageReceiver: NSObject
    + (void)unityAppAnimating:(BOOL) active;
  @end
  
  @implementation UnityMessageReceiver
    + (void)unityAppAnimating:(BOOL) active {
      [NSNotificationCenter.defaultCenter postNotificationName:NSNotification.unityAppAnimateModel object:nil userInfo:@{@"active": @(active)}];
    }
  @end
  
  //Methods exposed to C accessible from Unity
  void appAnimatingModel(bool active) {
    [UnityMessageReceiver unityAppAnimating:active];
    //If not using a bridge class you can define your method implementation directly. i.e:
    //ViewController *vc = (ViewController *)UIApplication.sharedApplication.keyWindow.rootViewController
    //[vc doSomething];
  }
}
