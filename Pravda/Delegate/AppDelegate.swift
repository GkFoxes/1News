//
//  AppDelegate.swift
//  Pravda
//
//  Created by Дмитрий Матвеенко on 04/02/2019.
//  Copyright © 2019 GkFoxes. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Thread.sleep(forTimeInterval: 0.5)
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let splitViewController = mainStoryboard.instantiateViewController(withIdentifier: "MainSplitViewController") as! UISplitViewController
        UIApplication.shared.keyWindow?.rootViewController = splitViewController
        
        let navigationController = splitViewController.viewControllers[splitViewController.viewControllers.count-1] as! UINavigationController
        navigationController.topViewController!.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem
        splitViewController.delegate = self
        
        let tabBarViewController = self.window!.rootViewController as! UITabBarController
        
        for viewController in tabBarViewController.viewControllers! {
            if viewController.title == "Detail" {
                _ = viewController as? UISplitViewController
            }
        }
        
        return true
    }

    // MARK: - Split view

    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController:UIViewController, onto primaryViewController:UIViewController) -> Bool {
        guard let secondaryAsNavController = secondaryViewController as? UINavigationController else { return false }
        guard let topAsDetailController = secondaryAsNavController.topViewController as? NewsDetailViewController else { return false }
        if topAsDetailController.title == "" {
            return true
        }
        return false
    }

}