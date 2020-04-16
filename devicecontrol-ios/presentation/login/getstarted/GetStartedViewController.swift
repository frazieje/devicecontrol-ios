import UIKit

class GetStartedViewController : UIViewController, GetStartedView {
    
    let iconViewHome: UIImageView = {
        let view = UIImageView()
        view.image = UIImage.fontAwesomeIcon(icon: "\u{f015}", textColor: .lightGray, size: CGSize(width: 200, height: 200))
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let maskView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let iconViewUser: UIImageView = {
        let view = UIImageView()
        view.image = UIImage.fontAwesomeIcon(icon: "\u{f007}", textColor: UIColor.init(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.0), size: CGSize(width: 85, height: 85))
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let lblInstructions: UILabel = {
        let lbl = UILabel()
        lbl.text = "How do you want to log in?"
        lbl.textAlignment = .center
        lbl.textColor = .some(UIColor.init(red: 0.32, green: 0.32, blue: 0.32, alpha: 1.0))
        lbl.clipsToBounds = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let btnFindNearby: UIButton = {
        let btn = UIButton(type: .roundedRect)
        let iconString = NSAttributedString.fontAwesomeIcon(icon: "\u{f1eb}", textColor: .white, size: CGFloat(18.0))
        let find = NSMutableAttributedString(string: "   Find a Nearby Profile", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18.0)])
        let attributedTitle = NSMutableAttributedString()
        attributedTitle.append(iconString)
        attributedTitle.append(find)
        btn.setAttributedTitle(attributedTitle, for: .normal)
        btn.backgroundColor = .systemTeal
        btn.tintColor = .white
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 20
        btn.contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        btn.contentHorizontalAlignment = .center
        btn.clipsToBounds = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let btnEnter: UIButton = {
        let btn = UIButton(type: .roundedRect)
        let iconString = NSAttributedString.fontAwesomeIcon(icon: "\u{f11c}", textColor: .white, size: CGFloat(18.0))
        let enterDetails = NSMutableAttributedString(string: "   Enter Details", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18.0)])
        let attributedTitle = NSMutableAttributedString()
        attributedTitle.append(iconString)
        attributedTitle.append(enterDetails)
        btn.setAttributedTitle(attributedTitle, for: .normal)
        btn.layer.cornerRadius = 20
        btn.contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        btn.tintColor = .white
        btn.backgroundColor = .systemTeal
        btn.setTitleColor(.white, for: .normal)
        btn.contentHorizontalAlignment = .center
        btn.clipsToBounds = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let presenter: GetStartedPresenter
    
    init(presenter: GetStartedPresenter) {
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
        gradient.colors = [UIColor.init(red: 0.99, green: 0.99, blue: 0.99, alpha: 1.0).cgColor, UIColor.init(red: 0.80, green: 0.80, blue: 0.80, alpha: 1.0).cgColor]

        view.layer.insertSublayer(gradient, at: 0)

        view.addSubview(iconViewHome)
        
        view.addSubview(maskView)
        
        view.addSubview(iconViewUser)
        
        view.addSubview(lblInstructions)
        
        view.addSubview(btnFindNearby)
        
        btnFindNearby.addTarget(self, action: #selector(self.btnFindNearbyTapped), for: .touchUpInside)
        
        view.addSubview(btnEnter)
        
        btnEnter.addTarget(self, action: #selector(self.btnEnterTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
        
            iconViewHome.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            iconViewHome.heightAnchor.constraint(equalToConstant: 200),
            iconViewHome.widthAnchor.constraint(equalToConstant: 200),
            iconViewHome.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            maskView.topAnchor.constraint(equalTo: iconViewHome.topAnchor, constant: 108),
            maskView.heightAnchor.constraint(equalToConstant: 60),
            maskView.widthAnchor.constraint(equalToConstant: 40),
            maskView.centerXAnchor.constraint(equalTo: iconViewHome.centerXAnchor),
            
            iconViewUser.topAnchor.constraint(equalTo: iconViewHome.topAnchor, constant: 85),
            iconViewUser.heightAnchor.constraint(equalToConstant: 85),
            iconViewUser.widthAnchor.constraint(equalToConstant: 85),
            iconViewUser.centerXAnchor.constraint(equalTo: iconViewHome.centerXAnchor),
            
            lblInstructions.topAnchor.constraint(equalTo: iconViewHome.bottomAnchor, constant: 40),
            lblInstructions.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            lblInstructions.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            btnFindNearby.topAnchor.constraint(equalTo: lblInstructions.bottomAnchor, constant: 40),
            //btnFindNearby.widthAnchor.constraint(equalToConstant: 300),
            btnFindNearby.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            btnEnter.topAnchor.constraint(equalTo: btnFindNearby.bottomAnchor, constant: 20),
            //btnEnter.widthAnchor.constraint(equalToConstant: 300),
            btnEnter.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        
        ])
        
        
    }
    
    @objc func btnFindNearbyTapped(sender: UIButton) {
        presenter.findNearbyClicked()
    }
    
    @objc func btnEnterTapped(sender: UIButton) {
        presenter.enterDetailsClicked()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.onViewAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter.onViewDisappear()
    }
    
    func viewController() -> UIViewController {
        return self
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
    }
    
}
