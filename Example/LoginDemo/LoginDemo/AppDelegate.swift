//
//  AppDelegate.swift
//  LoginDemo
//
//  Created by dasdom on 13.05.16.
//  Copyright © 2016 dasdom. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow? = UIWindow(frame: UIScreen.mainScreen().bounds)

  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    
    window?.rootViewController = LoginViewController()
    window?.makeKeyAndVisible()
    
    return true
  }
}

