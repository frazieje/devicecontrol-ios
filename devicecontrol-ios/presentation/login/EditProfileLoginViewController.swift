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
        btn.contentHorizontalAlignment = .leading
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
        
        contentView.addArrangedSubview(txtUsername)
        
        contentView.addArrangedSubview(txtPassword)
        
        contentView.addArrangedSubview(btnAdvanced)
        
        contentView.addArrangedSubview(advancedContentView)
        
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

            txtUsername.leadingAnchor.constraint(equalTo:contentView.leadingAnchor),
            txtUsername.trailingAnchor.constraint(equalTo:contentView.trailingAnchor),
            txtUsername.heightAnchor.constraint(equalToConstant:50),
    
            txtPassword.leadingAnchor.constraint(equalTo:contentView.leadingAnchor),
            txtPassword.trailingAnchor.constraint(equalTo:contentView.trailingAnchor),
            txtPassword.heightAnchor.constraint(equalToConstant:50),
            
            btnAdvanced.leadingAnchor.constraint(equalTo:contentView.leadingAnchor),

            advancedContentView.leadingAnchor.constraint(equalTo:contentView.leadingAnchor),
            advancedContentView.trailingAnchor.constraint(equalTo:contentView.trailingAnchor),
            
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
