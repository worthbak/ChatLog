//
//  AppDelegate.swift
//  ChatLog
//
//  Created by David Baker on 3/3/16.
//  Copyright © 2016 Worth Baker. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  var appCoordinator: Coordinator?

  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    
    self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
    
    let navCon = UINavigationController()
    self.appCoordinator = AppCoordinator(withNavigationController: navCon)
    self.appCoordinator?.start()
    
    self.window?.rootViewController = navCon
    self.window?.makeKeyAndVisible()
    
    return true
  }


}

