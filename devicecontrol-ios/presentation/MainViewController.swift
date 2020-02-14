//
//  MainViewController.swift
//  devicecontrol-ios
//
//  Created by Joel Frazier on 9/5/19.
//  Copyright © 2019 Spoohapps, Inc. All rights reserved.
//

import UIKit

import SideMenu

class MainViewController : UITabBarController {
    
    let profileLogin: ProfileLogin
    
    var profileMenuViewController: SideMenuNavigationController?
    
    init(profileLogin: ProfileLogin) {
        self.profileLogin = profileLogin
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        profileMenuViewController = SideMenuNavigationController(rootViewController: ProfileMenuViewController(profileLogin: profileLogin))
        
        SideMenuManager.default.rightMenuNavigationController = profileMenuViewController

        // Setup gestures: the left and/or right menus must be set up (above) for these to work.
        // Note that these continue to work on the Navigation Controller independent of the view controller it displays!
        SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: self.view)
        
        profileMenuViewController!.statusBarEndAlpha = 0
        
        let style: SideMenuPresentationStyle = .menuSlideIn
        
        style.presentingEndAlpha = CGFloat(0.5)
        
        profileMenuViewController!.presentationStyle = style
        profileMenuViewController!.blurEffectStyle = .extraLight
        
        let homeViewController = HomeViewController(profileLogin: profileLogin)
        
        let homeIcon = UIImage.fontAwesomeIcon(icon: "\u{f015}", textColor: .gray, size: CGSize(width: 25.0, height: 25.0))
        
        let homeSelectedIcon = UIImage.fontAwesomeIcon(icon: "\u{f015}", textColor: .blue, size: CGSize(width: 25.0, height: 25.0))
        
        homeViewController.tabBarItem = UITabBarItem(title: "Home", image: homeIcon, selectedImage: homeSelectedIcon)
        
        let devicesViewController = DevicesViewController(presenter: <#T##DevicesPresenter#>)
        
        let devicesIcon = UIImage.fontAwesomeIcon(icon: "\u{f2db}", textColor: .gray, size: CGSize(width: 25.0, height: 25.0))
        
        let devicesSelectedIcon = UIImage.fontAwesomeIcon(icon: "\u{f2db}", textColor: .blue, size: CGSize(width: 25.0, height: 25.0))
        
        devicesViewController.tabBarItem = UITabBarItem(title: "Devices", image: devicesIcon, selectedImage: devicesSelectedIcon)
        
        
        let settingsViewController = SettingsViewController(profileLogin: profileLogin)
        
        let settingsIcon = UIImage.fontAwesomeIcon(icon: "\u{f013}", textColor: .gray, size: CGSize(width: 25.0, height: 25.0))

        let settingsSelectedIcon = UIImage.fontAwesomeIcon(icon: "\u{f013}", textColor: .blue, size: CGSize(width: 25.0, height: 25.0))
        
        settingsViewController.tabBarItem = UITabBarItem(title: "Settings", image: settingsIcon, selectedImage: settingsSelectedIcon)
        
        
        let viewControllerList = [homeViewController, devicesViewController, settingsViewController]

        self.viewControllers = viewControllerList.map {
            
            let navController = UINavigationController(rootViewController: $0)
            
            navController.navigationBar.setBackgroundImage(UIImage(), for: .default)
            navController.navigationBar.shadowImage = UIImage()
            navController.navigationBar.isTranslucent = true
            
            let button  = UIButton(type: .custom)
            
            let profileIcon = UIImage.profileIcon(profileName: profileLogin.profile.name, size: CGSize(width: 30.0, height: 30.0), color: .orange, textColor: .white)
                .withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
            
            button.setImage(profileIcon, for: .normal)
            
            button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            
            button.addTarget(self, action: #selector(onProfileButtonClicked), for: .touchUpInside)
            
            let barButton = UIBarButtonItem(customView: button)
            
            $0.navigationItem.setRightBarButtonItems([barButton], animated: true)
            
            return navController
        }
    }
    
    @objc func onProfileButtonClicked() {
        if (profileMenuViewController != nil) {
            present(profileMenuViewController!, animated: true, completion: nil)
        }
    }
    
}

