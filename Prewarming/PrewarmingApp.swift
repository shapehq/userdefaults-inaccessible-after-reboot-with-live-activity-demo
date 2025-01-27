//
//  PrewarmingApp.swift
//  Prewarming
//
//  Created by Jonatan Nielavitzky on 09/09/2024.
//

import SwiftUI

@main
struct PrewarmingApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    static var didFinishLaunchingWithOptionsCalledAt: String = ""
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Self.didFinishLaunchingWithOptionsCalledAt = Date.now.timestamp
        return true
    }
}
