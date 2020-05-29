import UIKit

class SettingsViewController : UIViewController, SettingsView {

    weak var testView: UIView!
    
    init() {
        
        let settingsIcon = UIImage.fontAwesomeIcon(icon: "\u{f013}", textColor: .gray, size: CGSize(width: 25.0, height: 25.0))

        let settingsSelectedIcon = UIImage.fontAwesomeIcon(icon: "\u{f013}", textColor: .blue, size: CGSize(width: 25.0, height: 25.0))
        
        super.init(nibName: nil, bundle: nil)
        
        tabBarItem = UITabBarItem(title: "Settings", image: settingsIcon, selectedImage: settingsSelectedIcon)
        
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
        
        let testView = UIView(frame: .zero)
        testView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(testView)
        
        NSLayoutConstraint.activate([
            testView.widthAnchor.constraint(equalToConstant: 64),
            testView.widthAnchor.constraint(equalTo: testView.heightAnchor),
            testView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            testView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            ])
        
        self.testView = testView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        testView.backgroundColor = .blue
        
        title = "Settings"
        
        print("Settings viewDidLoad")
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("Settings viewDidAppear")
    }
    
    func viewController() -> UIViewController {
        return self
    }
    
}
