//
//  AppDelegate.swift
//  devicecontrol-ios
//
//  Created by Joel Frazier on 8/27/19.
//  Copyright © 2019 Spoohapps, Inc. All rights reserved.
//

import UIKit
import SideMenu

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let profileLoginListRepo = UserDefaultsRepository<ProfileLoginList>(userDefaults: UserDefaults.standard)
        
        let profileLoginRepo = UserDefaultsRepository<ProfileLogin>(userDefaults: UserDefaults.standard)
        
        if let profileLogins = profileLoginListRepo.get(key: "profileLogins") {
            
            print("using saved profile login list")
            
            if let profileLogin = profileLoginRepo.get(key: profileLogins.values[0]) {
                
                print("using saved profile login")
                
                let initialViewController = MainViewController(profileLogin: profileLogin)
                
                window!.rootViewController = initialViewController
                window!.makeKeyAndVisible()

            } else {
                
                addProfile(profileLoginRepo: profileLoginRepo, profileLoginListRepo: profileLoginListRepo)

            }
            
        } else {
            
            addProfile(profileLoginRepo: profileLoginRepo, profileLoginListRepo: profileLoginListRepo)
            
        }

        return true
    }
    
    private func addProfile(profileLoginRepo: Repository<ProfileLogin>, profileLoginListRepo: Repository<ProfileLoginList>) {
        
        let profile = Profile(id: "4b2ca81a", name: "Hammersmith")
        
        let user = User(id: "636c40759a101670757916964000050a", firstName: "Joel", lastName: "Frazier", email: "frazieje@gmail.com", permissions: nil)
        
        let userLogin = UserLogin(tokenKey: "q4Msvn5yra9sFNqWrzf7P5v5mH0c1qj0q2RaNKIE1QGCvYzYhnhMfQy8ZUVPa6FHidxreuaVaN0LnNR2Rlce9w", refreshToken: "lVfTwNXdml3JD8FN1PT7T7B4XkZ7ZX0wlA03SzX0dYP0dodgq4hWJIlwqJXrZ1HSn9sYzwaoO_OoN-g1FfU91g", user: user)
        
        let profileLogin = ProfileLogin(profile: profile, userLogin: userLogin)
        
        if profileLoginRepo.put(key: profileLogin.profile.id, value: profileLogin) {
            
            print("saved user login")
            
        } else {
            
            print("error saving user login")
            
        }
        
        let profileLogins = ProfileLoginList(values: [profileLogin.profile.id])

        if profileLoginListRepo.put(key: "profileLogins", value: profileLogins) {
        
            print("saved user login in profiles list")
            
        } else {
            
            print("error saving user login in profiles list")
            
        }
        
        let deviceApi = AlamofireDeviceApi()
        
        let profileRepositoryFactory = ProfileRepositoryFactory(userDefaults: UserDefaults.standard)
        
        let deviceService = ProfileDeviceService(deviceApi: deviceApi, repositoryFactory: profileRepositoryFactory)
        
        let deviceViewMapper = ProfileDeviceMapper()
        
        let devicesPresenter = ProfileDevicesPresenter(deviceService: deviceService, deviceMapper: deviceViewMapper)
        
        let devicesViewController = DevicesViewController(presenter: devicesPresenter)
        
        
        let initialViewController = MainViewController(devicesViewController: devicesViewController)
        
        window!.rootViewController = initialViewController
        window!.makeKeyAndVisible()
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

