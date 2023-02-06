//
//  HelpMigaApp.swift
//  HelpMiga
//
//  Created by Ana Letícia Branco on 24/01/23.
//

import SwiftUI
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct HelpMigaApp: App {
    @StateObject var locationViewModel = LocationSearchViewModel()
    @StateObject var authViewModel = AuthViewModel()
    @StateObject var homeViewModel = HomeViewModel() 
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(locationViewModel)
                .environmentObject(homeViewModel)
                .environmentObject(authViewModel)
        }
    }
}
