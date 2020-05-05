import UIKit

class LoginActionViewController : UIViewController, LoginActionView {

    weak var tableView: UITableView!
    
    var serversData: [ProfileLoginRequestItem] = []

    let presenter: LoginActionPresenter
    
    private let lblAnnouncement: UILabel = {
        let lbl = UILabel()
        lbl.text = "Logging you in..."
        lbl.font = .boldSystemFont(ofSize: 20)
        lbl.textAlignment = .center
        lbl.textColor = UIColor.init(red: 0.60, green: 0.60, blue: 0.60, alpha: 0.6)
        lbl.clipsToBounds = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    init(presenter: LoginActionPresenter) {
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
        
        let gradient = CAGradientLayer()

        gradient.frame = view.bounds
        gradient.colors = [UIColor.paleTurquoise.cgColor, UIColor.snow.cgColor]

        view.layer.insertSublayer(gradient, at: 0)
        
        let tableView = UITableView()
        
        tableView.backgroundColor = .clear
        
        tableView.separatorStyle = .none
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(lblAnnouncement)
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            
            lblAnnouncement.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            lblAnnouncement.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            lblAnnouncement.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: lblAnnouncement.bottomAnchor, constant: 40),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
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
    
    func showItems(_ items: [ProfileLoginRequestItem]) {
        serversData = items
        tableView.reloadData()
    }
    
    func viewController() -> UIViewController {
        return self
    }
    
}

extension LoginActionViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return serversData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let server = serversData[indexPath.row]
        var cell = tableView.dequeueReusableCell(withIdentifier: "OrderTableViewCell") as? ProfileLoginRequestItemTableViewCell
        if cell == nil {
            cell = ProfileLoginRequestItemTableViewCell()
        }
        cell?.item = server
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
}

extension LoginActionViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        presenter.serverItemClicked(serversData[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

