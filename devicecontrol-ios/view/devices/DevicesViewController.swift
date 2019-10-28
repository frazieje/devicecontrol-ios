//
//  DevicesViewController.swift
//  devicecontrol-ios
//
//  Created by Joel Frazier on 9/5/19.
//  Copyright © 2019 Spoohapps, Inc. All rights reserved.
//

import UIKit

class DevicesViewController : UIViewController, DevicesView {
    
    func showDevices(devices: [ProfileDevice]) {
        
        tableView.reloadData()
    }
    
    func showError(message: String) {
        
    }
    
    weak var tableView: UITableView!
    
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
        
        let tableView = UITableView()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        self.tableView = tableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        title = "Devices"
        
        tableView.dataSource = self
        
        print("Devices viewDidLoad")
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("Devices viewDidAppear")
    }
    
}

extension DevicesViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellID", for: indexPath)
        return cell
    }
    
}
