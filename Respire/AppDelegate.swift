//
//  AppDelegate.swift
//  Respire
//
//  Created by Alex on 11/25/19.
//  Copyright © 2019 aleksandr.grigorchuk. All rights reserved.
//

import UIKit

/*
We would like to have you complete the following test case so we can evaluate your iOS engineering skills. Please place your code in a public Github repository and commit each step of your process so we can review it.

Your assignment is to create an app that is activated by a predefined number of phases. In the center of the screen, a colored rectangle should be placed. Its appearance and behavior are determined by phases, which are contained in the JSON file, i.e. they are customizable. Each phase has a type, duration and color. By type, you can determine what kind of action the square should perform. For instance:
• inhale — scale up to 100%
• exhale — scale down to 50%
• hold — keep the previous phase scaling

Important note: before the whole breathing cycle starts, the square should be scaled to 75%. Also, in the center of the square, phase type and duration countdown should be displayed. At the bottom of the screen, the remaining label should count down the cumulative duration of all phases.

(https://docs.google.com/document/d/10PdvGlbj1QHuVn_Iqrxr-qkmvtaiQFqxjwvfn84TTI0/edit)
*/

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
