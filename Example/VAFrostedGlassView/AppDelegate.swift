//
//  AppDelegate.swift
//  VAFrostedGlassView
//
//  Created by Volodymyr Andriienko on 04/10/2024.
//  Copyright (c) 2024 Volodymyr Andriienko. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        window = UIWindow()
        window?.rootViewController = BaseViewController<ExampleView>()
        window?.makeKeyAndVisible()
        
        return true
    }
}
