import UIKit

class DevicesViewController : UIViewController, DevicesView {

    weak var tableView: UITableView!
    
    let presenter: DevicesPresenter
    
    var devicesData: [ProfileDevice] = []
    
    private let refreshControl = UIRefreshControl()
    
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
        
        tableView.contentInset = UIEdgeInsets(top: 15.0, left: 0.0, bottom: 0.0, right: 0.0)
        
        refreshControl.bounds = CGRect(x: refreshControl.bounds.origin.x,
                                       y: -30,
                                       width: refreshControl.bounds.size.width,
                                       height: refreshControl.bounds.size.height);
        
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        
        refreshControl.tintColor = .darkGray
        
        tableView.refreshControl = refreshControl
        
        tableView.backgroundColor = .clear
        
        tableView.separatorStyle = .none
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
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
        tableView.delegate = self
        
        print("Devices viewDidLoad")
        
        presenter.onViewLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("Devices viewDidAppear")
    }
    
    func showDevices(devices: [ProfileDevice]) {
        print("Devices showDevices")
        devicesData = devices
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    func showError(message: String) {
        print("Devices showError")
        devicesData = []
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    @objc private func refresh(_ sender: Any) {
        // Fetch Weather Data
        presenter.onRefresh()
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
        
        let device = devicesData[indexPath.row]
        
        let cell = presenter.tableViewCellFor(device: device, tableView: tableView)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.contentView.layer.masksToBounds = true
        let radius = cell.contentView.layer.cornerRadius
        cell.layer.shadowPath = UIBezierPath(roundedRect: CGRect(x: 12,
                                                          y: cell.bounds.maxY - 15,
                                                          width: cell.bounds.width-22,
                                                          height: 10), cornerRadius: radius).cgPath
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}

extension DevicesViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.deviceClicked(devicesData[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
