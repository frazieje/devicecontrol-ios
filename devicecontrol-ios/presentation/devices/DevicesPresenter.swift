//
//  DevicesPresenter.swift
//  devicecontrol-ios
//
//  Created by Joel Frazier on 10/7/19.
//  Copyright © 2019 Spoohapps, Inc. All rights reserved.
//

import Foundation

protocol DevicesPresenter : Presenter {
    
    func deviceClicked(id: String)
    
    func deviceGroupClicked(type: String)
    
    func setView(view: View)
    
}
