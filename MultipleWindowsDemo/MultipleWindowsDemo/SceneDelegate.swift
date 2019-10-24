//
//  SceneDelegate.swift
//  MultipleWindowsDemo
//
//  Created by Kévin MAAREK on 24/10/2019.
//  Copyright © 2019 Kévin MAAREK. All rights reserved.
//

import UIKit

enum MyActivityType: String {
    case restaurant
}

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        if let userActivity = connectionOptions.userActivities.first ?? session.stateRestorationActivity {
            // User request new window with userActivity
            switch MyActivityType(rawValue: userActivity.activityType) {
            case .restaurant:
                self.present(viewController: DetailViewController(userActivity: userActivity), scene: scene)
            case .none:
                self.present(viewController: ListViewController(), scene: scene)
            }
        } else {
            // This is an initial app launch
            self.present(viewController: ListViewController(), scene: scene)
            // You don't need an else case if you have a main storyboard
        }
    }

    private func present(viewController: UIViewController, scene: UIScene) {
        if let windowScene = scene as? UIWindowScene {
            self.window = UIWindow(windowScene: windowScene)
            let mainNavigationController = UINavigationController(rootViewController: viewController)
            self.window!.rootViewController = mainNavigationController
            self.window!.makeKeyAndVisible()
        }
    }
}

