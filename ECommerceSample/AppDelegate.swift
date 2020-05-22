//
//  AppDelegate.swift
//  ECommerceSample
//
//  Created by Pratik on 18/05/20.
//  Copyright © 2020 Pratik. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let path = NSSearchPathForDirectoriesInDomains(.applicationSupportDirectory,
                                                .userDomainMask, true)
        print("Core data path - \(path)")

        return true
    }

}

