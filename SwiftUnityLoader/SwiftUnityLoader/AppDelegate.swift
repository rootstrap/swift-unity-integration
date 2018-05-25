//
//  AppDelegate.swift
//  SwiftUnityLoader
//
//  Created by German on 5/21/18.
//  Copyright © 2018 Rootstrap Inc. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  //Needed for Unity
  var application: UIApplication?
  @objc var currentUnityController: UnityAppController!
  var isUnityRunning = false

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions:
    [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    self.application = application
    unity_init(CommandLine.argc, CommandLine.unsafeArgv)

    currentUnityController = UnityAppController()
    currentUnityController.application(application, didFinishLaunchingWithOptions: launchOptions)
    
    // first call to startUnity will do some init stuff, so just call it here and directly stop it again
    startUnity()
    stopUnity()
    
    return true
  }

  func applicationWillResignActive(_ application: UIApplication) {
    if isUnityRunning {
      currentUnityController.applicationWillResignActive(application)
    }
  }

  func applicationDidEnterBackground(_ application: UIApplication) {
    if isUnityRunning {
      currentUnityController.applicationDidEnterBackground(application)
    }
  }

  func applicationDidBecomeActive(_ application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    if isUnityRunning {
      currentUnityController.applicationDidBecomeActive(application)
    }
  }
  
  func applicationWillTerminate(_ application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    if isUnityRunning {
      currentUnityController.applicationWillTerminate(application)
    }
  }
  
  func startUnity() {
    if !isUnityRunning {
      isUnityRunning = true
      currentUnityController.applicationDidBecomeActive(application!)
    }
  }
  
  @objc func stopUnity() {
    if isUnityRunning {
      currentUnityController.applicationWillResignActive(application!)
      isUnityRunning = false
    }
  }
}

