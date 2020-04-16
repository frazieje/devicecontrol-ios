import UIKit

class EditProfileLoginViewController : UIViewController, EditProfileLoginView {
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let advancedContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
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
    
    var advancedContentHeightConstraint: NSLayoutConstraint?
    
    var keyboardHeightLayoutConstraint: NSLayoutConstraint?

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
        
        btnAdvanced.addTarget(self, action: #selector(self.advancedButtonTapped), for: .touchUpInside)
        
        scrollView.addSubview(contentView)
        
        contentView.addSubview(lblInstructions)
        
        contentView.addSubview(txtUsername)
        
        contentView.addSubview(txtPassword)
        
        if advancedEnabled {
            contentView.addSubview(btnAdvanced)
        }
        
        contentView.addSubview(advancedContentView)
        
        advancedContentView.addSubview(txtProfileId)
        
        advancedContentView.addSubview(txtNodeServer)
        
        advancedContentView.addSubview(txtRemoteServer)
        
        contentView.addSubview(btnLogin)
        
        NSLayoutConstraint.activate([
            
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            lblInstructions.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            lblInstructions.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            lblInstructions.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            txtUsername.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            txtUsername.topAnchor.constraint(equalTo: lblInstructions.bottomAnchor, constant: 20),
            txtUsername.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            txtUsername.heightAnchor.constraint(equalToConstant: 50),
    
            txtPassword.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            txtPassword.topAnchor.constraint(equalTo: txtUsername.bottomAnchor, constant: 20),
            txtPassword.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            txtPassword.heightAnchor.constraint(equalToConstant: 50),
        
        ])
        
        if advancedEnabled {
            NSLayoutConstraint.activate([
                btnAdvanced.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
                btnAdvanced.topAnchor.constraint(equalTo: txtPassword.bottomAnchor, constant: 20),
                btnAdvanced.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            ])
        }
        
        let targetAnchor = advancedEnabled ? btnAdvanced.bottomAnchor : txtPassword.bottomAnchor
        
        advancedContentHeightConstraint = advancedContentView.heightAnchor.constraint(equalToConstant: 0)
        
        NSLayoutConstraint.activate([
            
            advancedContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            advancedContentView.topAnchor.constraint(equalTo: targetAnchor),
            advancedContentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            advancedContentHeightConstraint!,
            
            txtProfileId.leadingAnchor.constraint(equalTo: advancedContentView.leadingAnchor, constant: 12),
            txtProfileId.topAnchor.constraint(equalTo: advancedContentView.topAnchor, constant: 20),
            txtProfileId.trailingAnchor.constraint(equalTo: advancedContentView.trailingAnchor, constant: -12),
            txtProfileId.heightAnchor.constraint(equalToConstant: 50),
            
            txtNodeServer.leadingAnchor.constraint(equalTo: advancedContentView.leadingAnchor, constant: 12),
            txtNodeServer.topAnchor.constraint(equalTo: txtProfileId.bottomAnchor, constant: 20),
            txtNodeServer.trailingAnchor.constraint(equalTo: advancedContentView.trailingAnchor, constant: -12),
            txtNodeServer.heightAnchor.constraint(equalToConstant: 50),
            
            txtRemoteServer.leadingAnchor.constraint(equalTo: advancedContentView.leadingAnchor, constant: 12),
            txtRemoteServer.topAnchor.constraint(equalTo: txtNodeServer.bottomAnchor, constant: 20),
            txtRemoteServer.trailingAnchor.constraint(equalTo: advancedContentView.trailingAnchor, constant: -12),
            txtRemoteServer.heightAnchor.constraint(equalToConstant: 50),
            
            btnLogin.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            btnLogin.topAnchor.constraint(equalTo: advancedContentView.bottomAnchor, constant: 20),
            btnLogin.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            btnLogin.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
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
                advancedContentHeightConstraint!.constant = 210
                UIView.animate(withDuration: 0.3) {
                    self.scrollView.layoutIfNeeded()
                }
                sender.setAttributedTitle(selectedTitle, for: .normal)
                advancedHidden = false
            } else {
                advancedContentHeightConstraint!.constant = 0
                UIView.animate(withDuration: 0.3) {
                    self.scrollView.layoutIfNeeded()
                }
                sender.setAttributedTitle(attributedTitle, for: .normal)
                advancedHidden = true
            }
        }
    }
    
    func prefill(with: ProfileServerItem) {
        advancedEnabled = true
        advancedHidden = true
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
        
        NotificationCenter.default.addObserver(self,
            selector: #selector(self.keyboardNotification(notification:)),
            name: UIResponder.keyboardWillChangeFrameNotification,
            object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @objc func keyboardNotification(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            
            let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            
            let insets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: endFrame?.size.height ?? 0.0, right: 0.0)

            scrollView.contentInset = insets
            scrollView.scrollIndicatorInsets = insets

            var aRect = self.view.frame;
            aRect.size.height -= (endFrame?.size.height ?? 0.0);
            
            let activeField: UITextField? = [txtUsername, txtPassword, txtProfileId, txtNodeServer, txtRemoteServer].first { $0.isFirstResponder }
            if let activeField = activeField {
                if !aRect.contains(activeField.frame.origin) {
                    let scrollPoint = CGPoint(x: 0, y: activeField.frame.origin.y-(endFrame?.size.height ?? 0.0))
                    scrollView.setContentOffset(scrollPoint, animated: true)
                }
            }
        }
    }
    
    func viewController() -> UIViewController {
        return self
    }
    
}
