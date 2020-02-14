//
//  ProfileMenuViewController.swift
//  devicecontrol-ios
//
//  Created by Joel Frazier on 10/1/19.
//  Copyright © 2019 Spoohapps, Inc. All rights reserved.
//

import UIKit

class ProfileMenuViewController : UIViewController {

    weak var testView: UIView!
    
    let profileLogin: ProfileLogin
    
    init(profileLogin: ProfileLogin) {
        self.profileLogin = profileLogin
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController!.navigationBar.shadowImage = UIImage()
        navigationController!.navigationBar.isTranslucent = true
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = .clear
        
        print("Menu viewDidLoad")
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("Menu viewDidAppear")
    }

}
