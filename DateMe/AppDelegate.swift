//
//  AppDelegate.swift
//  DateMe
//
//  Created by Sterling Mortensen on 5/10/17.
//  Copyright © 2017 Sterling Mortensen. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        return true
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
         return FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {

    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {

    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {

    }
    
    func applicationWillTerminate(_ application: UIApplication) {

    }
}

