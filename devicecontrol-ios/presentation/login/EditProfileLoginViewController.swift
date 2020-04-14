import UIKit

class EditProfileLoginViewController : UIViewController, EditProfileLoginView {
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let contentView: UIStackView = {
        let view = UIStackView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.spacing = 20
        return view
    }()
    
    private let lblInstructions: UILabel = {
        let lbl = UILabel()
        lbl.text = "Enter your login information."
        lbl.textAlignment = .center
        lbl.textColor = .some(UIColor.init(red: 0.32, green: 0.32, blue: 0.32, alpha: 1.0))
        lbl.clipsToBounds = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private var advancedEnabled: Bool = false
    
    private var advancedHidden: Bool = false
    
    let txtUsername: UITextField = {
        let txt = UITextField()
        txt.layer.cornerRadius = 5
        txt.layer.borderWidth = 1.0
        txt.layer.borderColor = UIColor.lightGray.cgColor
        txt.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: txt.frame.height))
        txt.leftViewMode = .always
        txt.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: txt.frame.height))
        txt.rightViewMode = .always
        txt.clearButtonMode = .whileEditing
        txt.keyboardType = .emailAddress
        txt.returnKeyType = .next
        txt.autocapitalizationType = .none
        txt.placeholder = "Username"
        txt.clipsToBounds = true
        txt.textColor = .darkGray
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()

    let txtPassword: UITextField = {
        let txt = UITextField()
        txt.layer.cornerRadius = 5
        txt.layer.borderWidth = 1.0
        txt.layer.borderColor = UIColor.lightGray.cgColor
        txt.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: txt.frame.height))
        txt.leftViewMode = .always
        txt.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: txt.frame.height))
        txt.rightViewMode = .always
        txt.clearButtonMode = .whileEditing
        txt.autocorrectionType = .no
        txt.keyboardType = .default
        txt.returnKeyType = .done
        txt.autocapitalizationType = .none
        txt.placeholder = "Password"
        txt.textColor = .darkGray
        txt.isSecureTextEntry = true
        txt.clipsToBounds = true
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    let btnAdvanced: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitleColor(.lightGray, for: .normal)
        btn.setTitleShadowColor(.white, for: .normal)
        let iconString = NSAttributedString.fontAwesomeIcon(icon: "\u{f107}", textColor: .lightGray, size: CGFloat(14.0))
        let advancedSettings = NSAttributedString(string: "Advanced Settings ")
        let attributedTitle = NSMutableAttributedString()
        attributedTitle.append(advancedSettings)
        attributedTitle.append(iconString)
        btn.setAttributedTitle(attributedTitle, for: .normal)
        btn.tintColor = .lightGray
        btn.layer.cornerRadius = 5
        btn.contentHorizontalAlignment = .leading
        btn.clipsToBounds = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let txtProfileId: UITextField = {
        let txt = UITextField()
        txt.layer.cornerRadius = 5
        txt.layer.borderWidth = 1.0
        txt.layer.borderColor = UIColor.lightGray.cgColor
        txt.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: txt.frame.height))
        txt.leftViewMode = .always
        txt.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: txt.frame.height))
        txt.rightViewMode = .always
        txt.clearButtonMode = .whileEditing
        txt.keyboardType = .emailAddress
        txt.returnKeyType = .next
        txt.autocapitalizationType = .none
        txt.placeholder = "Profile ID"
        txt.textColor = .darkGray
        txt.clipsToBounds = true
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    let txtNodeServer: UITextField = {
        let txt = UITextField()
        txt.layer.cornerRadius = 5
        txt.layer.borderWidth = 1.0
        txt.layer.borderColor = UIColor.lightGray.cgColor
        txt.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: txt.frame.height))
        txt.leftViewMode = .always
        txt.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: txt.frame.height))
        txt.rightViewMode = .always
        txt.clearButtonMode = .whileEditing
        txt.keyboardType = .emailAddress
        txt.returnKeyType = .next
        txt.autocapitalizationType = .none
        txt.placeholder = "Server"
        txt.textColor = .darkGray
        txt.clipsToBounds = true
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    let txtRemoteServer: UITextField = {
        let txt = UITextField()
        txt.layer.cornerRadius = 5
        txt.layer.borderWidth = 1.0
        txt.layer.borderColor = UIColor.lightGray.cgColor
        txt.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: txt.frame.height))
        txt.leftViewMode = .always
        txt.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: txt.frame.height))
        txt.rightViewMode = .always
        txt.clearButtonMode = .whileEditing
        txt.keyboardType = .emailAddress
        txt.returnKeyType = .next
        txt.autocapitalizationType = .none
        txt.placeholder = "Remote Server"
        txt.textColor = .darkGray
        txt.clipsToBounds = true
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    let btnLogin: UIButton = {
        let btn = UIButton(type: .roundedRect)
        let iconString = NSAttributedString.fontAwesomeIcon(icon: "\u{f105}", textColor: .systemBlue, size: CGFloat(18.0))
        let login = NSMutableAttributedString(string: "Log in ", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18.0)])
        let attributedTitle = NSMutableAttributedString()
        attributedTitle.append(login)
        attributedTitle.append(iconString)
        btn.setAttributedTitle(attributedTitle, for: .normal)
        btn.layer.cornerRadius = 5
        btn.contentHorizontalAlignment = .trailing
        btn.clipsToBounds = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    let presenter: EditProfileLoginPresenter
    
    init(presenter: EditProfileLoginPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        view.addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        
        btnAdvanced.addTarget(self, action: #selector(self.advancedButtonTapped), for: .touchUpInside)
        
        contentView.addArrangedSubview(lblInstructions)
        
        contentView.addArrangedSubview(txtUsername)
        
        contentView.addArrangedSubview(txtPassword)
        
        if advancedEnabled {
            contentView.addArrangedSubview(btnAdvanced)
        }
        
        contentView.addArrangedSubview(txtProfileId)
        
        contentView.addArrangedSubview(txtNodeServer)
        
        contentView.addArrangedSubview(txtRemoteServer)
        
        contentView.addArrangedSubview(btnLogin)
        
        NSLayoutConstraint.activate([
            
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20),
            
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            lblInstructions.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            lblInstructions.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            lblInstructions.heightAnchor.constraint(equalToConstant: 80),

            txtUsername.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            txtUsername.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            txtUsername.heightAnchor.constraint(equalToConstant: 50),
    
            txtPassword.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            txtPassword.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            txtPassword.heightAnchor.constraint(equalToConstant: 50)
        
        ])
        
        if advancedEnabled {
            NSLayoutConstraint.activate([
                btnAdvanced.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                btnAdvanced.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            ])
        }
        
        NSLayoutConstraint.activate([
            
            txtProfileId.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            txtProfileId.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            txtProfileId.heightAnchor.constraint(equalToConstant: 50),
            
            txtNodeServer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            txtNodeServer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            txtNodeServer.heightAnchor.constraint(equalToConstant: 50),
            
            txtRemoteServer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            txtRemoteServer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            txtRemoteServer.heightAnchor.constraint(equalToConstant: 50),
            
            btnLogin.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            btnLogin.heightAnchor.constraint(equalToConstant: 50),
            btnLogin.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
        ])
        
    }
    
    @objc func advancedButtonTapped(sender: UIButton) {
        let iconString = NSAttributedString.fontAwesomeIcon(icon: "\u{f107}", textColor: .lightGray, size: CGFloat(14.0))
        let selectedIconString = NSAttributedString.fontAwesomeIcon(icon: "\u{f106}", textColor: .lightGray, size: CGFloat(14.0))
        let advancedSettings = NSAttributedString(string: "Advanced Settings ")
        let attributedTitle = NSMutableAttributedString()
        attributedTitle.append(advancedSettings)
        attributedTitle.append(iconString)
        let selectedTitle = NSMutableAttributedString()
        selectedTitle.append(advancedSettings)
        selectedTitle.append(selectedIconString)
        if advancedEnabled {
            if advancedHidden {
                contentView.make(viewsHidden: [], viewsVisible: [txtProfileId, txtNodeServer, txtRemoteServer], animated: true)
                sender.setAttributedTitle(selectedTitle, for: .normal)
                advancedHidden = false
            } else {
                contentView.make(viewsHidden: [txtRemoteServer, txtNodeServer, txtProfileId], viewsVisible: [], animated: true)
                sender.setAttributedTitle(attributedTitle, for: .normal)
                advancedHidden = true
            }
        }
    }
    
    func prefill(with: ProfileServerItem) {
        advancedEnabled = true
        advancedHidden = true
        txtProfileId.isHidden = true
        txtNodeServer.isHidden = true
        txtRemoteServer.isHidden = true
        txtProfileId.text = with.profileId
        txtNodeServer.text = "http://\(with.host)\(with.port == 80 ? "" : ":\(with.port)")"
        if let host = with.remoteHost, let port = with.remotePort {
            txtRemoteServer.text = "https://\(host)\(port == 80 ? "" : ":\(port)")"
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
        
        title = "Edit a Profile"
        
    }
    
    func viewController() -> UIViewController {
        return self
    }
    
}
