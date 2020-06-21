import UIKit

class DoorLockDetailsViewController : UIViewController, DoorLockDetailsView {
    
    weak var tableView: UITableView!
    
    var item: DoorLock?

    let presenter: DoorLockDetailsPresenter
    
    private var feedbackGenerator: UINotificationFeedbackGenerator? = nil
    
    let controlView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = .clear
        return view
    }()
    
    let btnLocked: UIButton = {
        let btn = UIButton(type: .custom)
        let iconString = NSAttributedString.fontAwesomeIcon(icon: "\u{f023}", textColor: .systemGreen, size: CGFloat(64.0))
        let highlightedColor = UIColor(red: 46/255, green: 187/255, blue: 70/255, alpha: 1)
        let highlightedIconString = NSAttributedString.fontAwesomeIcon(icon: "\u{f023}", textColor: highlightedColor, size: CGFloat(64.0))
        let attributedTitle = NSMutableAttributedString()
        attributedTitle.append(iconString)
        btn.setAttributedTitle(attributedTitle, for: .normal)
        btn.setAttributedTitle(highlightedIconString, for: .highlighted)
        btn.backgroundColor = .clear
        btn.setTitleColor(.systemGreen, for: .normal)
        btn.setTitleColor(highlightedColor, for: .highlighted)
        btn.contentHorizontalAlignment = .trailing
        btn.clipsToBounds = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let btnUnlocked: UIButton = {
        let btn = UIButton(type: .custom)
        let iconString = NSAttributedString.fontAwesomeIcon(icon: "\u{f3c1}", textColor: .parrotPink, size: CGFloat(64.0))
        let highlightedColor = UIColor(red: 202/255, green: 140/255, blue: 157/255, alpha: 1.0)
        let highlightedIconString = NSAttributedString.fontAwesomeIcon(icon: "\u{f3c1}", textColor: highlightedColor, size: CGFloat(64.0))
        let attributedTitle = NSMutableAttributedString()
        attributedTitle.append(iconString)
        btn.setAttributedTitle(attributedTitle, for: .normal)
        btn.setAttributedTitle(highlightedIconString, for: .highlighted)
        btn.backgroundColor = .clear
        btn.setTitleColor(.parrotPink, for: .normal)
        btn.setTitleColor(highlightedColor, for: .highlighted)
        btn.contentHorizontalAlignment = .trailing
        btn.clipsToBounds = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    init(presenter: DoorLockDetailsPresenter) {
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
        
        feedbackGenerator = UINotificationFeedbackGenerator()
        feedbackGenerator?.prepare()
        
        let gradient = CAGradientLayer()

        gradient.frame = view.bounds
        gradient.colors = [UIColor.paleTurquoise.cgColor, UIColor.snow.cgColor]

        view.layer.insertSublayer(gradient, at: 0)
        
        let tableView = UITableView()
        
        tableView.backgroundColor = .clear
        
        tableView.separatorStyle = .none
        
        tableView.allowsSelection = false
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(controlView)
        
        controlView.addSubview(btnLocked)
        
        controlView.addSubview(btnUnlocked)
        
        let lineView = UIView(frame: CGRect(x: view.frame.width/2, y: 0, width: 2, height: 30))
        lineView.backgroundColor = .blackCoral
        lineView.translatesAutoresizingMaskIntoConstraints = false
        
        btnLocked.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(onLockedButtonPressed)))
            
        btnUnlocked.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(onUnlockedButtonPressed)))
        
        view.addSubview(lineView)
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            
            controlView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            controlView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            controlView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            controlView.heightAnchor.constraint(equalToConstant: view.bounds.height / 3),
            
            btnLocked.centerXAnchor.constraint(equalTo: controlView.centerXAnchor),
            btnLocked.centerYAnchor.constraint(equalTo: controlView.centerYAnchor),
            
            btnUnlocked.centerXAnchor.constraint(equalTo: controlView.centerXAnchor),
            btnUnlocked.centerYAnchor.constraint(equalTo: controlView.centerYAnchor),
            
            lineView.topAnchor.constraint(equalTo: btnLocked.bottomAnchor, constant: 2),
            lineView.widthAnchor.constraint(equalToConstant: 2),
            lineView.bottomAnchor.constraint(equalTo: controlView.bottomAnchor),
            lineView.centerXAnchor.constraint(equalTo: controlView.centerXAnchor),
            
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: controlView.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
        self.tableView = tableView
    }
    
    @objc func onLockedButtonPressed(gesture: UILongPressGestureRecognizer) {
        if gesture.state == UIGestureRecognizer.State.began {
            feedbackGenerator?.notificationOccurred(.success)
            presenter.onUnlock()
        }
    }
    
    @objc func onUnlockedButtonPressed(gesture: UILongPressGestureRecognizer) {
        if gesture.state == UIGestureRecognizer.State.began {
            feedbackGenerator?.notificationOccurred(.success)
            presenter.onLock()
        }
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
        
        tableView.dataSource = self
        
        presenter.onViewLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    func viewController() -> UIViewController {
        return self
    }
    
    
    func show(lock: DoorLock) {
        self.item = lock
        switch item?.state {
            case .locked, .unlocking:
                btnLocked.isHidden = false
                btnUnlocked.isHidden = true
            case .unlocked, .locking:
                btnLocked.isHidden = true
                btnUnlocked.isHidden = false
            default:
                btnLocked.isHidden = true
                btnUnlocked.isHidden = true
        }
        title = item?.name
        tableView.reloadData()
    }
    
    func showDeviceLog(messages: [DoorLockStateChange]) {
        item?.history = messages
        tableView.reloadData()
    }
    
    func showError(message: String?) {
    
    }
    
}

extension DoorLockDetailsViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (item?.history.count ?? 0) + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == item?.history.count ?? 0 {
            var cell = tableView.dequeueReusableCell(withIdentifier: "MoreHistoryTableViewCell") as? MoreHistoryTableViewCell
            if cell == nil {
                cell = MoreHistoryTableViewCell()
            }
            cell?.presenter = presenter
            return cell!
        }
        let historyItem = item?.history[indexPath.row]
        var cell = tableView.dequeueReusableCell(withIdentifier: "DoorLockHistoryTableViewCell") as? DoorLockHistoryTableViewCell
        if cell == nil {
            cell = DoorLockHistoryTableViewCell()
        }
        cell?.item = historyItem
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}
