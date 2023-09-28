//
//  AppDelegate.swift
//  GoogleMapTesting
//
//  Created by  Rath! on 18/9/23.
//

import UIKit
import GoogleMaps // 1 Step

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
 // 2 Step
        GMSServices.provideAPIKey("AIzaSyDEdXA-BOVHg69bFTRLSS6x1DBkJcQH5y4")

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {

        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
}

