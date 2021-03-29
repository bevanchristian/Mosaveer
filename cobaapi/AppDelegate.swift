//
//  AppDelegate.swift
//  cobaapi
//
//  Created by bevan christian on 26/03/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

   /* var window: UIWindow?
    var firstTabNavigationController : UINavigationController!
    var secondTabNavigationControoller : UINavigationController!*/

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
       /* window = UIWindow(frame: UIScreen.main.bounds)
               
               
               window?.backgroundColor = UIColor.black
                   
               
               let tabBarController = UITabBarController()
               
               firstTabNavigationController = UINavigationController.init(rootViewController: ViewController())
               secondTabNavigationControoller = UINavigationController.init(rootViewController: MapViewController())
              
               
               tabBarController.viewControllers = [firstTabNavigationController, secondTabNavigationControoller]

               
               
               let item1 = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)
                let item2 = UITabBarItem(tabBarSystemItem: .downloads, tag: 2)
        
        
              
               firstTabNavigationController.tabBarItem = item1
               secondTabNavigationControoller.tabBarItem = item2
               
               UITabBar.appearance().tintColor = UIColor(red: 0/255.0, green: 146/255.0, blue: 248/255.0, alpha: 1.0)
               
               self.window?.rootViewController = tabBarController
               
               window?.makeKeyAndVisible()*/

       /* let tabbar = UITabBarController()
        
        let food = ui
        let map = MapViewController()
        tabbar.setViewControllers([food,map], animated: false)*/
    
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

