//
//  AppDelegate.swift
//  Respire
//
//  Created by Alex on 11/25/19.
//  Copyright © 2019 aleksandr.grigorchuk. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let model = CalmDownModel()
        let controller = CalmDownViewController(model: model)
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = controller
        self.window?.makeKeyAndVisible()
        
        return true
    }
}
