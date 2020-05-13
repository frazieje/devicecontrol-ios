import UIKit

class LoginActionViewController : UIViewController, LoginActionView {

    weak var tableView: UITableView!
    
    var serversData: [ProfileLoginRequestItem] = []

    let presenter: LoginActionPresenter
    
    private let lblAnnouncement: UILabel = {
        let lbl = UILabel()
        lbl.font = .boldSystemFont(ofSize: 20)
        lbl.textAlignment = .center
        lbl.textColor = UIColor.init(red: 0.60, green: 0.60, blue: 0.60, alpha: 0.6)
        lbl.clipsToBounds = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let iconViewCheck: UIImageView = {
        let view = UIImageView()
        view.image = UIImage.fontAwesomeIcon(icon: "\u{f00c}", textColor: .systemGreen, size: CGSize(width: 25, height: 25))
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        
        tableView.alpha = 0.0
        
        view.addSubview(lblAnnouncement)
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            
            lblAnnouncement.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            lblAnnouncement.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            lblAnnouncement.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            tableView.topAnchor.constraint(equalTo: lblAnnouncement.bottomAnchor, constant: 50),
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let gradLayers = view.layer.sublayers?.compactMap { $0 as? CAGradientLayer }
        gradLayers?.first?.frame = view.bounds
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        title = "Logging In"
        
        tableView.dataSource = self
        tableView.delegate = self
        
        print("Login Action viewDidLoad")
        
        presenter.onViewLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {

    }
    
    func showRequests() {
        UIView.animate(withDuration: 0.2, delay: 0.3, options: .curveEaseOut, animations: {
            self.tableView.alpha = 1.0
        }, completion: { b in
            self.presenter.onViewReady()
        })
    }
    
    func prefill(with: [ProfileLoginRequestItem]) {
        serversData = with
        updateLabelText(count: serversData.count)
    }
    
    func update(with: [ProfileLoginRequestItem]) {
        serversData = with
        tableView.reloadData()
    }
    
    private func updateLabelText(count: Int) {
        lblAnnouncement.text = "Logging you into \(count) server\(count > 1 ? "s" : "")..."
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
        var cell = tableView.dequeueReusableCell(withIdentifier: "ProfileLoginRequestItemTableViewCell") as? ProfileLoginRequestItemTableViewCell
        if cell == nil {
            cell = ProfileLoginRequestItemTableViewCell()
        }
        cell?.selectionStyle = .none
        cell?.item = server
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}

extension LoginActionViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        presenter.serverItemClicked(serversData[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

