//
//  AppDelegate.swift
//  APNRichPushNotifications
//
//  Created by Ruchira Bandara on 2024-07-16.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func notificationCenter() {
        let notifications = UNUserNotificationCenter.current()
        notifications.requestAuthorization(options: [.alert,.badge,.sound]) { sucess, error in
            if sucess {
                print("Autherization success")
                notifications.delegate = self
            } else {
                print("Autherization faild")
            }
        }
        
        // Action buttons
        let snooz = UNNotificationAction(identifier: "Snooz", title: "Snooz", options: .foreground)
        let delete = UNNotificationAction(identifier: "Delete", title: "Delete", options: .destructive)
        let category = UNNotificationCategory(identifier: "myNotificationCategory", actions: [snooz,delete], intentIdentifiers: [], options: [])
        
        notifications.setNotificationCategories([category])
    }



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        notificationCenter()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}
extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.sound,.badge,.alert])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        switch response.actionIdentifier {
        case "Snooz" :
            print("Snooz button Tapped")
            
        case "Delete" :
            print("Delete button Tapped")
            
        default:
            break
        }
    }
}

