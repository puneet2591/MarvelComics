//
//  AppDelegate.swift
//  MarvelComics
//
//  Created by Puneet Mahajan on 14/10/20.
//  Copyright © 2020 Puneet. All rights reserved.
//

import UIKit
import IHProgressHUD

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Initialize root view controller
        if let vc = StoryboardConstant.Main.viewController(type: MarvelHomeViewController.self) {
            let nvc = UINavigationController(rootViewController: vc)
            self.window?.rootViewController = nvc
            self.window?.makeKeyAndVisible()
        }
        
        // configure loader
        IHProgressHUD.set(maximumDismissTimeInterval: TimeInterval(30.0))
        IHProgressHUD.set(backgroundColor: UIColor.black.withAlphaComponent(0.4))
        IHProgressHUD.setHUD(backgroundColor: UIColor.black)
        IHProgressHUD.set(foregroundColor: .white)
        
        return true
    }


}

