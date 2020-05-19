import UIKit

class HomeViewController : UIViewController, HomeView {

    weak var testView: UIView!
    
    init() {
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
        
        let homeIcon = UIImage.fontAwesomeIcon(icon: "\u{f015}", textColor: .gray, size: CGSize(width: 25.0, height: 25.0))
        
        let homeSelectedIcon = UIImage.fontAwesomeIcon(icon: "\u{f015}", textColor: .blue, size: CGSize(width: 25.0, height: 25.0))
        
        tabBarItem = UITabBarItem(title: "Home", image: homeIcon, selectedImage: homeSelectedIcon)
        
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
        
        testView.backgroundColor = .red
        
        title = "Home"
        
        print("Home viewDidLoad")
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("Home viewDidAppear")
    }
    
    func viewController() -> UIViewController {
        return self
    }

}
