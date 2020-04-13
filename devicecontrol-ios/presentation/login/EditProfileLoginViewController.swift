import UIKit

class EditProfileLoginViewController : UIViewController, EditProfileLoginView {

    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let advancedContentView: UIView = {
      let view = UIView()
      view.isHidden = true
      view.backgroundColor = .gray
      view.translatesAutoresizingMaskIntoConstraints = false
      return view
    }()
    
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
        
        btnAdvanced.addTarget(self, action: #selector(self.advancedButtonTapped), for: .touchUpInside)
        
        contentView.addSubview(txtUsername)
        
        contentView.addSubview(txtPassword)
        
        contentView.addSubview(btnAdvanced)
        
        view.addSubview(contentView)
        
        view.addSubview(advancedContentView)
        
        NSLayoutConstraint.activate([
            
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.heightAnchor.constraint(equalToConstant: view.frame.height/3),
            contentView.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            txtUsername.topAnchor.constraint(equalTo:contentView.topAnchor, constant:40),
            txtUsername.leftAnchor.constraint(equalTo:contentView.leftAnchor, constant:20),
            txtUsername.rightAnchor.constraint(equalTo:contentView.rightAnchor, constant:-20),
            txtUsername.heightAnchor.constraint(equalToConstant:50),
    
            txtPassword.leftAnchor.constraint(equalTo:contentView.leftAnchor, constant:20),
            txtPassword.rightAnchor.constraint(equalTo:contentView.rightAnchor, constant:-20),
            txtPassword.topAnchor.constraint(equalTo:txtUsername.bottomAnchor, constant:20),
            txtPassword.heightAnchor.constraint(equalToConstant:50),
            
            btnAdvanced.leftAnchor.constraint(equalTo:contentView.leftAnchor, constant:20),
            btnAdvanced.topAnchor.constraint(equalTo:txtPassword.bottomAnchor, constant:20),
            
            advancedContentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            advancedContentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            advancedContentView.topAnchor.constraint(equalTo: contentView.bottomAnchor),
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
        if (advancedContentView.isHidden) {
            advancedContentView.isHidden = false
            sender.setAttributedTitle(selectedTitle, for: .normal)
        } else {
            advancedContentView.isHidden = true
            sender.setAttributedTitle(attributedTitle, for: .normal)
        }
    }
    
    func prefill(with: ProfileServerItem) {
        
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
