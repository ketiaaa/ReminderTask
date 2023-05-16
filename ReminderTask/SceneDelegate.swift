//
//  SceneDelegate.swift
//  ReminderTask
//
//  Created by ketia  on 16/5/2023.
//

import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var taskManager = TaskManager()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }

        let window = UIWindow(windowScene: windowScene)
        
        window.rootViewController = UIHostingController(rootView: ContentView().environmentObject(taskManager))
        
        self.window = window
        window.makeKeyAndVisible()
    }
}
