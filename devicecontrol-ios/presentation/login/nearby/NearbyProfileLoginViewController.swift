
import UIKit

class NearbyProfileLoginViewController : UIViewController, NearbyProfileLoginView {

    weak var tableView: UITableView!
    
    var serversData: [ProfileServerItem] = []

    let presenter: NearbyProfileLoginPresenter
    
    let iconViewWifi: UIImageView = {
        let view = UIImageView()
        view.image = UIImage.fontAwesomeIcon(icon: "\u{f1eb}", textColor: UIColor.init(red: 0.60, green: 0.60, blue: 0.60, alpha: 0.6), size: CGSize(width: 180, height: 180))
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let lblAnnouncement: UILabel = {
        let lbl = UILabel()
        lbl.text = "Scanning for nearby profiles..."
        lbl.font = .boldSystemFont(ofSize: 20)
        lbl.textAlignment = .center
        lbl.textColor = UIColor.init(red: 0.60, green: 0.60, blue: 0.60, alpha: 0.6)
        lbl.clipsToBounds = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let lblInstructions: UILabel = {
        let lbl = UILabel()
        lbl.text = "Note: Make sure your gateway device is on the same WiFi network as this iPhone/iPad"
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        lbl.textColor = UIColor.init(red: 0.60, green: 0.60, blue: 0.60, alpha: 0.6)
        lbl.clipsToBounds = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    init(presenter: NearbyProfileLoginPresenter) {
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
        
        view.addSubview(iconViewWifi)
        
        view.addSubview(lblInstructions)
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            
            iconViewWifi.heightAnchor.constraint(equalToConstant: 150),
            iconViewWifi.widthAnchor.constraint(equalToConstant: 150),
            iconViewWifi.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            iconViewWifi.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            
            lblAnnouncement.bottomAnchor.constraint(equalTo: iconViewWifi.topAnchor, constant: -20),
            lblAnnouncement.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            lblAnnouncement.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            lblInstructions.topAnchor.constraint(equalTo: iconViewWifi.bottomAnchor, constant: 20),
            lblInstructions.widthAnchor.constraint(equalToConstant: view.frame.width/1.5),
            lblInstructions.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
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
        var cell = tableView.dequeueReusableCell(withIdentifier: "OrderTableViewCell") as? ProfileServerItemTableViewCell
        if cell == nil {
            cell = ProfileServerItemTableViewCell()
        }
        cell?.item = server
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}

extension NearbyProfileLoginViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.serverItemClicked(serversData[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
