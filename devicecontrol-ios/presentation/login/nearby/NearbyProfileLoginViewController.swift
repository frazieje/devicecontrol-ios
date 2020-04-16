
import UIKit

class NearbyProfileLoginViewController : UIViewController, NearbyProfileLoginView {

    weak var tableView: UITableView!
    
    var serversData: [ProfileServerItem] = []

    let presenter: NearbyProfileLoginPresenter
    
    init(presenter: NearbyProfileLoginPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        let gradient = CAGradientLayer()

        gradient.frame = view.bounds
        gradient.colors = [UIColor.init(red: 0.99, green: 0.99, blue: 0.99, alpha: 1.0).cgColor, UIColor.init(red: 0.80, green: 0.80, blue: 0.80, alpha: 1.0).cgColor]

        view.layer.insertSublayer(gradient, at: 0)
        
        let tableView = UITableView()
        
        tableView.backgroundColor = UIColor.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.heightAnchor.constraint(equalToConstant: view.frame.height/3),
            tableView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        self.tableView = tableView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.onViewAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter.onViewDisappear()
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        title = "Nearby Profiles"
        
        tableView.dataSource = self
        tableView.delegate = self
        
        print("AddProfile viewDidLoad")
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    func showItems(_ items: [ProfileServerItem]) {
        serversData = items
        tableView.reloadData()
    }
    
    func viewController() -> UIViewController {
        return self
    }
    
}

extension NearbyProfileLoginViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return serversData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let server = serversData[indexPath.row]
        var cell = tableView.dequeueReusableCell(withIdentifier: "OrderTableViewCell")
        if cell == nil {
            cell = UITableViewCell(style: .value1, reuseIdentifier: "OrderTableViewCell")
        }
        cell?.textLabel?.text = server.profileId
        cell?.detailTextLabel?.text = server.host
        return cell!
    }
    
}

extension NearbyProfileLoginViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.serverItemClicked(serversData[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
