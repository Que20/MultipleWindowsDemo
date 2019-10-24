//
//  AppDelegate.swift
//  MultipleWindowsDemo
//
//  Created by Kévin MAAREK on 24/10/2019.
//  Copyright © 2019 Kévin MAAREK. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if #available(iOS 13.0, *) { } else {
            self.setInitialNavigationController()
        }
        return true
    }
    
    private func setInitialNavigationController() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let mainViewController = ListViewController()
        let mainNavigationController = UINavigationController(rootViewController: mainViewController)
        self.window!.rootViewController = mainNavigationController
        self.window!.makeKeyAndVisible()
    }
}

