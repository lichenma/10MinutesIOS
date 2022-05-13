//
//  _0MinuteApp.swift
//  10Minute
//
//  Created by Lichen Ma on 2022/5/9.
//

import SwiftUI

@main
struct _10MinuteApp: App {
    @UIApplicationDelegateAdaptor var delegate: AppDelegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate, ObservableObject {
    @Published var minutes = 10
    @Published var seconds = 0
    @Published var streak = 0
    
    @State var timer: Timer? = nil
    
    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
      ) -> UISceneConfiguration {
        let sceneConfig = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
        sceneConfig.delegateClass = SceneDelegate.self // 👈🏻
        return sceneConfig
      }
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        // Publish every second
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (Timer) in
                if self.seconds == 0 && self.minutes>0 {
                    self.seconds = 59
                    self.minutes = self.minutes - 1
                } else {
                    self.seconds = self.seconds - 1
                }
            }
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // reset streak if user leaves before the timer ends
        timer!.invalidate()
        if self.seconds>0 || self.minutes>0 {
            self.streak = 0
        }
        self.minutes = 10
        self.seconds = 0
    }
}

class SceneDelegate: NSObject, UIWindowSceneDelegate, ObservableObject {
    @Published var minutes = 10
    @Published var seconds = 0
    @Published var streak = 0
    
    weak var timer: Timer? = nil
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Publish every second
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (Timer) in
                if self.seconds == 0 && self.minutes>0 {
                    self.seconds = 59
                    self.minutes = self.minutes - 1
                } else if self.minutes != 0 || self.seconds != 0 {
                    self.seconds = self.seconds - 1
                } else {
                    self.streak = self.streak + 1
                }
            }
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // reset streak if user leaves before the timer ends
        if self.seconds>0 || self.minutes>0 {
            self.streak = 0
        }
        self.minutes = 10
        self.seconds = 0
    }

  // ...
}
