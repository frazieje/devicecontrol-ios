import UIKit

class DevicesViewController : UIViewController, DevicesView {

    weak var tableView: UITableView!
    
    let presenter: DevicesPresenter
    
    var devicesData: [ProfileDevice] = []
    
    init(presenter: DevicesPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        
        let devicesIcon = UIImage.fontAwesomeIcon(icon: "\u{f2db}", textColor: .gray, size: CGSize(width: 25.0, height: 25.0))
        
        let devicesSelectedIcon = UIImage.fontAwesomeIcon(icon: "\u{f2db}", textColor: .blue, size: CGSize(width: 25.0, height: 25.0))
        
        tabBarItem = UITabBarItem(title: "Devices", image: devicesIcon, selectedImage: devicesSelectedIcon)
        
        let tableView = UITableView()
        
        tableView.backgroundColor = .clear
        
        tableView.separatorStyle = .none
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.onViewAppear()
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
    
    func showDevices(devices: [ProfileDevice]) {
        print("Devices showDevices")
        devicesData = devices
        tableView.reloadData()
    }
    
    func showError(message: String) {
        print("Devices showError")
        devicesData = []
        tableView.reloadData()
    }
    
    func viewController() -> UIViewController {
        return self
    }
    
}

extension DevicesViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return devicesData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellID", for: indexPath)
        cell.textLabel?.text = "Device: \(devicesData[indexPath.row].deviceId)"
        return cell
    }
    
}
