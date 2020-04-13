
import UIKit

class AddProfileLoginViewController : UIViewController, AddProfileLoginView {

    weak var tableView: UITableView!
    
    var serversData: [ProfileServerItem] = []
    
//    private let contentView: UIView = {
//      let view = UIView()
//      view.backgroundColor = .gray
//      view.translatesAutoresizingMaskIntoConstraints = false
//      return view
//    }()
    
//    let btnManualEntry: UIButton = {
//        let btn = UIButton(type:.system)
//        btn.backgroundColor = .blue
//        btn.setTitle("I know my login info", for: .normal)
//        btn.tintColor = .white
//        btn.layer.cornerRadius = 5
//        btn.clipsToBounds = true
//        btn.translatesAutoresizingMaskIntoConstraints = false
//        return btn
//    }()
//
//    let btnSearch: UIButton = {
//        let btn = UIButton(type:.system)
//        btn.backgroundColor = .blue
//        btn.setTitle("Find My login", for: .normal)
//        btn.tintColor = .white
//        btn.layer.cornerRadius = 5
//        btn.clipsToBounds = true
//        btn.translatesAutoresizingMaskIntoConstraints = false
//        return btn
//    }()

    let presenter: AddProfileLoginPresenter
    
    init(presenter: AddProfileLoginPresenter) {
        self.presenter = presenter
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
        
        title = "Add a Profile"
        
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

extension AddProfileLoginViewController : UITableViewDataSource {
    
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

extension AddProfileLoginViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.serverItemClicked(serversData[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
