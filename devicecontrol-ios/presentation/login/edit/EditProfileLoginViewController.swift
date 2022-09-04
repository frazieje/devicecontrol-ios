import UIKit

class EditProfileLoginViewController : UIViewController, EditProfileLoginView {

    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let advancedContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
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
    
    let lblUsername: UILabel = {
        let lbl = UILabel()
        lbl.text = "Username"
        lbl.font = .systemFont(ofSize: 12)
        lbl.textAlignment = .left
        lbl.textColor = .some(UIColor.init(red: 0.32, green: 0.32, blue: 0.32, alpha: 1.0))
        lbl.clipsToBounds = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let lblErrorUsername: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 12)
        lbl.textAlignment = .right
        lbl.textColor = .parrotPink
        lbl.clipsToBounds = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let txtUsername: UITextField = {
        let txt = UITextField()
        txt.backgroundColor = .snow
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
        let textColor: UIColor = .lightGray
        let advancedSettings = NSAttributedString(string: "your@email.com", attributes: [
            NSAttributedString.Key.foregroundColor: textColor,
        ])
        txt.attributedPlaceholder = advancedSettings
        txt.clipsToBounds = true
        txt.textColor = .darkGray
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    let lblPassword: UILabel = {
        let lbl = UILabel()
        lbl.text = "Password"
        lbl.font = .systemFont(ofSize: 12)
        lbl.textAlignment = .left
        lbl.textColor = .some(UIColor.init(red: 0.32, green: 0.32, blue: 0.32, alpha: 1.0))
        lbl.clipsToBounds = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let lblErrorPassword: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 12)
        lbl.textAlignment = .right
        lbl.textColor = .parrotPink
        lbl.clipsToBounds = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()

    let txtPassword: UITextField = {
        let txt = UITextField()
        txt.backgroundColor = .snow
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
        let textColor: UIColor = .lightGray
        let advancedSettings = NSAttributedString(string: "e.g. a-zA-Z0-9!@#$%^&*_+-=", attributes: [
            NSAttributedString.Key.foregroundColor: textColor,
        ])
        txt.attributedPlaceholder = advancedSettings
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
    
    let lblProfileId: UILabel = {
        let lbl = UILabel()
        lbl.text = "Profile ID"
        lbl.font = .systemFont(ofSize: 12)
        lbl.textAlignment = .left
        lbl.textColor = .some(UIColor.init(red: 0.32, green: 0.32, blue: 0.32, alpha: 1.0))
        lbl.clipsToBounds = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let lblErrorProfileId: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 12)
        lbl.textAlignment = .right
        lbl.textColor = .parrotPink
        lbl.clipsToBounds = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let txtProfileId: UITextField = {
        let txt = UITextField()
        txt.backgroundColor = .snow
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
        txt.placeholder = "e.g. 1x3f24s9"
        txt.textColor = .darkGray
        txt.clipsToBounds = true
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    let btnPlus: UIButton = {
        let btn = UIButton(type: .roundedRect)
        let iconString = NSAttributedString.fontAwesomeIcon(icon: "\u{f055}", textColor: .blackCoral, size: CGFloat(20.0))
        btn.setAttributedTitle(iconString, for: .normal)
        btn.backgroundColor = .clear
        btn.tintColor = .snow
        btn.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        btn.contentHorizontalAlignment = .center
        btn.clipsToBounds = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.zPosition = 1
        return btn
    }()
    
    let btnMinus: UIButton = {
        let btn = UIButton(type: .roundedRect)
        let iconString = NSAttributedString.fontAwesomeIcon(icon: "\u{f056}", textColor: .blackCoral, size: CGFloat(20.0))
        btn.setAttributedTitle(iconString, for: .normal)
        btn.backgroundColor = .clear
        btn.tintColor = .snow
        btn.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        btn.contentHorizontalAlignment = .center
        btn.clipsToBounds = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.zPosition = 1
        return btn
    }()
    
    let lblServer: () -> UILabel = {
        let lbl = UILabel()
        lbl.text = "Server"
        lbl.font = .systemFont(ofSize: 12)
        lbl.textAlignment = .left
        lbl.textColor = .some(UIColor.init(red: 0.32, green: 0.32, blue: 0.32, alpha: 1.0))
        lbl.clipsToBounds = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }
    
    let lblErrorServer: () -> UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 12)
        lbl.textAlignment = .right
        lbl.textColor = .parrotPink
        lbl.clipsToBounds = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }
    
    let txtServer: (String?) -> UITextField = { text in
        let txt = UITextField()
        txt.backgroundColor = .snow
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
        txt.placeholder = "e.g. https://api.example.com"
        txt.textColor = .darkGray
        txt.clipsToBounds = true
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.text = text
        return txt
    }
    
    let btnLogin: UIButton = {
        let btn = UIButton(type: .roundedRect)
        let iconString = NSAttributedString.fontAwesomeIcon(icon: "\u{f105}", textColor: .snow, size: CGFloat(18.0))
        let login = NSMutableAttributedString(string: "Log in ", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18.0)])
        let attributedTitle = NSMutableAttributedString()
        attributedTitle.append(login)
        attributedTitle.append(iconString)
        btn.setAttributedTitle(attributedTitle, for: .normal)
        btn.layer.cornerRadius = 20
        btn.contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        btn.tintColor = .snow
        btn.backgroundColor = .mayaBlue
        btn.setTitleColor(.snow, for: .normal)
        btn.contentHorizontalAlignment = .trailing
        btn.clipsToBounds = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let serverViewsTagOffset = 31
    
    var advancedContentHeightConstraint: NSLayoutConstraint?

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
        
        let gradient = CAGradientLayer()
        
        gradient.frame = view.bounds
        gradient.colors = [UIColor.paleTurquoise.cgColor, UIColor.snow.cgColor]
        
        view.layer.insertSublayer(gradient, at: 0)
        
        view.addSubview(scrollView)
        
        btnAdvanced.addTarget(self, action: #selector(self.advancedButtonTapped), for: .touchUpInside)
        btnPlus.addTarget(self, action: #selector(self.plusButtonTapped), for: .touchUpInside)
        btnMinus.addTarget(self, action: #selector(self.minusButtonTapped), for: .touchUpInside)
        btnLogin.addTarget(self, action: #selector(self.loginButtonTapped), for: .touchUpInside)
        
        scrollView.addSubview(contentView)
        
        contentView.addSubview(lblInstructions)
        
        contentView.addSubview(lblUsername)
        
        contentView.addSubview(lblErrorUsername)
        
        contentView.addSubview(txtUsername)
        
        contentView.addSubview(lblPassword)
        
        contentView.addSubview(lblErrorPassword)
        
        contentView.addSubview(txtPassword)
        
        contentView.addSubview(advancedContentView)
        
        advancedContentView.addSubview(txtProfileId)
        advancedContentView.addSubview(lblProfileId)
        advancedContentView.addSubview(lblErrorProfileId)
        
        advancedContentView.addSubview(btnPlus)
        advancedContentView.addSubview(btnMinus)
        
        contentView.addSubview(btnLogin)
        
        NSLayoutConstraint.activate([
            
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 50),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            lblInstructions.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            lblInstructions.topAnchor.constraint(equalTo: contentView.topAnchor),
            lblInstructions.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            txtUsername.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            txtUsername.topAnchor.constraint(equalTo: lblInstructions.bottomAnchor, constant: 40),
            txtUsername.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            txtUsername.heightAnchor.constraint(equalToConstant: 50),
            
            lblUsername.leadingAnchor.constraint(equalTo: txtUsername.leadingAnchor, constant: 3),
            lblUsername.bottomAnchor.constraint(equalTo: txtUsername.topAnchor, constant: -3),
            
            lblErrorUsername.trailingAnchor.constraint(equalTo: txtUsername.trailingAnchor, constant: -3),
            lblErrorUsername.bottomAnchor.constraint(equalTo: txtUsername.topAnchor, constant: -3),
    
            txtPassword.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            txtPassword.topAnchor.constraint(equalTo: txtUsername.bottomAnchor, constant: 30),
            txtPassword.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            txtPassword.heightAnchor.constraint(equalToConstant: 50),
            
            lblPassword.leadingAnchor.constraint(equalTo: txtPassword.leadingAnchor, constant: 3),
            lblPassword.bottomAnchor.constraint(equalTo: txtPassword.topAnchor, constant: -3),
            
            lblErrorPassword.trailingAnchor.constraint(equalTo: txtPassword.trailingAnchor, constant: -3),
            lblErrorPassword.bottomAnchor.constraint(equalTo: txtPassword.topAnchor, constant: -3),
                
            btnPlus.bottomAnchor.constraint(equalTo: advancedContentView.bottomAnchor),
            btnPlus.heightAnchor.constraint(equalToConstant: 20),
            btnPlus.widthAnchor.constraint(equalToConstant: 20),
            btnPlus.leadingAnchor.constraint(equalTo: advancedContentView.leadingAnchor, constant: 25),
            
            btnMinus.bottomAnchor.constraint(equalTo: advancedContentView.bottomAnchor),
            btnMinus.heightAnchor.constraint(equalToConstant: 20),
            btnMinus.widthAnchor.constraint(equalToConstant: 20),
            btnMinus.leadingAnchor.constraint(equalTo: btnPlus.trailingAnchor, constant: 8),

            btnLogin.topAnchor.constraint(equalTo: advancedContentView.bottomAnchor, constant: 20),
            btnLogin.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            btnLogin.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
        ])
        
    }
    
    @objc func advancedButtonTapped(sender: UIButton) {
        presenter.advancedTapped()
    }
    
    @objc func plusButtonTapped(sender: UIButton) {
        presenter.plusTapped()
    }
    
    @objc func minusButtonTapped(sender: UIButton) {
        presenter.minusTapped()
    }
    
    @objc func loginButtonTapped(sender: UIButton) {
        presenter.loginTapped()
    }
    
    func prefill(with: ProfileLoginViewModel?) {
        let advancedEnabled = with != nil
        
        txtUsername.text = with?.username ?? ""
        
        txtProfileId.text = with?.profileId ?? ""
        
        var serverUIItems = (with?.servers ?? []).map { item in
            (lblServer(), txtServer(item), lblErrorServer())
        }
        
        if serverUIItems.isEmpty {
            serverUIItems.append((lblServer(), txtServer(""), lblErrorServer()))
        }
        
        for serverUIItem in serverUIItems {
            advancedContentView.addSubview(serverUIItem.1)
            advancedContentView.addSubview(serverUIItem.0)
            advancedContentView.addSubview(serverUIItem.2)
        }

        if advancedEnabled {
            contentView.addSubview(btnAdvanced)
            NSLayoutConstraint.activate([
                btnAdvanced.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
                btnAdvanced.topAnchor.constraint(equalTo: txtPassword.bottomAnchor, constant: 20),
                btnAdvanced.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            ])
        }
        
        let targetAnchor = advancedEnabled ? btnAdvanced.bottomAnchor : txtPassword.bottomAnchor
        
        let advancedContentHeight = advancedEnabled ? 0 : advancedContentHeightCalc()
        
        advancedContentHeightConstraint = advancedContentView.heightAnchor.constraint(equalToConstant: CGFloat(advancedContentHeight))
        
        NSLayoutConstraint.activate([
            
            advancedContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            advancedContentView.topAnchor.constraint(equalTo: targetAnchor),
            advancedContentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            advancedContentHeightConstraint!,
            
            txtProfileId.leadingAnchor.constraint(equalTo: advancedContentView.leadingAnchor, constant: 12),
            txtProfileId.topAnchor.constraint(equalTo: advancedContentView.topAnchor, constant: 30),
            txtProfileId.trailingAnchor.constraint(equalTo: advancedContentView.trailingAnchor, constant: -12),
            txtProfileId.heightAnchor.constraint(equalToConstant: 50),
            
            lblProfileId.leadingAnchor.constraint(equalTo: txtProfileId.leadingAnchor, constant: 3),
            lblProfileId.bottomAnchor.constraint(equalTo: txtProfileId.topAnchor, constant: -3),
            
            lblErrorProfileId.trailingAnchor.constraint(equalTo: txtProfileId.trailingAnchor, constant: -3),
            lblErrorProfileId.bottomAnchor.constraint(equalTo: txtProfileId.topAnchor, constant: -3),
            
        ])
        
        var lastItem: (UILabel, UITextField, UILabel)?
            
        for item in serverUIItems {
            let lastItemBottomAnchor = lastItem == nil ? txtProfileId.bottomAnchor : lastItem!.1.bottomAnchor
            NSLayoutConstraint.activate([
                item.1.leadingAnchor.constraint(equalTo: advancedContentView.leadingAnchor, constant: 12),
                item.1.topAnchor.constraint(equalTo: lastItemBottomAnchor, constant: 30),
                item.1.trailingAnchor.constraint(equalTo: advancedContentView.trailingAnchor, constant: -12),
                item.1.heightAnchor.constraint(equalToConstant: 50),
                
                item.0.leadingAnchor.constraint(equalTo: item.1.leadingAnchor, constant: 3),
                item.0.bottomAnchor.constraint(equalTo: item.1.topAnchor, constant: -3),
                
                item.2.trailingAnchor.constraint(equalTo: item.1.trailingAnchor, constant: -3),
                item.2.bottomAnchor.constraint(equalTo: item.1.topAnchor, constant: -3),
            ])
            lastItem = item
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let gradLayers = view.layer.sublayers?.compactMap { $0 as? CAGradientLayer }
        gradLayers?.first?.frame = view.bounds
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        presenter.onViewLoad()
        
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
            
            var advancedFields = advancedContentView.subviews.filter { v in v is UITextField }
            
            advancedFields.append(contentsOf: [txtUsername, txtPassword])
            
            let activeField: UIView? = advancedFields.first { $0.isFirstResponder }
            if let activeField = activeField {
                if !aRect.contains(activeField.frame.origin) {
                    let scrollPoint = CGPoint(x: 0, y: activeField.frame.origin.y-(endFrame?.size.height ?? 0.0))
                    scrollView.setContentOffset(scrollPoint, animated: true)
                }
            }
        }
    }
    
    func isAdvancedShown() -> Bool {
        return advancedContentHeightConstraint?.constant ?? 0 > 0
    }
    
    func showAdvanced() {
        let selectedIconString = NSAttributedString.fontAwesomeIcon(icon: "\u{f106}", textColor: .lightGray, size: CGFloat(14.0))
        let advancedSettings = NSAttributedString(string: "Advanced Settings ")
        let selectedTitle = NSMutableAttributedString()
        selectedTitle.append(advancedSettings)
        selectedTitle.append(selectedIconString)
        advancedContentHeightConstraint!.constant = advancedContentHeightCalc()
        UIView.animate(withDuration: 0.3) {
            self.scrollView.layoutIfNeeded()
        }
        btnAdvanced.setAttributedTitle(selectedTitle, for: .normal)
    }
    
    func hideAdvanced() {
        let iconString = NSAttributedString.fontAwesomeIcon(icon: "\u{f107}", textColor: .lightGray, size: CGFloat(14.0))
        let advancedSettings = NSAttributedString(string: "Advanced Settings ")
        let attributedTitle = NSMutableAttributedString()
        attributedTitle.append(advancedSettings)
        attributedTitle.append(iconString)
        advancedContentHeightConstraint!.constant = 0
        UIView.animate(withDuration: 0.3) {
            self.scrollView.layoutIfNeeded()
        }
        btnAdvanced.setAttributedTitle(attributedTitle, for: .normal)
    }
    
    private func advancedContentHeightCalc() -> CGFloat {
        return CGFloat((advancedContentView.subviews.filter { v in v is UITextField }.count) * 80) + 28
    }
    
    func addServerField() {
        let label = lblServer()
        let field = txtServer("")
        let errorLabel = lblErrorServer()
        label.alpha = 0.0
        field.alpha = 0.0
        errorLabel.alpha = 0.0
        let lastTextField = advancedContentView.subviews.filter { v in v is UITextField }.last!
        advancedContentView.addSubview(label)
        advancedContentView.addSubview(field)
        advancedContentView.addSubview(errorLabel)
        NSLayoutConstraint.activate([
            field.leadingAnchor.constraint(equalTo: advancedContentView.leadingAnchor, constant: 12),
            field.topAnchor.constraint(equalTo: lastTextField.bottomAnchor, constant: 30),
            field.trailingAnchor.constraint(equalTo: advancedContentView.trailingAnchor, constant: -12),
            field.heightAnchor.constraint(equalToConstant: 50),
            
            label.leadingAnchor.constraint(equalTo: field.leadingAnchor, constant: 3),
            label.bottomAnchor.constraint(equalTo: field.topAnchor, constant: -3),
            
            errorLabel.trailingAnchor.constraint(equalTo: field.trailingAnchor, constant: -3),
            errorLabel.bottomAnchor.constraint(equalTo: field.topAnchor, constant: -3),
        ])
        self.scrollView.layoutIfNeeded()
        advancedContentHeightConstraint!.constant = advancedContentHeightCalc()
        UIView.animate(withDuration: 0.2) {
            label.alpha = 1.0
            field.alpha = 1.0
            errorLabel.alpha = 1.0
            self.scrollView.layoutIfNeeded()
        }
    }
    
    func removeServerField() {
        let labels = advancedContentView.subviews.filter { v in v is UILabel }
        let lastLabel1 = labels[labels.count - 2]
        let lastLabel2 = labels[labels.count - 1]
        let lastTextField = advancedContentView.subviews.filter { v in v is UITextField }.last!
        let item = (lastLabel1, lastTextField, lastLabel2)
        advancedContentHeightConstraint!.constant = advancedContentHeightCalc() - 80
        UIView.animate(withDuration: 0.2, animations: {
            item.0.alpha = 0.0
            item.1.alpha = 0.0
            item.2.alpha = 0.0
            self.scrollView.layoutIfNeeded()
        }, completion: { r in
            item.0.removeFromSuperview()
            item.1.removeFromSuperview()
            item.2.removeFromSuperview()
            self.scrollView.layoutIfNeeded()
        })
    }
    
    func getCurrentItem() -> ProfileLoginViewModel {
        
        let servers = advancedContentView.subviews
            .filter { v in v is UITextField && v != txtProfileId }
            .map { v in (v as! UITextField).text ?? "" }
            
        return ProfileLoginViewModel(username: txtUsername.text ?? "", password: txtPassword.text ?? "", profileId: txtProfileId.text ?? "", servers: servers)
        
    }
    
    func showErrorUsername(errorString: String) {
        lblErrorUsername.text = errorString
    }
    
    func showErrorPassword(errorString: String) {
        lblErrorPassword.text = errorString
    }
    
    func showErrorProfileId(errorString: String) {
        lblErrorProfileId.text = errorString
    }
    
    func showErrorServer(index: Int, errorString: String) {
        let labels = advancedContentView.subviews
            .filter { v in v is UILabel && v != lblProfileId && v != lblErrorProfileId }
            .map { v in v as! UILabel }
        labels[(index * 2) + 1].text = errorString
    }
    
    func clearErrors() {
        lblErrorUsername.text = ""
        lblErrorPassword.text = ""
        lblErrorProfileId.text = ""
        let labels = advancedContentView.subviews
            .filter { v in v is UILabel && v != lblProfileId && v != lblErrorProfileId }
            .map { v in v as! UILabel }
        for index in stride(from: labels.count - 1, to: 0, by: -2) {
            labels[index].text = ""
        }
    }
    

    
    func viewController() -> UIViewController {
        return self
    }
    
}
