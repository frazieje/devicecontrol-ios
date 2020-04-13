//
//  ProfileMenuPresenter.swift
//  devicecontrol-ios
//
//  Created by Joel Frazier on 2/14/20.
//  Copyright © 2020 Spoohapps, Inc. All rights reserved.
//

import Foundation

class ProfileMenuPresenter : MenuPresenter {
    
    let loginService: LoginService
    
    var menuView: MenuView? = nil
    
    init(loginService: LoginService) {
        self.loginService = loginService
    }
    
    func onViewAppear() {
        
    }
    
    func onViewDisappear() {
        
    }
    
    func setView(view: MenuView) {
        menuView = view
    }
    
}
