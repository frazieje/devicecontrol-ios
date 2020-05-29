import UIKit

class HomeViewController : UIViewController, HomeView {

    init() {
        
        let homeIcon = UIImage.fontAwesomeIcon(icon: "\u{f015}", textColor: .gray, size: CGSize(width: 25.0, height: 25.0))
        
        let homeSelectedIcon = UIImage.fontAwesomeIcon(icon: "\u{f015}", textColor: .blue, size: CGSize(width: 25.0, height: 25.0))
        
        super.init(nibName: nil, bundle: nil)
        
        tabBarItem = UITabBarItem(title: "Home", image: homeIcon, selectedImage: homeSelectedIcon)
        
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
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        print("Home viewDidLoad")
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("Home viewDidAppear")
    }
    
    func viewController() -> UIViewController {
        return self
    }

}
