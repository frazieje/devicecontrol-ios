//
//  SettingsViewController.swift
//  devicecontrol-ios
//
//  Created by Joel Frazier on 9/5/19.
//  Copyright © 2019 Spoohapps, Inc. All rights reserved.
//

import UIKit

class SettingsViewController : UIViewController {
    
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
        
        let testView = UIView(frame: .zero)
        testView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(testView)
        
        NSLayoutConstraint.activate([
            testView.widthAnchor.constraint(equalToConstant: 64),
            testView.widthAnchor.constraint(equalTo: testView.heightAnchor),
            testView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            testView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            ])
        
        self.testView = testView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        testView.backgroundColor = .blue
        
        title = "Settings"
        
        
        print("Settings viewDidLoad")
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("Settings viewDidAppear")
    }
    
}
