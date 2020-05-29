import UIKit

class DevicesViewController : UIViewController, DevicesView, DoorLockTableViewCellDelegate {

    weak var tableView: UITableView!
    
    let presenter: DevicesPresenter
    
    var devicesData: [ProfileDevice] = []
    
    init(presenter: DevicesPresenter) {
        
        self.presenter = presenter
        
        let devicesIcon = UIImage.fontAwesomeIcon(icon: "\u{f2db}", textColor: .gray, size: CGSize(width: 25.0, height: 25.0))
        
        let devicesSelectedIcon = UIImage.fontAwesomeIcon(icon: "\u{f2db}", textColor: .blue, size: CGSize(width: 25.0, height: 25.0))
        
        super.init(nibName: nil, bundle: nil)
        
        tabBarItem = UITabBarItem(title: "Devices", image: devicesIcon, selectedImage: devicesSelectedIcon)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        
        super.loadView()
        
        let gradient = CAGradientLayer()

        gradient.frame = view.bounds
        gradient.colors = [UIColor.paleTurquoise.cgColor, UIColor.snow.cgColor]

        view.layer.insertSublayer(gradient, at: 0)
        
        let tableView = UITableView()
        
        tableView.backgroundColor = .clear
        
        tableView.separatorStyle = .none
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
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
    
    func onLock(index: Int) {
        print("lock \(devicesData[index].deviceId)")
    }
    
    func onUnlock(index: Int) {
        print("unlock \(devicesData[index].deviceId)")
    }
    
}

extension DevicesViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return devicesData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let device = devicesData[indexPath.row]
        
        switch device {
            case let lock as DoorLock:
                var cell = tableView.dequeueReusableCell(withIdentifier: "DoorLockTableViewCell") as? DoorLockTableViewCell
                if cell == nil {
                    cell = DoorLockTableViewCell()
                    cell?.delegate = self
                }
                cell?.index = indexPath.row
                cell?.item = lock
                return cell!
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: "CellID", for: indexPath)
                cell.textLabel?.text = "Device: \(devicesData[indexPath.row].deviceId)"
                return cell
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.contentView.layer.masksToBounds = true
        let radius = cell.contentView.layer.cornerRadius
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: radius).cgPath
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
